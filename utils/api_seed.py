import os
import random
import uuid
from datetime import datetime, timedelta
import requests
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()
BASE_URL = os.getenv("BASE_URL")
JWT_TOKEN = os.getenv("JWT_TOKEN")

HEADERS = {
    "Authorization": f"Bearer {JWT_TOKEN}",
    "Content-Type": "application/json"
}

def fetch_exercise_categories():
    """Fetch all exercise categories."""
    url = f"{BASE_URL}/exercise/categories"
    response = requests.get(url, headers=HEADERS)
    response.raise_for_status()
    return response.json()  # Expected: list of categories with "Id" and "I18NCode"

def fetch_exercises_for_category(category_id):
    """Fetch exercises for a specific category."""
    url = f"{BASE_URL}/exercise/search"
    payload = {
        "ExerciseCategoryId": category_id
    }
    response = requests.post(url, json=payload, headers=HEADERS)
    response.raise_for_status()
    data = response.json()
    if isinstance(data, dict) and "items" in data:
        return data["items"]
    return data

def fetch_gyms():
    """Fetch gyms from the backend."""
    url = f"{BASE_URL}/gym/search"
    payload = {}  # Empty search payload
    response = requests.post(url, json=payload, headers=HEADERS)
    response.raise_for_status()
    data = response.json()
    if isinstance(data, dict) and "items" in data:
        return data["items"]
    return data

def create_workout(workout_payload):
    """Create a workout via API."""
    url = f"{BASE_URL}/workout"
    #print(f"Sending request to {url} with payload: {workout_payload}")
    response = requests.post(url, json=workout_payload, headers=HEADERS)
    response.raise_for_status()
    return response.json()

def generate_workout(exercise_data, gym_id):
    """
    Generate a workout payload.
    
    - Randomly decides if the workout is single- or multi-category.
    - Each exercise gets a random number of sets, with random reps and weight.
    - Dates are generated in the past: a random day in the past with a realistic duration.
    """
    # Decide randomly: single category or multi-category workout
    is_multi_category = random.choice([True, False, False])  # ~33% chance for multi-category

    selected_exercises = []
    if is_multi_category:
        # Pick 2 or 3 categories (if available)
        categories = list(exercise_data.keys())
        if len(categories) < 2:
            is_multi_category = False  # Fallback if not enough categories
        else:
            num_categories = random.randint(2, min(3, len(categories)))
            selected_categories = random.sample(categories, num_categories)
            for cat_id in selected_categories:
                exercises = exercise_data[cat_id]
                if exercises:
                    num_ex = random.randint(1, min(2, len(exercises)))
                    selected_exercises.extend(random.sample(exercises, num_ex))
    if not is_multi_category:
        # Single-category workout: choose one category and several exercises from it
        categories = list(exercise_data.keys())
        if not categories:
            raise Exception("No exercise categories available")
        cat_id = random.choice(categories)
        exercises = exercise_data[cat_id]
        if not exercises:
            raise Exception(f"No exercises available for category {cat_id}")
        num_ex = random.randint(1, min(5, len(exercises)))  # between 1 and 5 exercises
        selected_exercises = random.sample(exercises, num_ex)
    
    # Build workout exercises list with sets
    workout_exercises = []
    for order, exercise in enumerate(selected_exercises, start=1):
        num_sets = random.randint(1, 4)  # 1 to 4 sets per exercise
        workout_sets = []
        for set_order in range(1, num_sets + 1):
            reps = random.randint(5, 15)
            weight = round(random.uniform(10.0, 100.0), 1)
            workout_sets.append({
                "Order": set_order,
                "Reps": reps,
                "Weight": weight
            })
        workout_exercises.append({
            "Order": order,
            "Exercise": exercise,  # Fetched exercise DTO
            "Notes": f"Auto-generated note for exercise {exercise.get('Description', exercise.get('I18NCode', ''))}",
            "WorkoutSets": workout_sets
        })
    
    # Generate past dates: choose a random day in the past 1-30 days,
    # then compute a workout duration between 30 and 90 minutes.
    now = datetime.utcnow()
    days_ago = random.randint(1, 30)
    duration_minutes = random.randint(30, 90)
    end_time = now - timedelta(days=days_ago)
    start_time = end_time - timedelta(minutes=duration_minutes)

    workout_payload = {
        "Description": "Seed generated workout",
        "StartAtUtc": start_time.isoformat() + "Z",
        "EndAtUtc": end_time.isoformat() + "Z",
        "Notes": "Auto generated workout for seeding purposes",
        "GymId": gym_id,
        "WorkoutExercises": workout_exercises
    }
    return workout_payload

def main():
    print("Fetching exercise categories...")
    categories = fetch_exercise_categories()

    # Build mapping: category_id -> list of exercises
    exercise_data = {}
    for category in categories:
        cat_id = category["id"]
        print(f"Fetching exercises for category {cat_id}...")
        exercises = fetch_exercises_for_category(cat_id)
        exercise_data[cat_id] = exercises
    
    print("Fetching gyms...")
    gyms = fetch_gyms()
    if not gyms:
        raise Exception("No gyms available from the API.")
    
    # Determine a random number of workouts to create (e.g., between 3 and 10)
    num_workouts = random.randint(3, 10)
    print(f"Creating {num_workouts} workouts...")

    for i in range(num_workouts):
        # For each workout, choose a random gym from the fetched list
        selected_gym = random.choice(gyms)
        gym_id = selected_gym.get("id")
        workout_payload = generate_workout(exercise_data, gym_id)
        print(f"Creating workout {i+1} with {len(workout_payload['WorkoutExercises'])} exercises for gym {gym_id}...")
        result = create_workout(workout_payload)
        workout_id = result.get("id", "No Id returned")
        print(f"Workout created with ID: {workout_id}")
    
    print("Seeding complete.")

if __name__ == "__main__":
    main()
