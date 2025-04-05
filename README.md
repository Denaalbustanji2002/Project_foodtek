# Flutter Developer Role - Foodtek Restaurant Management System

## Role Overview
As a Flutter Developer for the Foodtek project, you are responsible for implementing the cross-platform mobile applications (Client and Driver apps) using Flutter framework. Your work is essential for delivering a seamless, performant, and visually appealing user experience across iOS and Android devices.

## Key Responsibilities

### Development
- Develop responsive and adaptive UI screens based on the provided designs
- Implement client-side business logic for both Customer and Driver applications
- Build reusable components and widgets to maintain consistency across the application
- Convert UI/UX designs from design tools (Figma) into functional Flutter code
- Ensure the application's performance, quality, and responsiveness

### API Integration
- Connect mobile applications with backend services through RESTful APIs
- Implement secure authentication flows (login, signup, password reset, OTP)
- Handle API responses, error states, and loading indicators
- Set up data caching mechanisms for improved performance

### State Management
- Implement efficient state management solutions (Cubit)
- Handle complex UI states and transitions

### Localization
- Implement multi-language support for Arabic and English
- Set up and maintain language JSON files for all text content

### Storage & Security
- Implement secure storage for sensitive user data
- Handle device permissions appropriately
- 
## Current Progress

### Phase 1 (Completed)
- Implemented onboarding screens with smooth animations
- Built authentication flows (login, signup, password reset)
- Created OTP verification screens and functionality
- Set up secure storage for user credentials
- Implemented API service classes for backend communication
- Created localization structure for Arabic and English support
  

### Phase 2 (In Progress)
- All application screens have been fully designed and implemented based on the approved UI specifications (Completed)
- Pending API integration once the backend team completes the database setup
- Food item browsing and categorization screens are completed
- Order tracking interface with map integration has been designed
- User profile management screens are ready
- Payment UI is implemented and will be connected to the payment gateway later


### Code Standards
- Follow clean architecture principles
- Maintain separation of concerns between UI, business logic, and data layers
- Write reusable and maintainable code


## Repository Structure
```
assets/                     # Contains static resources
├── icons/                  # App icons
└── images/                 # App images and illustrations

lib/
├── const_values/           # Constants and configuration values
├── cubits/                 # Cubit files for state management
├── states/                 # State classes for each cubit
├── models/                 # Data models used across the app
├── l10n/                   # Localization files
├── helper/                 # Helper functions and utilities
├── views/                  # App UI
│   ├── screens/            # Screens grouped by features
│   └── widgets/            # Reusable custom widgets
├── my_bloc_observer.dart   # Custom BlocObserver for debugging
└── main.dart               # Application entry point

```

## Next Steps for Flutter Development
- Integrate APIs for all backend data
- Use Http for RESTful API calls
- Handle loading, error, and success states properly
- Implement state management using Bloc(Cubit)
- Separate business logic from UI
- Manage shared states like cart, user, and orders
- Build cart functionality with local storage
- Use shared_preferences temporary cart data
- Sync with backend when placing an order
- Connect to backend APIs to fetch and display order data
- Implement real-time status updates if available
- Add location services and map integration
- Use geolocator to get user’s current location
- Use Google Maps Flutter plugin to display delivery tracking
- Enable login with Google, Facebook, and Apple (for iOS)
- Set up user profile management
- Fetch and update user profile via API
- Store basic user info locally for quick access
- Implement payment method UI functionality
- Handle user input for payment options
- Prepare integration layer for future payment gateways
- Configure Firebase Cloud Messaging (FCM)
- Handle push notifications in background and foreground
---

## Assets & Resources
-To preview the actual UI of the application in action, you can view a collection of screenshots from the running app using the link below:  [Google Drive - FoodTek Project Folder](https://drive.google.com/drive/folders/1J3FlnZ0GsS3HuWKh1MiKn9Vi6vDodi9f?usp=drive_link)
