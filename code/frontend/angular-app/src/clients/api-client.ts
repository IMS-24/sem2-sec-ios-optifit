//----------------------
// <auto-generated>
//     Generated using the NSwag toolchain v14.0.7.0 (NJsonSchema v11.0.0.0 (Newtonsoft.Json v13.0.0.0)) (http://NSwag.org)
// </auto-generated>
//----------------------

/* tslint:disable */
/* eslint-disable */
// ReSharper disable InconsistentNaming

import { mergeMap as _observableMergeMap, catchError as _observableCatch } from 'rxjs/operators';
import { Observable, throwError as _observableThrow, of as _observableOf } from 'rxjs';
import { Injectable, Inject, Optional, InjectionToken } from '@angular/core';
import { HttpClient, HttpHeaders, HttpResponse, HttpResponseBase } from '@angular/common/http';

export const API_BASE_URL = new InjectionToken<string>('API_BASE_URL');

@Injectable({
    providedIn: 'root'
})
export class ExerciseClient {
    private http: HttpClient;
    private baseUrl: string;
    protected jsonParseReviver: ((key: string, value: any) => any) | undefined = undefined;

    constructor(@Inject(HttpClient) http: HttpClient, @Optional() @Inject(API_BASE_URL) baseUrl?: string) {
        this.http = http;
        this.baseUrl = baseUrl ?? "";
    }

    /**
     * @return Search Exercies
     */
    searchExercises(search: SearchExerciseDto): Observable<PaginatedResultOfExerciseExtendedDto> {
        let url_ = this.baseUrl + "/api/Exercise/search";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(search);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processSearchExercises(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processSearchExercises(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<PaginatedResultOfExerciseExtendedDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<PaginatedResultOfExerciseExtendedDto>;
        }));
    }

    protected processSearchExercises(response: HttpResponseBase): Observable<PaginatedResultOfExerciseExtendedDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as PaginatedResultOfExerciseExtendedDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<PaginatedResultOfExerciseExtendedDto>(null as any);
    }

    /**
     * @return Create Exercise
     */
    createExercise(createExerciseDto: CreateExerciseDto): Observable<ExerciseDto> {
        let url_ = this.baseUrl + "/api/Exercise";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(createExerciseDto);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processCreateExercise(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processCreateExercise(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<ExerciseDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<ExerciseDto>;
        }));
    }

    protected processCreateExercise(response: HttpResponseBase): Observable<ExerciseDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as ExerciseDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<ExerciseDto>(null as any);
    }

    /**
     * @return Get Exercise Types
     */
    getExerciseTypes(): Observable<ExerciseTypeDto> {
        let url_ = this.baseUrl + "/api/Exercise/types";
        url_ = url_.replace(/[?&]$/, "");

        let options_ : any = {
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Accept": "application/json"
            })
        };

        return this.http.request("get", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processGetExerciseTypes(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processGetExerciseTypes(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<ExerciseTypeDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<ExerciseTypeDto>;
        }));
    }

    protected processGetExerciseTypes(response: HttpResponseBase): Observable<ExerciseTypeDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as ExerciseTypeDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<ExerciseTypeDto>(null as any);
    }
}

@Injectable({
    providedIn: 'root'
})
export class GymClient {
    private http: HttpClient;
    private baseUrl: string;
    protected jsonParseReviver: ((key: string, value: any) => any) | undefined = undefined;

    constructor(@Inject(HttpClient) http: HttpClient, @Optional() @Inject(API_BASE_URL) baseUrl?: string) {
        this.http = http;
        this.baseUrl = baseUrl ?? "";
    }

    /**
     * @return Search Gyms
     */
    searchGyms(search: SearchGymsDto): Observable<PaginatedResultOfGymDto> {
        let url_ = this.baseUrl + "/api/Gym/search";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(search);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processSearchGyms(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processSearchGyms(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<PaginatedResultOfGymDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<PaginatedResultOfGymDto>;
        }));
    }

    protected processSearchGyms(response: HttpResponseBase): Observable<PaginatedResultOfGymDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as PaginatedResultOfGymDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<PaginatedResultOfGymDto>(null as any);
    }

    /**
     * @return Create Gym
     */
    createGym(createGymDto: CreateGymDto): Observable<GymDto> {
        let url_ = this.baseUrl + "/api/Gym";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(createGymDto);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processCreateGym(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processCreateGym(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<GymDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<GymDto>;
        }));
    }

    protected processCreateGym(response: HttpResponseBase): Observable<GymDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as GymDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<GymDto>(null as any);
    }
}

@Injectable({
    providedIn: 'root'
})
export class MuscleClient {
    private http: HttpClient;
    private baseUrl: string;
    protected jsonParseReviver: ((key: string, value: any) => any) | undefined = undefined;

