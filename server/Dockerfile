#use official python image
FROM python:3.11-slim

#set working directory inside container
WORKDIR /app

#copy requirements file to working directory
COPY requirements.txt .

#install dependencies
RUN pip install --no-cache-dir -r requirements.txt

#copy the rest of the application code to working directory
COPY . .

#expose port 8000 to the outside world
EXPOSE 8000

#command to run the application
CMD ["uvicorn","main:app", "--host","0.0.0.0","--port","8000"]