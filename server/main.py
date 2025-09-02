from fastapi import FastAPI, WebSocket

from pydantic_model.chat_body import ChatBody
from services.llm_service import LLMService
from services.search_service import SearchService
from services.sort_source_service import sortSourceService

app = FastAPI()

# instantiate services
search_service = SearchService()
# instantiate the sort source service
sort_source_service = sortSourceService()
# use llm to answer the question
llm_service = LLMService()


# for our uses we gon use websocket
@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):
    await websocket.accept()

    try:
        data = await websocket.receive_json()
        query = data.get("query")

        search_results = search_service.web_search(query)
        sorted_results = sort_source_service.sort_sources(query, search_results)

        # Check if connection is still active before sending
        if websocket.client_state.name != "DISCONNECTED":
            await websocket.send_json({"type": "search_results", "data": sorted_results})

            # Use the streaming method for WebSocket
            for chunk in llm_service.generate_response_stream(query, sorted_results):
                # Check connection state before each send
                if websocket.client_state.name == "DISCONNECTED":
                    break
                await websocket.send_json({"type": "content", "data": chunk})
            
            # Send completion signal
            if websocket.client_state.name != "DISCONNECTED":
                await websocket.send_json({"type": "complete", "data": "Response completed"})
                
    except Exception as e:
        print(f"Unexpected error occurred: {e}")
    finally:
        # Only close if the connection is not already closed
        try:
            if websocket.client_state.name != "DISCONNECTED":
                await websocket.close()
        except Exception as e:
            # Connection might already be closed, which is fine
            print(f"Error closing websocket: {e}")


# chat endpoint
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    search_results = search_service.web_search(body.query)
    sorted_results = sort_source_service.sort_sources(body.query, search_results)
    response = llm_service.generate_response(body.query, sorted_results)

    return response
