.PHONY: help backend frontend test test-unit test-api test-frontend lint clean

help:
	@echo "OMNIVEST Commands:"
	@echo "  make backend       - Start the FastAPI service (:8123)"
	@echo "  make frontend      - Serve the Flutter web client (:8081)"
	@echo "  make test          - test-unit + test-api + test-frontend"
	@echo "  make test-unit     - Forensic math + watch-loop rules (no server)"
	@echo "  make test-api      - API smoke test (needs the backend running)"
	@echo "  make test-frontend - flutter analyze + widget/wire tests"
	@echo "  make lint          - flutter analyze (must be clean)"
	@echo "  make clean         - Remove caches and build artifacts"

backend:
	cd backend && ./.venv/bin/python run.py

frontend:
	cd frontend && flutter run -d web-server --web-port=8081 --release

# ── tests ────────────────────────────────────────────────────────────────────
# The product's claim is statistical integrity. If the forensics math or its
# wiring is wrong, the app is confidently lying to people about their money, so
# these run on every change and are not optional decoration.

test: test-unit test-api test-frontend

# Pure math, no server. Safe to run anywhere.
test-unit:
	@echo "── forensics math ──"
	cd backend && ./.venv/bin/python -m app.tests.test_forensics
	@echo "── execution forensics ──"
	cd backend && ./.venv/bin/python -m app.tests.test_execution
	@echo "── watch loop ──"
	cd backend && ./.venv/bin/python -m app.tests.test_watchloop

# Needs the service running (see `make backend`).
test-api:
	@echo "── API smoke test ──"
	cd backend && ./.venv/bin/python -m app.tests.test_api

# The wire contract between the Dart client and the Python service is pinned by
# tests; a drift there is a silent wrong answer.
test-frontend: lint
	@echo "── flutter test ──"
	cd frontend && flutter test

lint:
	@echo "── flutter analyze ──"
	cd frontend && flutter analyze

clean:
	find . -type d -name "__pycache__" -not -path "*/.venv/*" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -not -path "*/.venv/*" -delete 2>/dev/null || true
	rm -f backend/omnivest_journal.json
	cd frontend && flutter clean 2>/dev/null || true
