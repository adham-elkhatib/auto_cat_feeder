# 🐾 Auto Cat Feeder - Smart Feeding System

**A complete IoT-integrated mobile application** for managing a smart cat feeder.  
Built with Flutter using Clean Architecture, Firebase, and Real-time hardware interaction.  
This project showcases advanced mobile engineering concepts, a smooth user experience, and integration with real-world hardware.

---

## 🚀 Features

- 🔐 **Authentication & Onboarding**
  - Email/password login & signup
  - Clean onboarding flow using `introduction_screen`
  - Firebase Auth with localized error handling

- 🐱 **Pet Profile Management**
  - Create/edit cat profiles with visual UI
  - Weight tracking, breed selection, and dietary details

- 🗓️ **Meal Scheduling System**
  - Add/edit/delete scheduled meals
  - Real-time sync with feeder via Firebase RTDB
  - View detailed feeding schedule per day

- 🔗 **Feeder Connection Flow**
  - Connect feeder device via QR code or ID
  - Bottom sheet interface for managing connections
  - Sync meals to device with feedback

- ⚙️ **Feeder Monitoring**
  - View live status (online/offline, food availability)
  - Trigger refill or diagnostics actions
  - Handle feeder errors gracefully

- 📦 **Hardware Interactions**
  - ESP32-based feeder hardware
  - Real-time status updates via Firebase RTDB
  - Slew drive for tilt mechanism (in prototype phase)

---

## 🧠 Applied Concepts & Patterns

### ✅ Clean Architecture (TDD-first)
- Clear separation of concerns: `Domain`, `Data`, `Presentation`
- Each layer is unit-tested and isolated
- Built with Test-Driven Development mindset

### 🎯 State Management
- BLoC pattern via `flutter_bloc`
- Event-driven UI updates
- Global and per-feature blocs with optimized rebuilds

### 🔥 Firebase Ecosystem
- Firebase Authentication
- Firebase Realtime Database
- Firestore (for structured user data)
- Firebase Storage (for pet images)
- Error handling mapped using custom error system

### 🌍 Localization
- `easy_localization` for multilingual support
- All errors & UI texts localized
- JSON-based language files with nested keys

### 📦 Dependency Injection & Modular Codebase
- Providers and repositories injected cleanly
- Scalable structure for future modules

### 🧪 Testing Strategy
- Unit tests for:
  - Use cases
  - Mappers & validators
  - Bloc logic
- Manual integration testing with hardware

---

## 🧰 Tech Stack

| Layer              | Tech/Library                     |
|-------------------|----------------------------------|
| UI                | Flutter + Material3              |
| State Management  | flutter_bloc                     |
| Localization      | easy_localization                |
| Backend Services  | Firebase (Auth, RTDB, Firestore) |
| QR Code           | barcode_scan2                    |
| Networking        | dio + logging + error mapping    |
| Hardware          | ESP32 + Firebase RTDB            |
| Design Patterns   | Clean Architecture + TDD         |

---

## 📸 UI Snapshots

- Login & Onboarding Flow
- Feeder Connection Modal
- Create/Edit Feeding Schedule
- Cat Profile Editor
- Real-time Feeder Status

> *Images available in `/screenshots` or the repo image previews*

---

## 💡 Why This Project?

This app was designed not just as a functional product, but as a **showcase of production-level Flutter engineering**, including:
- How to structure and scale complex Flutter apps
- Integrate with hardware via the cloud
- Handle localization, error mapping, and clean UX
- Build confidently with TDD and maintainability in mind

---

## 📬 Contact

If you're interested in the tech behind this or want to collaborate on hardware-integrated apps, feel free to reach out!

---

