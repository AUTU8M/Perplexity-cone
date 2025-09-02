from typing import List

import numpy as np
from sentence_transformers import SentenceTransformer


class sortSourceService:
    def __init__(self):
        # instantiate the embedding model here
        self.embedding_model = SentenceTransformer("all-MiniLM-L6-v2")

    def sort_sources(self, query: str, search_results: List[dict]) -> List[dict]:
        try:
            relevent_docs = []
            if not query or query.strip() == "":
                print("Warning: Query is empty or None")
                return []

            query_embedding = self.embedding_model.encode(query)

            # now loop over every search result and get the content and embed it
            for i, res in enumerate(search_results):
                content = res.get("content")
                if not content or content.strip() == "":
                    print(f"Skipping result {i}: No content available")
                    continue

                res_embedding = self.embedding_model.encode(content)

                similarity =float( np.dot(query_embedding, res_embedding) / (
                    np.linalg.norm(query_embedding) * np.linalg.norm(res_embedding)
                ))

                res["relavance_score"] = similarity
                # filter the documents
                if similarity > 0.3:
                    relevent_docs.append(res)

            return sorted(relevent_docs, key=lambda x: x["relavance_score"], reverse=True)
        except Exception as e:
            print(f"Error in sort_sources: {e}")
            return []