    constructor(@Inject(HttpClient) http: HttpClient, @Optional() @Inject(API_BASE_URL) baseUrl?: string) {
        this.http = http;
        this.baseUrl = baseUrl ?? "";
    }

    /**
     * @return Search Muscles
     */
    searchMuscles(search: SearchMuscleDto): Observable<PaginatedResultOfMuscleDto> {
        let url_ = this.baseUrl + "/api/Muscle/search";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(search);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processSearchMuscles(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processSearchMuscles(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<PaginatedResultOfMuscleDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<PaginatedResultOfMuscleDto>;
        }));
    }

    protected processSearchMuscles(response: HttpResponseBase): Observable<PaginatedResultOfMuscleDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as PaginatedResultOfMuscleDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<PaginatedResultOfMuscleDto>(null as any);
    }
}

@Injectable({
    providedIn: 'root'
})
export class MuscleGroupClient {
    private http: HttpClient;
    private baseUrl: string;
    protected jsonParseReviver: ((key: string, value: any) => any) | undefined = undefined;

    constructor(@Inject(HttpClient) http: HttpClient, @Optional() @Inject(API_BASE_URL) baseUrl?: string) {
        this.http = http;
        this.baseUrl = baseUrl ?? "";
    }

    /**
     * @return Search Muscle Groups
     */
    searchMuscleGroups(search: SearchMuscleGroupDto): Observable<PaginatedResultOfMuscleGroupDto> {
        let url_ = this.baseUrl + "/api/MuscleGroup/search";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(search);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processSearchMuscleGroups(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processSearchMuscleGroups(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<PaginatedResultOfMuscleGroupDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<PaginatedResultOfMuscleGroupDto>;
        }));
    }

    protected processSearchMuscleGroups(response: HttpResponseBase): Observable<PaginatedResultOfMuscleGroupDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as PaginatedResultOfMuscleGroupDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<PaginatedResultOfMuscleGroupDto>(null as any);
    }
}

@Injectable({
    providedIn: 'root'
})
export class MuscleGroupMappingClient {
    private http: HttpClient;
    private baseUrl: string;
    protected jsonParseReviver: ((key: string, value: any) => any) | undefined = undefined;

    constructor(@Inject(HttpClient) http: HttpClient, @Optional() @Inject(API_BASE_URL) baseUrl?: string) {
        this.http = http;
        this.baseUrl = baseUrl ?? "";
    }

    /**
     * @return Search Muscle Group Mappings
     */
    searchMuscleGroupMappings(search: SearchMuscleGroupMappingDto): Observable<PaginatedResultOfMuscleGroupMappingDto> {
        let url_ = this.baseUrl + "/api/MuscleGroupMapping/search";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(search);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processSearchMuscleGroupMappings(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processSearchMuscleGroupMappings(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<PaginatedResultOfMuscleGroupMappingDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<PaginatedResultOfMuscleGroupMappingDto>;
        }));
    }

    protected processSearchMuscleGroupMappings(response: HttpResponseBase): Observable<PaginatedResultOfMuscleGroupMappingDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as PaginatedResultOfMuscleGroupMappingDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<PaginatedResultOfMuscleGroupMappingDto>(null as any);
    }
}

@Injectable({
    providedIn: 'root'
})
export class ProfileClient {
    private http: HttpClient;
    private baseUrl: string;
    protected jsonParseReviver: ((key: string, value: any) => any) | undefined = undefined;

    constructor(@Inject(HttpClient) http: HttpClient, @Optional() @Inject(API_BASE_URL) baseUrl?: string) {
        this.http = http;
        this.baseUrl = baseUrl ?? "";
    }

    /**
     * @return Get User Profile
     */
    getUserProfile(): Observable<UserProfileDto> {
        let url_ = this.baseUrl + "/api/Profile";
        url_ = url_.replace(/[?&]$/, "");

        let options_ : any = {
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Accept": "application/json"
            })
        };

        return this.http.request("get", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processGetUserProfile(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processGetUserProfile(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<UserProfileDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<UserProfileDto>;
        }));
    }

    protected processGetUserProfile(response: HttpResponseBase): Observable<UserProfileDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as UserProfileDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<UserProfileDto>(null as any);
    }

    /**
     * @return Update User Profile
     */
    updateUserProfile(update: UpdateUserProfileDto): Observable<UserProfileDto> {
        let url_ = this.baseUrl + "/api/Profile";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(update);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("put", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processUpdateUserProfile(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processUpdateUserProfile(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<UserProfileDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<UserProfileDto>;
        }));
    }

    protected processUpdateUserProfile(response: HttpResponseBase): Observable<UserProfileDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as UserProfileDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<UserProfileDto>(null as any);
    }
}

