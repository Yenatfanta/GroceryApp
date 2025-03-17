# GroceryApp

GroceryApp is a Swift-based iOS application that helps users efficiently manage their grocery lists and favorite recipes. It follows the **MVVMC (Model-View-ViewModel-Coordinator) architecture**, ensuring modularity, scalability, and maintainability. The project is structured to follow **SOLID principles**, making the codebase clean, reusable, and easy to test.

## 📌 Features
- ✅ **MVVMC Architecture**: Implements Coordinators for efficient navigation and separation of concerns.
- ✅ **SOLID Principles**: Ensures maintainability with clean code and best practices.
- ✅ **User Authentication**: Sign up, log in, and manage accounts with Firebase Authentication.
- 🛒 **Grocery List Management**: Add, edit, and favorite recipes.
- 📡 **Cloud Sync**: Store and retrieve grocery lists using Firebase Firestore.
- 🖼 **Image Caching**: Uses **Kingfisher** for efficient image loading and caching.
- 📱 **Modern UI**: Clean and user-friendly design with **SwiftUI/UIKit**.
- 🔍 **Generic & Reusable Code**: Implements **protocol-oriented programming** for code efficiency.
- 🧪 **Unit & UI Testing**: Comprehensive test coverage using the **XCTest framework**.
- 🔔 **Push Notifications** (Planned): Get reminders for expiring items.

---

## 🏗 **Architecture: MVVMC**
GroceryApp follows the **MVVMC (Model-View-ViewModel-Coordinator) architecture**, which:
- 📌 **Separates concerns** to keep the code modular and maintainable.
- 📌 Uses **Coordinators** to handle navigation efficiently.
- 📌 Implements **Dependency Injection** for better testability.
- 📌 Follows **Protocol-Oriented Programming** to improve reusability.
---

## 🚀 Getting Started

### 1️⃣ **Prerequisites**
- ✅ **Xcode** (latest version recommended)
- ✅ **Firebase Project** (Set up Firebase and download `GoogleService-Info.plist`)

### 2️⃣ **Installation**
#### **Clone the Repository**
```sh
git clone https://github.com/your-username/GroceryApp.git
cd GroceryApp
