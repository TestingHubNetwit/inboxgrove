# InboxGrove - Production Ready

## Quick Start (Production on Server)

### One-Command Deployment
```bash
# Clone the repository
git clone https://github.com/TestingHubNetwit/inboxgrove.git
cd inboxgrove

# Start everything
docker compose up -d --build
```

That's it! The application will be available at:
- **Frontend**: http://94.250.203.249:3013
- **Backend API**: http://94.250.203.249:8002
- **API Docs**: http://94.250.203.249:8002/docs

## Configuration

### Environment Variables
The `.env` file contains all configuration. Key settings:

```env
SERVER_IP=94.250.203.249
VITE_API_BASE_URL=http://94.250.203.249:8002

# Database
POSTGRES_USER=inboxgrove_user
POSTGRES_PASSWORD=secure_password_change_in_production

# Security (CHANGE IN PRODUCTION!)
SECRET_KEY=change-me-in-production-use-strong-random-key
JWT_SECRET=change-me-in-production-use-strong-random-key
```

**⚠️ IMPORTANT**: Change the security keys before deploying to production!

### Ports
- Frontend: `3013`
- Backend API: `8002`
- PostgreSQL: `5432` (internal only)
- Redis: `6379` (internal only)

## Management Commands

```bash
# View logs
docker compose logs -f

# View specific service logs
docker compose logs -f api
docker compose logs -f frontend

# Restart services
docker compose restart

# Stop everything
docker compose down

# Stop and remove volumes (⚠️ deletes database)
docker compose down -v

# Rebuild and restart
docker compose up -d --build
```

## Development Mode (Local)

If you want to run in development mode on your local machine:

```bash
# Terminal 1 - Backend
docker compose up postgres redis api

# Terminal 2 - Frontend (with hot reload)
npm install
npm run dev
```

Access at:
- Frontend: http://localhost:3013
- Backend: http://localhost:8002

## Architecture

```
┌─────────────────────────────────────────┐
│  Frontend (Vite + React)                │
│  Port: 3013                             │
│  Container: inboxgrove_frontend         │
└─────────────────┬───────────────────────┘
                  │
                  │ HTTP Requests
                  ▼
┌─────────────────────────────────────────┐
│  Backend API (FastAPI)                  │
│  Port: 8002                             │
│  Container: inboxgrove_api              │
└─────┬───────────────────────────────────┘
      │
      ├──► PostgreSQL (port 5432)
      ├──► Redis (port 6379)
      └──► Celery Workers
```

## Troubleshooting

### Port Already in Use
```bash
# Check what's using the port
lsof -i :3013
lsof -i :8002

# Kill the process or change ports in .env
```

### Database Connection Issues
```bash
# Check if PostgreSQL is running
docker compose ps postgres

# View PostgreSQL logs
docker compose logs postgres

# Restart database
docker compose restart postgres
```

### Frontend Not Loading
```bash
# Check frontend logs
docker compose logs frontend

# Rebuild frontend
docker compose up -d --build frontend
```

### API Errors
```bash
# Check API logs
docker compose logs api

# Check if database is ready
docker compose exec postgres pg_isready

# Restart API
docker compose restart api
```

## Security Checklist for Production

- [ ] Change `SECRET_KEY` in `.env`
- [ ] Change `JWT_SECRET` in `.env`
- [ ] Change `POSTGRES_PASSWORD` in `.env`
- [ ] Set up firewall rules (allow only 3013, 8002)
- [ ] Configure HTTPS/SSL (use reverse proxy like Nginx or Caddy)
- [ ] Set up backup for PostgreSQL database
- [ ] Configure monitoring and logging

## Backup & Restore

### Backup Database
```bash
docker compose exec postgres pg_dump -U inboxgrove_user inboxgrove > backup.sql
```

### Restore Database
```bash
cat backup.sql | docker compose exec -T postgres psql -U inboxgrove_user inboxgrove
```

## Updating

```bash
# Pull latest changes
git pull origin main

# Rebuild and restart
docker compose up -d --build
```
