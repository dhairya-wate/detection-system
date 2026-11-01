# Detection System Architecture

The Detection System is a Python FastAPI microservice that processes live video streams and captured images to perform edge waste detection using YOLO neural network models.

## High-Level Architecture

```
[ Client / Web Browser / Drone Camera ]
                   │
                   ▼ (HTTP / WebSockets)
        FastAPI Edge Gateway (Port 5000)
                   │
       ┌───────────┴───────────┐
       ▼                       ▼
  VideoStreamManager      DetectionWorker (Thread)
       │                       │
       │                 WasteDetector (YOLO26n)
       │                       │
       │                       ▼
       │               Persistent Outbox (SQLite)
       │                       │
       ▼                       ▼ (Outbox Push)
  MJPEG /ws Stream    EcoWing Command Center
```

## Service Layout

- **`src/detection_system/`**: Core package source
  - `app.py`: FastAPI server definitions, routing, and WebSockets
  - `config.py`: Environment configuration and security boundaries
  - `detector.py`: YOLO waste classification and bounding box engine
  - `worker.py`: Asynchronous frame inference loop
  - `outbox.py`: Resilient SQLite transactional queue with exponential backoff
  - `video_stream.py`: Multi-source input handling (webcam, RTSP, video loop)
  - `web/`: Embedded web operator console and mobile broadcaster
  - `contracts/`: Runtime JSON schemas and canonical taxonomy
- **`tests/`**: Unit, integration, and contract tests with fixtures
- **`models/`**: Gitignored weights store for YOLO models

