

import Foundation
struct GetWorkoutDto: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    let description: String
    let startAtUtc: Date
    let endAtUtc: Date?         // optional in case it's sometimes missing
    let notes: String?
    let gymId: UUID
    let workoutExercises: [GetWorkoutExerciseDto]?
}

/*
 {
 "items": [
 {
 "description": "Chest Day",
 "startAtUtc": "2025-02-13T18:19:09.596+00:00",
 "endAtUtc": "2025-02-13T23:19:15.057+00:00",
 "notes": "hmmm",
 "gymId": "2663c207-d8b6-4bae-b776-d68b0fd1bdda",
 "id": "ab8e26c0-4aeb-4d47-a812-f29977c24e53",
 "workoutExercises": [
 {
 "order": 3,
 "workoutId": "ab8e26c0-4aeb-4d47-a812-f29977c24e53",
 "exerciseId": "f11d5552-e4e3-4bfc-8bce-16538c99ff0d",
 "workoutSets": [
 {
 "order": 1,
 "reps": 20,
 "weight": 100,
 "workoutExerciseId": "3d4fd4e5-8cbc-424b-a89f-73be51c32f4a",
 "id": "4e7ac4cb-dd76-47d0-9ed4-30b3d79ef254"
 },
 {
 "order": 3,
 "reps": 8,
 "weight": 160,
 "workoutExerciseId": "3d4fd4e5-8cbc-424b-a89f-73be51c32f4a",
 "id": "4b5989ad-561e-4a32-ade5-cca8f1fd7373"
 },
 {
 "order": 2,
 "reps": 10,
 "weight": 145,
 "workoutExerciseId": "3d4fd4e5-8cbc-424b-a89f-73be51c32f4a",
 "id": "74324230-68c4-4070-a4a2-5cd3e9a7688c"
 }
 ],
 "notes": null,
 "id": "3d4fd4e5-8cbc-424b-a89f-73be51c32f4a"
 },
 {
 "order": 1,
 "workoutId": "ab8e26c0-4aeb-4d47-a812-f29977c24e53",
 "exerciseId": "846e8c2d-9d63-4c18-82fa-0d8c7512f326",
 "workoutSets": [
 {
 "order": 2,
 "reps": 10,
 "weight": 150,
 "workoutExerciseId": "68a26d6d-2d39-4c6c-ae01-3e903aaae657",
 "id": "3f1cabe1-872a-49d2-94ea-e0adb5df659e"
 },
 {
 "order": 3,
 "reps": 8,
 "weight": 155,
 "workoutExerciseId": "68a26d6d-2d39-4c6c-ae01-3e903aaae657",
 "id": "9d4d55ca-dae7-4447-aad3-cfd4079c2819"
 },
 {
 "order": 1,
 "reps": 20,
 "weight": 100,
 "workoutExerciseId": "68a26d6d-2d39-4c6c-ae01-3e903aaae657",
 "id": "710d0502-8dc5-48f2-ba3f-7068fdbaf194"
 }
 ],
 "notes": null,
 "id": "68a26d6d-2d39-4c6c-ae01-3e903aaae657"
 },
 {
 "order": 2,
 "workoutId": "ab8e26c0-4aeb-4d47-a812-f29977c24e53",
 "exerciseId": "e7e6e065-1743-4c1e-8c8f-e7d5dd1a0536",
 "workoutSets": [
 {
 "order": 1,
 "reps": 20,
 "weight": 100,
 "workoutExerciseId": "a087e164-1231-44b8-8027-b89cfacd6926",
 "id": "eae23fb5-2ee4-40e7-a77f-91935c14a323"
 },
 {
 "order": 2,
 "reps": 10,
 "weight": 120,
 "workoutExerciseId": "a087e164-1231-44b8-8027-b89cfacd6926",
 "id": "2ccb5a86-08eb-480d-b547-ab90b6c0411c"
 },
 {
 "order": 3,
 "reps": 8,
 "weight": 130,
 "workoutExerciseId": "a087e164-1231-44b8-8027-b89cfacd6926",
 "id": "75883f9b-d0d8-4949-9944-f4d2d8083d51"
 }
 ],
 "notes": null,
 "id": "a087e164-1231-44b8-8027-b89cfacd6926"
 },
 {
 "order": 4,
 "workoutId": "ab8e26c0-4aeb-4d47-a812-f29977c24e53",
 "exerciseId": "5e65e833-8f70-467c-8caa-41deaef24393",
 "workoutSets": [
 {
 "order": 1,
 "reps": 20,
 "weight": 100,
 "workoutExerciseId": "b5087c04-5aed-42a7-8e85-bd7daebb05bf",
 "id": "cd76c055-7ab5-4b06-b867-af03ad8b951f"
 },
 {
 "order": 3,
 "reps": 8,
 "weight": 110,
 "workoutExerciseId": "b5087c04-5aed-42a7-8e85-bd7daebb05bf",
 "id": "fa1e88f1-193c-44cd-8024-f7259456f73a"
 },
 {
 "order": 2,
 "reps": 10,
 "weight": 115,
 "workoutExerciseId": "b5087c04-5aed-42a7-8e85-bd7daebb05bf",
 "id": "c5b4e515-792d-4cd6-bf1f-87a588a5b727"
 }
 ],
 "notes": null,
 "id": "b5087c04-5aed-42a7-8e85-bd7daebb05bf"
 }
 ]
 }
 ],
 "pageIndex": 0,
 "pageSize": 1,
 "totalCount": 7,
 "totalPages": 7,
 "hasPreviousPage": false,
 "hasNextPage": true
 }
 */
