from config import Settings
from tavily import TavilyClient
import trafilatura  # for web scraping

settings = Settings()
# tavily clinet job was just to get the url
tavily_client = TavilyClient(api_key=settings.TAVILY_API_KEY)


class SearchService:
    def web_search(self, query: str):
        results = []
        # search with tavily api , max results is 10(part of the api)
        response = tavily_client.search(query, max_results=10)
        # get the results if not just a empty list
        search_results = response.get("results", [])

        # now use the trafilatura to scrape data the web pages
        for result in search_results:
            downloaded = trafilatura.fetch_url(result.get("url")) 
            # extract the content
            content = trafilatura.extract(downloaded, include_comments=False)

            results.append(
                {
                    "title": result.get("title", ""),
                    "url": result.get("url"),
                    "content": content,
                }
            )  

        return results
