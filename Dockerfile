FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.lock .

# Install dependencies using official PyTorch CPU wheel index to keep container light
RUN pip install --no-cache-dir \
    --extra-index-url https://download.pytorch.org/whl/cpu \
    "torch==2.6.0+cpu" \
    "torchvision==0.21.0+cpu" \
    -r requirements.lock

COPY . .
RUN pip install --no-cache-dir --no-deps -e .

# Expose Render standard port 10000 (and 5000 for local)
EXPOSE 10000
EXPOSE 5000

ENV HOST=0.0.0.0
ENV PORT=10000
ENV ALLOW_LAN=true
ENV MOBILE_ENABLED=true
ENV DETECTION_ENV=production

CMD ["python", "-m", "detection_system"]
