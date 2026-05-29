# Phase 1 & 9: Frontend Deployment
FROM python:3.11-slim

WORKDIR /app

# Install Streamlit and visualization libraries
RUN pip install --no-cache-dir \
    streamlit \
    requests \
    plotly \
    pandas

# Copy frontend application
COPY frontend_app.py /app/app.py

EXPOSE 8501
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]