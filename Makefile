.PHONY: install test lint run clean

PYTHON ?= python

install:
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.lock
	$(PYTHON) -m pip install -e .

test:
	pytest -v

lint:
	ruff check .

run:
	$(PYTHON) -m detection_system

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	rm -rf build/ dist/ *.egg-info .ruff_cache/

