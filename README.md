# 🧑‍💻 Flutter Developer Role - Foodtek Restaurant Management System

## 📌 Role Overview
As a Flutter Developer for the **Foodtek** project, you are responsible for implementing the cross-platform mobile applications (Client and Driver apps) using the Flutter framework. Your work is essential for delivering a seamless, performant, and visually appealing user experience across iOS and Android devices.

---

## 🎯 Key Responsibilities

### 👨‍💻 Development
- Develop responsive and adaptive UI screens based on the provided designs  
- Implement client-side business logic for both Customer and Driver applications  
- Build reusable components and widgets to maintain consistency across the application  
- Convert UI/UX designs from design tools (Figma) into functional Flutter code  
- Ensure the application's performance, quality, and responsiveness  

### 🔌 API Integration
- Connect mobile applications with backend services through RESTful APIs  
- Implement secure authentication flows (login, signup, password reset, OTP)  
- Handle API responses, error states, and loading indicators  
- Set up data caching mechanisms for improved performance  

### 🧠 State Management
- Implement efficient state management solutions (Cubit)  
- Handle complex UI states and transitions  

### 🌐 Localization
- Implement multi-language support for Arabic and English  
- Set up and maintain language JSON files for all text content  

### 🔐 Storage & Security
- Implement secure storage for sensitive user data  
- Handle device permissions appropriately  

---

## ✅ Phase 1 (Completed)
- ✅ All application screens have been fully designed and implemented based on the approved UI specifications  
- ✅ Implemented onboarding screens with smooth animations  
- ✅ Built authentication flows (login, signup, password reset)  
- ✅ Created OTP verification screens and functionality  
- ✅ Set up secure storage for user credentials  
- ✅ Implemented API service classes for backend communication  
- ✅ Created localization structure for Arabic and English support  
- ✅ All application text has been fully translated (Arabic and English)  
- ✅ Dark mode and light mode themes have been fully implemented  

---

## 🚧 Phase 2 (In Progress)
-  Pending API integration once the backend team completes the database setup  
-  Food item browsing and categorization screens are completed  
-  Order tracking interface with map integration has been designed  
-  User profile management screens are ready  
-  Payment UI is implemented and will be connected to the payment gateway later  

---

## 🧱 Code Standards
- Follow clean architecture principles  
- Maintain separation of concerns between UI, business logic, and data layers  
- Write reusable and maintainable code  

---

## 🗂 Repository Structure

```plaintext
assets/                         # Static resources
├── icons/                      # App icons
├── images/                     # Images and illustrations
└── lottie/                     # Lottie animation files

lib/
├── const_values.dart           # Constants and config values
├── cubits/                     # Cubit files for state management
├── extensions/                 # Theme extensions and custom extensions
├── helper/                     # Utility functions
├── l10n/                       # Localization files
├── models/                     # Data models
├── states/                     # Cubit states
├── theme/                      # App theme setup (light/dark)
├── view/                       # UI screens and widgets
│   └── src/                    # Possibly feature-based screen organization
├── main.dart                   # App entry point
├── my_bloc_observer.dart       # Custom BlocObserver
└── my_navigator_observer.dart  # Custom navigator observer
