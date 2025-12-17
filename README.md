# InboxGrove - Development Setup

## Port Configuration
- **Frontend (Vite)**: `http://localhost:3013`
- **Backend (FastAPI)**: `http://localhost:8002`
- **PostgreSQL**: `localhost:5432`
- **Redis**: `localhost:6379`

## Quick Start

### Prerequisites
- Docker & Docker Compose
- Node.js 18+ and npm

### Running the Application

#### Option 1: Development Mode (Recommended)

**Terminal 1 - Backend Services:**
```bash
# Start PostgreSQL, Redis, and API
docker compose up postgres redis api
```

**Terminal 2 - Frontend Dev Server:**
```bash
# Install dependencies (first time only)
npm install

# Start Vite dev server
npm run dev
```

The application will be available at:
- Frontend: http://localhost:3013
- Backend API: http://localhost:8002/docs (Swagger UI)

#### Option 2: Full Docker Stack
```bash
# Start all services
docker compose up -d

# Frontend still needs to run separately
npm run dev
```

### Building for Production

```bash
# Build frontend
npm run build

# Preview production build
npm run preview

# Or serve with a static server
npx serve -s dist -l 3013
```

## Configuration Files

### Frontend
- `vite.config.ts` - Dev server port: 3013
- `services/trialApi.ts` - API base URL: http://localhost:8002

### Backend
- `backend/app/config.py` - CORS origins include port 3013
- `docker-compose.yml` - API service on port 8002

## Environment Variables

Create a `.env` file in the root directory (see `.env.example`):
```env
# Frontend
VITE_API_BASE_URL=http://localhost:8002

# Backend (in docker-compose.yml or backend/.env)
DATABASE_URL=postgresql://inboxgrove_user:password@postgres:5432/inboxgrove
REDIS_URL=redis://redis:6379/0
SECRET_KEY=your-secret-key
# ... other backend variables
```

## Troubleshooting

### Port Already in Use
If port 3013 or 8002 is already in use:
- Change frontend port in `vite.config.ts`
- Change backend port mapping in `docker-compose.yml` (e.g., `8003:8000`)
- Update `services/trialApi.ts` BASE_URL accordingly

### CORS Errors
Ensure `backend/app/config.py` includes your frontend URL in `CORS_ORIGINS`.

### Database Connection Issues
```bash
# Check if PostgreSQL is running
docker compose ps postgres

# View logs
docker compose logs postgres
```

## Notes
- Nginx has been removed from this setup
- Frontend runs via Vite dev server for development
- For production, build the frontend and serve with any static file server
