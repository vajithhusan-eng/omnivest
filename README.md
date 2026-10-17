# OMNIVEST

[![Python](https://img.shields.io/badge/Python-3.14-3776AB?logo=python&logoColor=white)](backend)
[![FastAPI](https://img.shields.io/badge/FastAPI-API-009688?logo=fastapi&logoColor=white)](backend)
[![Flutter](https://img.shields.io/badge/Flutter-web%20terminal-02569B?logo=flutter&logoColor=white)](frontend)
[![Unit checks](https://img.shields.io/badge/unit-143%20checks-brightgreen)](backend/app/tests/)
[![API checks](https://img.shields.io/badge/API-168%20checks-brightgreen)](backend/app/tests/test_api.py)
[![Safe by default](https://img.shields.io/badge/advice-blocked%20by%20default-success)](backend/app/guardrails.py)

**Free knowledge, self-analytics, and a journal you can correct** — a market
forensics terminal. Python + FastAPI on one side, a Flutter web client on the
other. No database server: the journal is a JSON file on disk.

```bash
cd backend  && python -m venv .venv && ./.venv/bin/pip install -r requirements.txt && ./.venv/bin/python run.py   # :8123
cd frontend && flutter pub get && flutter run -d web-server --web-port 8081                                       # :8081
```

## The two ideas it is built around

**Education, not advice.** `backend/app/guardrails.py` runs in **SAFE mode by
default**: trading calls, ratings, price targets and "guaranteed" language are
blocked before they reach a response, and `/api/health` reports
`"safe_mode": true`. ADVISER mode is for a registered IA/RA partner and is off
unless explicitly switched on.

**Synthetic data says so.** When real bars are unavailable, the response carries
a `NO_DATA` verdict and a `data_warning`. Plausible-looking numbers are never
invented to fill a gap — the failure mode of a finance tool is being confidently
wrong about someone's money, so the honest empty answer is the default.

## What it computes

Self-analytics over *your own* actions, not market predictions:

- **Execution forensics** — prices the impatience in your fills rather than
  asking you about it; classifies orders against your stated intent.
- **Portfolio forensics** — autopsy of a drawdown, momentum-crash risk, and PBO
  (probability of backtest overfitting) via CSCV.
- **A watch loop over rules you wrote** — 12 rules held in a drift-proof
  registry.
- **A journal** you can correct — corrections are recorded, not overwritten.

## Layout

| Path | What it is |
|---|---|
| `backend/` | FastAPI service, 31 routes in `app/main.py`, runs on `:8123` |
| `frontend/` | Flutter web terminal, talks to the API above, served on `:8081` |

Each half has its own `README.md`, `AGENTS.md`, `STATE.md` and `docs/`.

## Verification

```bash
cd backend  && ./.venv/bin/python -m pytest app/tests -q   # 55 tests, no server
make test-unit                                            # 143 checks, no server
cd frontend && flutter test                                # 165 tests
```

`backend/app/tests/test_api.py` is a 168-check end-to-end smoke test that drives
`httpx` against a **live** server, so `backend/app/tests/conftest.py` excludes it
from pytest collection. Run it against a booted server instead:

```bash
cd backend && ./.venv/bin/python run.py &
cd backend && ./.venv/bin/python -m app.tests.test_api
```

CI runs the backend unit suite and the frontend analyze + test on every push.

## Env vars

| Var | Default | Meaning |
|---|---|---|
| `OMNIVEST_PORT` | `8123` | Listen port |
| `OMNIVEST_RELOAD` | `1` | Uvicorn auto-reload |
| `OMNIVEST_ADVISER_MODE` | `0` | `1` disables the SAFE-mode guardrails |

`OMNIVEST_ADVISER_MODE` is read at **import time**, so changing it needs a
restart. Endpoint-by-endpoint detail: [`backend/README.md`](backend/README.md).

## Licence

MIT — see [`LICENSE`](LICENSE).
