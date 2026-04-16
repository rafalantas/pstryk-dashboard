# Pstryk Dashboard

Monitorowanie energii z Pstryk — ceny godzinowe, dane fazowe L1/L2/L3, zużycie i koszty.

## Stos

- **Frontend** — HTML/CSS/JS + Chart.js (bez frameworków)
- **Serwer** — nginx:alpine
- **Zmienne runtime** — `envsubst` generuje `env.js` przy starcie kontenera
- **Deploy** — Portainer buduje obraz bezpośrednio z tego repo (bez CI/CD)

---

## Zmienne środowiskowe

Ustaw je w Portainerze w sekcji **Environment variables** przy deployowaniu stacka.

| Zmienna | Opis | Wymagana |
|---|---|---|
| `PSTRYK_API_KEY` | Klucz API z aplikacji Pstryk | ✅ tak |
| `PSTRYK_METER_IP` | IP miernika w sieci LAN (dane fazowe) | opcjonalna |
| `PSTRYK_METER_PORT` | Port API miernika | opcjonalna (domyślnie `80`) |

**Gdzie znaleźć klucz API:** Pstryk app → Konto → Urządzenia i integracje → Klucz API

---

## Deploy przez Portainer (zalecane)

1. Wgraj kod na GitHub (publiczne lub prywatne repo)
2. Portainer → **Stacks** → **Add stack**
3. Wybierz zakładkę **Repository**
4. Wpisz URL repo i ścieżkę do `docker-compose.yml`
5. W sekcji **Environment variables** dodaj zmienne z tabeli powyżej
6. Kliknij **Deploy the stack** — Portainer sklonuje repo i zbuduje obraz

Przy kolejnych zmianach kodu: Portainer → Stack → **Pull and redeploy**.

---

## Lokalnie (bez Dockera)

```bash
cd www
python -m http.server 8000
# otwórz http://localhost:8000
```

## Lokalnie z Dockerem

```bash
docker compose up -d --build
```

Zmienne podaj w pliku `.env` (nie commituj go do repo!):

```env
PSTRYK_API_KEY=twój_klucz_api
PSTRYK_METER_IP=192.168.1.100
PSTRYK_METER_PORT=80
```

---

## Struktura projektu

```
pstryk-dashboard/
├── Dockerfile          # nginx:alpine + envsubst
├── docker-compose.yml  # konfiguracja dla Portainer
├── nginx.conf          # konfiguracja nginx
├── entrypoint.sh       # wstrzykuje ENV → env.js przy starcie
├── .dockerignore
├── .gitignore
└── www/
    ├── index.html          # aplikacja (cały frontend w jednym pliku)
    └── env.js.template     # template zmiennych (zastępowany przez envsubst)
```
