FROM python:3.11-slim 
 
RUN apt-get update && apt-get install -y --no-install-recommends nodejs npm curl && rm -rf /var/lib/apt/lists/* 
 
WORKDIR /app 
 
COPY package.json package-lock.json ./ 
COPY frontend/package.json frontend/package-lock.json ./frontend/ 
RUN npm ci && npm ci --prefix frontend 
 
COPY backend/pyproject.toml ./backend/ 
RUN pip install --no-cache-dir "flask>=3.0.0" "flask-cors>=6.0.0" "openai>=1.0.0" "camel-oasis==0.2.5" "camel-ai==0.2.78" "PyMuPDF>=1.24.0" "charset-normalizer>=3.0.0" "chardet>=5.0.0" "python-dotenv>=1.0.0" "pydantic>=2.0.0" 
 
COPY . . 
RUN mkdir -p /app/backend/data 
 
EXPOSE 3000 5001 
 
CMD ["npm", "run", "dev"]
