from fastapi import FastAPI

from pydantic_model.chat_body import ChatBody
from services.search_service import SearchService

app = FastAPI()

#instantiate services
search_service = SearchService()

#chat endpoint
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    search_service.web_search(body.query)
    return body.query