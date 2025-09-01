from typing import List

from sentence_transformers import SentenceTransformer


class sortSourceService:
    def __init__(self):
        # instantiate the embedding model here
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")

    def sort_sources(self, query: str, search_results: List[dict]):
        query_embedding = self.embedding_model.encode(query)

        print(query_embedding)
