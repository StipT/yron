# yron_data

Data/API layer for Yron (pure Dart, no Flutter dependency).

- `ApiClient` — JSON HTTP client wrapper; throws `ApiException` on non-2xx.
- Add services (endpoint wrappers) and repositories (caching, SSOT) under `lib/src/`.

UI code depends on repositories, never on `ApiClient` directly.
