"""
Categories Resource Router
Provides endpoints for retrieving and managing event categories.
Course: SWC3633 / SWC4443 Web API Development
"""
from fastapi import APIRouter, Depends, HTTPException, status
import pymysql

from backend.database import get_db, serialize_rows
from backend.models import CategoryCreate
from backend.auth import require_roles

router = APIRouter(prefix="/categories", tags=["Categories Resource"])

@router.get("", status_code=status.HTTP_200_OK)
def list_categories(db: pymysql.Connection = Depends(get_db)):
    """Retrieves all event categories with event count."""
    cursor = db.cursor()
    cursor.execute("""
        SELECT c.category_id, c.category_name, c.description, COUNT(e.event_id) as event_count
        FROM categories c
        LEFT JOIN events e ON c.category_id = e.category_id
        GROUP BY c.category_id, c.category_name, c.description
        ORDER BY c.category_id ASC
    """)
    rows = cursor.fetchall()
    return {
        "status": "success",
        "data": serialize_rows(rows)
    }

@router.post("", status_code=status.HTTP_201_CREATED)
def create_category(
    payload: CategoryCreate,
    current_user: dict = Depends(require_roles(["admin"])),
    db: pymysql.Connection = Depends(get_db)
):
    """[Admin Only] Creates a new category."""
    cursor = db.cursor()
    cursor.execute("SELECT category_id FROM categories WHERE LOWER(category_name) = LOWER(%s)", (payload.category_name.strip(),))
    if cursor.fetchone():
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=f"Category '{payload.category_name}' already exists.")

    cursor.execute("""
        INSERT INTO categories (category_name, description)
        VALUES (%s, %s)
    """, (payload.category_name.strip(), payload.description))

    cat_id = cursor.lastrowid
    return {
        "status": "success",
        "message": f"Category '{payload.category_name}' created successfully.",
        "data": {"category_id": cat_id, "category_name": payload.category_name.strip(), "description": payload.description}
    }

@router.delete("/{category_id}", status_code=status.HTTP_200_OK)
def delete_category(
    category_id: int,
    current_user: dict = Depends(require_roles(["admin"])),
    db: pymysql.Connection = Depends(get_db)
):
    """[Admin Only] Deletes a category if no events are using it."""
    cursor = db.cursor()
    cursor.execute("SELECT category_id, category_name FROM categories WHERE category_id = %s", (category_id,))
    row = cursor.fetchone()
    if not row:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Category with ID {category_id} not found.")

    cursor.execute("SELECT COUNT(*) as cnt FROM events WHERE category_id = %s", (category_id,))
    cnt = cursor.fetchone()["cnt"]
    if cnt > 0:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail=f"Cannot delete category '{row['category_name']}' because {cnt} event(s) are linked to it.")

    cursor.execute("DELETE FROM categories WHERE category_id = %s", (category_id,))
    return {
        "status": "success",
        "message": f"Category '{row['category_name']}' (ID: {category_id}) deleted successfully."
    }

