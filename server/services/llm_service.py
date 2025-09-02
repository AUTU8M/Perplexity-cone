import google.generativeai as genai
from typing import List
from config import Settings

settings = Settings()


class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel("gemini-2.5-flash")

    def generate_response(self, query: str, search_results: list[dict]):
        context_text = "\n\n".join(
            [
                f"Source {i+1} ({result['url']}) :\n{result['content']}"
                for i, result in enumerate(search_results)
            ]
        )

        full_prompt = f"""
        Context from web search:
        {context_text}

        Query: {query}

        please provide a concise and accurate answer based on the  above context.That it needs to think and reason deeply before answering.Ensure it answers the query the user is asking.Do not use your own knowledge until it is absolutely necessary. 
        
        
        """

        # For non-streaming response
        response = self.model.generate_content(full_prompt)
        return response.text
    
    def generate_response_stream(self, query: str, search_results: list[dict]):
        """Generate streaming response for WebSocket"""
        context_text = "\n\n".join(
            [
                f"Source {i+1} ({result['url']}) :\n{result['content']}"
                for i, result in enumerate(search_results)
            ]
        )

        full_prompt = f"""
        Context from web search:
        {context_text}

        Query: {query}

        please provide a concise and accurate answer based on the  above context.That it needs to think and reason deeply before answering.Ensure it answers the query the user is asking.Do not use your own knowledge until it is absolutely necessary. 
        
        
        """

        try:
            # Generate streaming response
            response = self.model.generate_content(full_prompt, stream=True)
            
            for chunk in response:
                if chunk.text:
                    yield chunk.text
        except Exception as e:
            yield f"Error generating response: {str(e)}"
