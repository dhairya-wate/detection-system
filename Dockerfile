FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.lock .
RUN pip install --no-cache-dir -r requirements.lock

COPY . .
RUN pip install --no-cache-dir --no-deps -e .

EXPOSE 5000

ENV HOST=0.0.0.0
ENV PORT=5000
ENV ALLOW_LAN=true

CMD ["python", "-m", "detection_system"]
