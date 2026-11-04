FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install lightweight PyTorch CPU wheels to minimize image size and build times
RUN pip install --no-cache-dir torch==2.6.0 torchvision==0.21.0 --index-url https://download.pytorch.org/whl/cpu

COPY requirements.lock .
RUN pip install --no-cache-dir -r requirements.lock

COPY . .
RUN pip install --no-cache-dir --no-deps -e .

EXPOSE 5000

ENV HOST=0.0.0.0
ENV PORT=5000
ENV ALLOW_LAN=true
ENV MOBILE_ENABLED=true
ENV DETECTION_ENV=production

CMD ["python", "-m", "detection_system"]
