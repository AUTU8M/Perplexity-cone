from fastapi import FastAPI

from pydantic_model.chat_body import ChatBody
from services.search_service import SearchService
from services.sort_source_service import sortSourceService

app = FastAPI()

# instantiate services
search_service = SearchService()
#instantiate the sort source service
sort_source_service = sortSourceService()

# chat endpoint
@app.post("/chat")
def chat_endpoint(body: ChatBody):
    search_results = search_service.web_search(body.query)
    sort_source_service.sort_sources(body.query, search_results)

    return body.query
