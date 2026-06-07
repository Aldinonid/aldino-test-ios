# BCA Test Aldino

A Music Search & Preview Player application built using **SwiftUI**, **MVVM Architecture**, **Async/Await**, **Dependency Injection**, **Unit Testing**, and **CI/CD with Fastlane & GitHub Actions**.

---

# Features

- Search songs using iTunes Search API
- Debounced search (500ms)
- Full search when user submits from keyboard
- Audio preview playback
- Play / Pause
- Next / Previous track
- Seek audio position
- Mini Player
- Full Screen Player
- Artwork image caching
- Unit Testing
- CI/CD Pipeline

---

# Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture pattern.

```text
Presentation Layer
│
├── SearchView
├── PlayerView
├── MiniPlayerView
├── SongRow
│
├── SearchViewModel
└── PlayerViewModel

Domain Layer
│
├── Song
├── SearchResponse
│
├── MusicRepositoryProtocol
└── AudioPlayer

Data Layer
│
├── MusicRepository
├── AudioPlayerManager
│
└── Network
    ├── Endpoint
    ├── NetworkError
    └── NetworkManager

DI Layer
│
└── AppDI
```

---

# Application Flow

## App Launch

```text
App
│
└── AppDI
     │
     ├── NetworkManager
     ├── MusicRepository
     ├── AudioPlayerManager
     │
     ├── SearchViewModel
     └── PlayerViewModel
```

Dependencies are initialized once and injected into ViewModels.

---

## Search Flow

```text
User Input
      │
      ▼
SearchView
      │
      ▼
SearchViewModel
      │
      ▼
MusicRepository
      │
      ▼
NetworkManager
      │
      ▼
iTunes Search API
```

### Debounce Search

While typing:

```text
Taylor Swift
```

The ViewModel waits for:

```text
500ms
```

before making a request.

Only the first:

```text
5 songs
```

are shown as preview results.

### Full Search

When the user presses the Search button on the keyboard:

```text
SearchView
      │
      ▼
SearchViewModel.search()
      │
      ▼
Display all results
```

---

## Playback Flow

```text
Song Selected
      │
      ▼
PlayerViewModel
      │
      ▼
AudioPlayerManager
      │
      ▼
AVPlayer
```

### Play

```text
Tap Song
      │
      ▼
Play Preview URL
```

### Pause

```text
Pause Button
      │
      ▼
AVPlayer.pause()
```

### Resume

```text
Play Button
      │
      ▼
AVPlayer.play()
```

### Seek

```text
Slider
      │
      ▼
PlayerViewModel
      │
      ▼
AudioPlayerManager.seek()
      │
      ▼
AVPlayer.seek()
```

---

# Playback State

```swift
enum PlayerStatus: Equatable {
    case idle
    case loading
    case playing
    case paused
    case finished
    case error(String)
}
```

Used to drive:

- Play/Pause button state
- SongRow animation
- Mini Player state
- Playback completion handling

---

# Image Caching

Artwork images are cached in memory to avoid unnecessary network requests.

```text
Image Request
      │
      ▼
Image Cache
      │
      ├── Cache Hit
      │       ▼
      │    Return Image
      │
      └── Cache Miss
              ▼
         Download Image
              ▼
          Save Cache
```

This prevents image reloading when scrolling.

---

# Network Layer

## Endpoint

Responsible for building URLRequest.

Example:

```swift
.search(term: "Taylor Swift")
```

Produces:

```text
https://itunes.apple.com/search
```

---

## NetworkManager

Responsible for:

- Sending requests
- Validating responses
- Decoding JSON
- Error mapping

---

## NetworkError

Custom error handling:

```swift
invalidURL
invalidResponse
badStatusCode
noData
decodingFailed
noInternet
unknown
```

---

# Dependency Injection

All dependencies are managed inside:

```swift
AppDI
```

Benefits:

- Loose coupling
- Easier testing
- Better scalability
- Mock support

---

# Unit Testing

The project includes unit tests for:

## SearchViewModel

- Search success
- Empty result
- Search failure
- Debounce behavior
- Search keyword propagation

## PlayerViewModel

- Play song
- Pause song
- Resume song
- Next song
- Previous song
- Seek functionality
- Playback completion

## MusicRepository

- Success response mapping
- Error propagation
- Network interaction

---

# Tech Stack

- Swift 6
- SwiftUI
- MVVM
- Async/Await
- Combine
- AVFoundation
- XCTest
- Fastlane
- GitHub Actions

---

# CI/CD

This project uses:

```text
GitHub Actions
+
Fastlane
```

Pipeline:

```text
Push / Pull Request
          │
          ▼
SwiftLint
          │
          ▼
Unit Test
          │
          ▼
Build Validation
          │
          ▼
Success
```

---

# Requirements

- macOS Sonoma or newer
- Xcode 16+
- iOS 16+
- Swift 6

---

# Installation

## Clone Repository

```bash
git clone https://github.com/Aldinonid/aldino-test-ios.git
```

```bash
cd aldino-test-ios
```

## Open Project

```bash
open BCA_Test_Aldino.xcodeproj
```

or open manually using Xcode.

---

# Run Application

1. Select an iOS Simulator (e.g. iPhone 16)
2. Press:

```text
⌘ + R
```

---

# Running Unit Tests

Using Xcode:

```text
Product
→ Test
```

or:

```bash
xcodebuild test \
-scheme "BCA Test Aldino"
```

---

# Fastlane

Run complete CI pipeline:

```bash
fastlane ci
```

Run tests only:

```bash
fastlane test
```

Run lint only:

```bash
fastlane lint
```

---

# Notes

This project was developed as part of an iOS Developer Technical Assessment and demonstrates:

- SwiftUI Development
- MVVM Architecture
- Dependency Injection
- Async/Await Networking
- Audio Playback Management
- Unit Testing
- CI/CD Best Practices