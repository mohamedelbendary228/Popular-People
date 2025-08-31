# Popular People App

A Flutter app based on the "[The Movie DB](https://www.themoviedb.org/)" api to fetch popular people and their info (their movies, images, ..etc). [(API version 3 is used)](https://developers.themoviedb.org/3/people/get-popular-people)


🎨 [Design inspiration](https://dribbble.com/shots/7902411-Actors-Tracking-App)

## ✨ Feature Set

* [x] **Popular People Listing** – Display a list of popular people (actors, directors, etc.) with infinite scrolling.

 * [x] **Person Details** – View detailed information about a person, including a grid of their images and a biography.

 * [x] **Image Viewer** – Open selected images in full size on a separate screen with the option to save them locally.

 * [x] **Offline Support** – Cache data in a local database and display it when no network connection is available.
 * [x] **Theme Switching** – Toggle between light and dark themes.


<br/>
<div>
  &emsp;&emsp;&emsp;
  <img src="https://github.com/user-attachments/assets/a9b908e8-f6b8-496e-a66e-959886f76b4c" alt="Dark theme" width="220">  
  &emsp;&emsp;&emsp;
  <img src="https://github.com/user-attachments/assets/d1db9c08-d0d9-4b63-b85b-4fd95671cce2" alt="Dark theme" width="220">  
  &emsp;&emsp;
  <img src="https://github.com/user-attachments/assets/2e5b6ec6-c4f0-4704-a346-12b12bfad483" alt="Light theme" width="220">
</div>
<br/>

<br/>
<div>
  &emsp;&emsp;&emsp;
  <img src="https://github.com/user-attachments/assets/480bae43-12c3-42cb-9827-3d4f787aaa81" alt="Dark theme" width="220">  
  &emsp;&emsp;&emsp;
  <img src="https://github.com/user-attachments/assets/6f321e4f-bc5d-495b-b29f-cfd5842d0df1" alt="Dark theme" width="220">  
  &emsp;&emsp;&emsp;
  <img src="https://github.com/user-attachments/assets/993d273e-212d-4ec1-abe7-b420d4c0396d" alt="Dark theme" width="220"> 
</div>
<br/>

# Demo URL
```

```


## Running the App
An api key from TMDB is required to run the app. Then you can run the app by adding the following run arguments:
```
--dart-define=TMDB_API_KEY=<YOUR_API_KEY>
```

# Flutter version
```
3.24.5
```

# State Management used
```
Riverpod
```


#### Folder Structure

```
lib
├── core
│   ├── configs
│   ├── constants
│   ├── enums
│   ├── exceptions
│   ├── models
│   ├── services
│   │   ├── dio
│   │   └── cache
│   ├── theme
│   └── widgets
├── features
│   ├── person_details
│   │   ├── models
│   │   ├── providers
│   │   ├── repositories
│   │   └── views
│   │       ├── pages
│   │       └── widgets
│   ├── popular_people
│   │   ├── providers
│   │   ├── repositories
│   │   └── views
│   │       ├── pages
│   │       └── widgets
│   └── tmdb-configs
│       ├── models
│       ├── providers
│       └── repositories
├── routes
├── main.dart
└── my_app.dart
```

## Project Structure 🗂️

### `main.dart`
- Initializes app-level services.
- Wraps the root `MyApp` widget with a `ProviderScope` for Riverpod state management.

### `my_app.dart`
- Defines the root `MaterialApp`.
- Fetches **TMDB configs** at startup, which are used to generate image URLs for TMDB API endpoints across the app.

---

## Core (`/core`)

The `core` folder contains code shared across all features.

- **`configs/`** → App configs such API key and baseUrl
- **`constants/`** → App-wide constants (e.g., strings, Endpoints).  
- **`enums/`** → Enumerations used across features.  
- **`exceptions/`** → Custom exception classes for error handling.  
- **`models/`** → Shared models used in multiple features.  
- **`theme/`** → Global styles such as colors, themes, and text styles, and Theme configuration (light/dark, text themes, color schemes).  
- **`widgets/`** → Reusable UI components.  

### Services (`/core/services`)
Abstracted **app-level services** with their implementations:

- **`dio/`** → HTTP service implemented with [Dio](https://pub.dev/packages/dio).  
  - Includes a `CacheInterceptor` that integrates with the `StorageService` for caching.  
  - [More information about caching below](#http-caching) 👇🏼  
- **`cache/`** → Local storage service implemented with [Hive](https://pub.dev/packages/hive/versions/4.0.0-dev.2).  
- **Service abstraction** → The **Service Locator pattern** together with **Riverpod providers** is used to make services easily accessible across layers.  

---

## Features (`/features`)

Each feature is organized by domain, following a **feature-first architecture**.  
Every feature may contain `models`, `providers`, `repositories`, and `views` (split into `pages` and `widgets`).  

- **`person_details/`** → Handles fetching and displaying detailed information about a specific person.  
- **`popular_people/`** → Responsible for listing and paginating popular people.  
- **`tmdb-configs/`** → Encapsulates logic for fetching and storing TMDB API configuration (e.g., image base URLs).  

---

## Routes (`/routes`)
Defines app navigation and route management.



## 📞 Contact Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/mohamed-elbendary/)
[![Email](https://img.shields.io/badge/Email-Contact%20Me-red?logo=gmail)](albendary.com@gmail.com)
[![X](https://img.shields.io/badge/Follow-black?logo=x&logoColor=white)](https://x.com/mab_228)

---
