FROM python:3.11-slim

# Node.js + system tools installieren
RUN apt-get update && \
    apt-get install -y curl git build-essential gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Arbeitsverzeichnis
WORKDIR /workspace

# Python-Abhängigkeiten
COPY backend/requirements.txt ./backend/
RUN pip install --upgrade pip && \
    pip install -r ./backend/requirements.txt || true

# React-Projekt vorbereiten (nur wenn leer)
RUN test -f frontend/package.json || \
    (cd /workspace && npm create vite@latest frontend -- --template react-ts && \
     cd frontend && npm install)

CMD ["sleep", "infinity"]
