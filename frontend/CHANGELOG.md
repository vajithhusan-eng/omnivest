# Changelog

All notable changes to the OMNIVEST frontend, newest first. This is the Flutter web
client; the Python service it talks to has its own changelog at
[`../backend/CHANGELOG.md`](../backend/CHANGELOG.md).

## 2026-10-17 — documentation standard

- Added `AGENTS.md`, `STATE.md`, `docs/README.md` and this changelog. `README.md`
  predated the standard and already satisfied it, so it was left untouched.
- No product code changed.

## Earlier — the client

- Five tabs ordered by user need; Learn is a pushed route rather than a sixth tab.
- Transport failures, 422s and empty responses each get their own distinct,
  non-reassuring rendering; the wire contract is pinned by tests
  (`test/traces_test.dart`, `test/widget_test.dart`).
- A local chart engine with conditional imports so the web and stub paths stay one
  codebase.