@Injectable({
    providedIn: 'root'
})
export class WorkoutClient {
    private http: HttpClient;
    private baseUrl: string;
    protected jsonParseReviver: ((key: string, value: any) => any) | undefined = undefined;

    constructor(@Inject(HttpClient) http: HttpClient, @Optional() @Inject(API_BASE_URL) baseUrl?: string) {
        this.http = http;
        this.baseUrl = baseUrl ?? "";
    }

    /**
     * @return Search Workouts
     */
    searchWorkouts(search: SearchWorkoutDto): Observable<PaginatedResultOfWorkoutDto> {
        let url_ = this.baseUrl + "/api/Workout/search";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(search);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processSearchWorkouts(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processSearchWorkouts(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<PaginatedResultOfWorkoutDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<PaginatedResultOfWorkoutDto>;
        }));
    }

    protected processSearchWorkouts(response: HttpResponseBase): Observable<PaginatedResultOfWorkoutDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as PaginatedResultOfWorkoutDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<PaginatedResultOfWorkoutDto>(null as any);
    }

    /**
     * @return Create Workout
     */
    createWorkout(createWorkoutDto: CreateWorkoutDto): Observable<WorkoutDto> {
        let url_ = this.baseUrl + "/api/Workout";
        url_ = url_.replace(/[?&]$/, "");

        const content_ = JSON.stringify(createWorkoutDto);

        let options_ : any = {
            body: content_,
            observe: "response",
            responseType: "blob",
            headers: new HttpHeaders({
                "Content-Type": "application/json",
                "Accept": "application/json"
            })
        };

        return this.http.request("post", url_, options_).pipe(_observableMergeMap((response_ : any) => {
            return this.processCreateWorkout(response_);
        })).pipe(_observableCatch((response_: any) => {
            if (response_ instanceof HttpResponseBase) {
                try {
                    return this.processCreateWorkout(response_ as any);
                } catch (e) {
                    return _observableThrow(e) as any as Observable<WorkoutDto>;
                }
            } else
                return _observableThrow(response_) as any as Observable<WorkoutDto>;
        }));
    }

    protected processCreateWorkout(response: HttpResponseBase): Observable<WorkoutDto> {
        const status = response.status;
        const responseBlob =
            response instanceof HttpResponse ? response.body :
            (response as any).error instanceof Blob ? (response as any).error : undefined;

        let _headers: any = {}; if (response.headers) { for (let key of response.headers.keys()) { _headers[key] = response.headers.get(key); }}
        if (status === 200) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            let result200: any = null;
            result200 = _responseText === "" ? null : JSON.parse(_responseText, this.jsonParseReviver) as WorkoutDto;
            return _observableOf(result200);
            }));
        } else if (status !== 200 && status !== 204) {
            return blobToText(responseBlob).pipe(_observableMergeMap(_responseText => {
            return throwException("An unexpected server error occurred.", status, _responseText, _headers);
            }));
        }
        return _observableOf<WorkoutDto>(null as any);
    }
}

export interface PaginatedResultOfExerciseExtendedDto {
    items?: ExerciseExtendedDto[];
    pageIndex?: number;
    pageSize?: number;
    totalCount?: number;
    totalPages?: number;
    hasPreviousPage?: boolean;
    hasNextPage?: boolean;
}

export interface BaseDto {
    id?: string | null;
}

export interface BaseI18NDto extends BaseDto {
    i18NCode?: string;
}

export interface ExerciseExtendedDto extends BaseI18NDto {
    description?: string;
    muscleGroupDtos?: MuscleGroupExtendedDto[] | null;
    muscleDtos?: MuscleExtendedDto[];
}

export interface MuscleGroupExtendedDto extends BaseI18NDto {
    muscles?: MuscleDto[] | null;
}

export interface MuscleDto extends BaseI18NDto {
}

export interface MuscleExtendedDto extends BaseI18NDto {
    muscleGroups?: MuscleGroupDto[] | null;
}

export interface MuscleGroupDto extends BaseI18NDto {
}

export interface PaginationDto {
    pageSize?: number;
    pageIndex?: number;
}

export interface SearchBaseDto extends PaginationDto {
    id?: string | null;
    orderBy?: string | null;
    orderDirection?: string | null;
}

export interface SearchI18NDto extends SearchBaseDto {
    i18NCode?: string | null;
}

export interface SearchExerciseDto extends SearchI18NDto {
    description?: string | null;
}

export interface ExerciseDto extends BaseI18NDto {
    description?: string | null;
}

export interface CreateI18NDto {
    i18NCode?: string;
}

export interface CreateExerciseDto extends CreateI18NDto {
    description?: string;
    exerciseTypeId?: string;
}

export interface ExerciseTypeDto {
    id?: string;
    i18NCode?: string;
}

