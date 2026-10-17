# Changelog

All notable changes to the OMNIVEST service, newest first. This is the FastAPI half;
the Flutter client has its own changelog at
[`../frontend/CHANGELOG.md`](../frontend/CHANGELOG.md).

## 2026-10-17 — documentation standard

- Added `README.md`, `AGENTS.md`, `STATE.md`, `docs/README.md` and this changelog.
- Added `app/tests/conftest.py` with `collect_ignore = ["test_api.py"]` so a bare
  `pytest app/tests` runs the unit suite instead of collecting the live-server smoke
  test. Product code unchanged.

## Earlier — the service

- FastAPI MVP: 31 routes, and a JSON-file journal with a matching undo for every write.
- SAFE mode on by default; ratings, price targets and guaranteed-return language
  blocked at the output boundary.
- Pydantic models reject unknown fields, so a typo cannot silently become a confident
  verdict computed from defaults.
- Execution forensics: prices the impatience in fills rather than asking about it.
- All 12 watch-loop rules implemented with a drift-proof registry.
- Synthetic bars are labelled: when real data is unavailable the response carries a
  `NO_DATA` verdict and a `data_warning` rather than filled-in numbers.
