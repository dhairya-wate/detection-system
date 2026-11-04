import os
import sys
from pathlib import Path
import pytest

src_path = str(Path(__file__).resolve().parent.parent / "src" / "detection_system")
if src_path not in sys.path:
    sys.path.insert(0, src_path)

current_pp = os.environ.get("PYTHONPATH", "")
if src_path not in current_pp:
    os.environ["PYTHONPATH"] = f"{src_path}{os.pathsep}{current_pp}" if current_pp else src_path

TEST_OPERATOR_TOKEN = "secure_test_operator_token_9xK2mP7qR4vL8wZ1" # High-entropy operator token fixture
os.environ["DETECTION_OPERATOR_TOKEN"] = TEST_OPERATOR_TOKEN
TEST_SERVICE_TOKEN = "secure_test_service_token_8vK3mP7qR4vL8wZ2" # High-entropy service token fixture
os.environ["DETECTION_SERVICE_TOKEN"] = TEST_SERVICE_TOKEN
os.environ["DETECTION_ENV"] = "development"
os.environ["ECOWING_API_URL"] = "http://127.0.0.1:8080"
os.environ["MOBILE_ENABLED"] = "true"
os.environ["MAX_UPLOAD_SIZE_BYTES"] = str(5 * 1024 * 1024)
os.environ["ALLOW_LAN"] = "false"

@pytest.fixture(scope="session")
def operator_token():
    return TEST_OPERATOR_TOKEN

@pytest.fixture(scope="session")
def service_token():
    return TEST_SERVICE_TOKEN
