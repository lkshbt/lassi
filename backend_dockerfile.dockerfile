# Phase 1 & 9: Backend Deployment & Bio-tools Installation
FROM python:3.11-slim

# Install system dependencies and Bioinformatics tools
# fastqc, vsearch, ncbi-blast+, cutadapt (via pip later)
RUN apt-get update && apt-get install -y \
    fastqc \
    vsearch \
    ncbi-blast+ \
    default-jre \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies
# Includes packages for API, DB, and scientific calculation (pandas, scipy, biopython)
RUN pip install --no-cache-dir \
    fastapi \
    uvicorn \
    sqlalchemy \
    psycopg2-binary \
    python-multipart \
    biopython \
    pandas \
    numpy \
    scipy \
    reportlab \
    cutadapt

# Copy application files
COPY backend_main.py /app/main.py

# Create data directories for pipeline
RUN mkdir -p /app/data/uploads /app/data/results /app/data/blastdb

# Expose port and run server
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]