export interface PaginatedResultOfGymDto {
    items?: GymDto[];
    pageIndex?: number;
    pageSize?: number;
    totalCount?: number;
    totalPages?: number;
    hasPreviousPage?: boolean;
    hasNextPage?: boolean;
}

export interface BaseNamedDto extends BaseDto {
    name?: string;
}

export interface GymDto extends BaseNamedDto {
    address?: string | null;
    city?: string | null;
    zipCode?: number | null;
}

export interface SearchNamedDto extends SearchBaseDto {
    name?: string | null;
}

export interface SearchGymsDto extends SearchNamedDto {
    address?: string | null;
    city?: string | null;
    zipCode?: number | null;
}

export interface CreateGymDto extends BaseNamedDto {
    address?: string | null;
    city?: string | null;
    zipCode?: number | null;
}

export interface PaginatedResultOfMuscleDto {
    items?: MuscleDto[];
    pageIndex?: number;
    pageSize?: number;
    totalCount?: number;
    totalPages?: number;
    hasPreviousPage?: boolean;
    hasNextPage?: boolean;
}

export interface SearchMuscleDto extends SearchI18NDto {
}

export interface PaginatedResultOfMuscleGroupDto {
    items?: MuscleGroupDto[];
    pageIndex?: number;
    pageSize?: number;
    totalCount?: number;
    totalPages?: number;
    hasPreviousPage?: boolean;
    hasNextPage?: boolean;
}

export interface SearchMuscleGroupDto extends SearchI18NDto {
}

export interface PaginatedResultOfMuscleGroupMappingDto {
    items?: MuscleGroupMappingDto[];
    pageIndex?: number;
    pageSize?: number;
    totalCount?: number;
    totalPages?: number;
    hasPreviousPage?: boolean;
    hasNextPage?: boolean;
}

export interface MuscleGroupMappingDto extends BaseDto {
    muscleGroupId?: string;
    muscleId?: string;
}

export interface SearchMuscleGroupMappingDto extends SearchBaseDto {
}

export interface UserProfileDto {
    id?: string;
    userName?: string;
    email?: string;
    firstName?: string;
    lastName?: string;
    userRole?: string;
    dateOfBirthUtc?: Date | null;
    lastLoginUtc?: Date | null;
    registeredUtc?: Date;
    updatedUtc?: Date;
    initialSetupDone?: boolean;
}

export interface UpdateUserProfileDto {
    firstName?: string | null;
    lastName?: string | null;
    email?: string | null;
    dateOfBirthUtc?: Date | null;
    initialSetupDone?: boolean;
}

export interface PaginatedResultOfWorkoutDto {
    items?: WorkoutDto[];
    pageIndex?: number;
    pageSize?: number;
    totalCount?: number;
    totalPages?: number;
    hasPreviousPage?: boolean;
    hasNextPage?: boolean;
}

export interface WorkoutDto {
    id?: string;
    description?: string;
    userId?: string;
    userName?: string;
    startAtUtc?: Date;
    endAtUtc?: Date | null;
    notes?: string;
    gymId?: string;
    gym?: string;
    workoutLogs?: WorkoutLogDto[];
}

export interface WorkoutLogDto {
    order?: number;
    workoutId?: string;
    exerciseId?: string;
    set?: Set;
    notes?: string;
}

export interface Set {
    order?: number;
    reps?: number;
    weight?: number;
}

export interface SearchWorkoutDto extends SearchBaseDto {
}

export interface CreateWorkoutDto {
    description?: string | null;
    userId?: string;
    startAtUtc?: Date;
    endAtUtc?: Date | null;
    notes?: string | null;
    gymId?: string;
}

export class ApiException extends Error {
    override message: string;
    status: number;
    response: string;
    headers: { [key: string]: any; };
    result: any;

    constructor(message: string, status: number, response: string, headers: { [key: string]: any; }, result: any) {
        super();

        this.message = message;
        this.status = status;
        this.response = response;
        this.headers = headers;
        this.result = result;
    }

    protected isApiException = true;

    static isApiException(obj: any): obj is ApiException {
        return obj.isApiException === true;
    }
}

function throwException(message: string, status: number, response: string, headers: { [key: string]: any; }, result?: any): Observable<any> {
    if (result !== null && result !== undefined)
        return _observableThrow(result);
    else
        return _observableThrow(new ApiException(message, status, response, headers, null));
}

function blobToText(blob: any): Observable<string> {
    return new Observable<string>((observer: any) => {
        if (!blob) {
            observer.next("");
            observer.complete();
        } else {
            let reader = new FileReader();
            reader.onload = event => {
                observer.next((event.target as any).result);
                observer.complete();
            };
            reader.readAsText(blob);
        }
    });
}