"""
Celery workers module.
Background tasks and scheduled jobs.
"""

from celery import Celery
from app.config import settings

# Create Celery app
celery_app = Celery(
    "inboxgrove",
    broker=settings.CELERY_BROKER_URL,
    backend=settings.CELERY_RESULT_BACKEND
)

# Configure Celery
celery_app.conf.update(
    task_serializer='json',
    accept_content=['json'],
    result_serializer='json',
    timezone='UTC',
    enable_utc=True,
)

# Placeholder tasks
@celery_app.task(name="app.workers.test_task")
def test_task():
    """Test task to verify Celery is working."""
    return "Celery is working!"

# Auto-discover tasks from other modules
# celery_app.autodiscover_tasks(['app.services'])
