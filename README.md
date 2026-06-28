# GeoAlarm - Premium Alarm App MVP

A beautiful, modern Flutter alarm application featuring glassmorphism design with time-based and location-based alarm capabilities.

## Features

- **Dual Alarm Types**
  - Time-based alarms with repeat functionality
  - Location-based alarms with customizable radius

- **Premium UI/UX**
  - Glassmorphism design system
  - Light and Dark mode support
  - Smooth animations and transitions
  - iOS-inspired interface

- **Complete Navigation**
  - Home dashboard with statistics
  - Set Alarm with tabbed interface
  - History with filtering and search
  - Profile with settings

## Tech Stack

- **Flutter** - Latest stable version
- **GetX** - State management and routing
- **Dio** - HTTP client (structure only)
- **Google Fonts** - Inter font family
- **Material Design 3** - UI components

## Project Structure

```
lib/
├── controller/              # GetX Controllers
│   ├── home_controller.dart
│   ├── set_alarm_controller.dart
│   ├── history_controller.dart
│   ├── profile_controller.dart
│   └── navigation_controller.dart
│
├── helper/                  # Helper classes
│   └── dummy_data.dart
│
├── models/                  # Data models
│   ├── alarm_model.dart
│   ├── user_model.dart
│   └── statistics_model.dart
│
├── themes/                  # Theme configuration
│   ├── app_colors.dart
│   └── app_theme.dart
│
├── utils/                   # Utilities
│   ├── constants.dart
│   ├── responsive.dart
│   ├── app_routes.dart
│   └── app_pages.dart
│
└── view/                    # UI Layer
    ├── base/
    │   └── main_navigation.dart
    ├── screen/
    │   ├── splash_screen.dart
    │   ├── home_screen.dart
    │   ├── set_alarm_screen.dart
    │   ├── history_screen.dart
    │   ├── profile_screen.dart
    │   └── unknown_route_screen.dart
    └── widget/
        ├── glass_container.dart
        ├── glass_button.dart
        ├── glass_text_field.dart
        ├── glass_card.dart
        ├── glass_app_bar.dart
        ├── glass_switch.dart
        ├── glass_slider.dart
        ├── glass_dialog.dart
        ├── glass_list_tile.dart
        ├── glass_section_title.dart
        └── glass_bottom_navigation.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / Xcode (for platform-specific builds)

### Installation

1. **Get dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Screens

### 1. Splash Screen
- Animated app logo
- Smooth fade-in animation
- Auto-navigation to home

### 2. Home Screen
- Greeting based on time of day
- Search functionality
- Statistics cards (Total, Time, Location alarms)
- Recent alarms list
- Floating action button to create alarm

### 3. Set Alarm Screen
- **Time Alarm Tab**
  - Alarm title input
  - Time picker
  - Repeat functionality with day selection
  - Alarm sound selection

- **Location Alarm Tab**
  - Alarm title input
  - Location picker (placeholder)
  - Radius slider (100m - 2000m)
  - Location preview card

### 4. History Screen
- Search functionality
- Filter chips (All, Time, Location, Active, Completed)
- Swipe-to-delete functionality
- Detailed alarm cards with status badges

### 5. Profile Screen
- User profile card with avatar
- Settings:
  - Notifications toggle
  - Dark mode toggle
  - Language selection
  - Privacy policy
  - About
- Logout functionality

## Features Implemented

### UI Components
- ✅ Glassmorphism containers
- ✅ Glass buttons (filled and outlined)
- ✅ Glass text fields
- ✅ Glass cards
- ✅ Glass app bar
- ✅ Glass switches
- ✅ Glass sliders
- ✅ Glass dialogs
- ✅ Glass list tiles
- ✅ Glass bottom navigation

### State Management
- ✅ GetX controllers for all features
- ✅ Reactive state management
- ✅ Proper bindings

### Routing
- ✅ Named routes
- ✅ GetX navigation
- ✅ Route transitions
- ✅ Unknown route handling

### Theme
- ✅ Light mode
- ✅ Dark mode
- ✅ Dynamic theme switching
- ✅ Custom color palette
- ✅ Typography system

### Animations
- ✅ Page transitions
- ✅ Tab animations
- ✅ Button animations
- ✅ Fade animations
- ✅ Scale animations

## Dummy Data

The app includes comprehensive dummy data for development:
- 12 sample alarms (mix of time and location)
- User profile data
- Statistics data
- Various alarm statuses

## Architecture

### Feature-Based Architecture
Each feature is organized with:
- Controller (business logic)
- Binding (dependency injection)
- View (UI)
- Models (data structures)

### Clean Code Principles
- SOLID principles
- Reusable components
- Separation of concerns
- Meaningful naming conventions
- Comprehensive comments

## Color Palette

### Light Mode
- Background: `#F8FAFC`
- Primary: `#6A11CB`
- Secondary: `#2575FC`

### Dark Mode
- Background: `#0F172A`
- Primary: `#8B5CF6`
- Secondary: `#3B82F6`

### Gradients
- Primary: Purple to Blue
- Dark: Navy to Dark Blue
- Button: Purple to Blue

## Next Steps (Future Implementation)

This is an MVP focused on UI/UX. Future implementation would include:

1. **Alarm Functionality**
   - Android AlarmManager
   - iOS Local Notifications
   - Background service

2. **Location Services**
   - Google Maps integration
   - Geofencing
   - Location tracking

3. **Persistence**
   - Local database (Hive/SQLite)
   - Shared preferences
   - Data synchronization

4. **Backend Integration**
   - API integration with Dio
   - User authentication
   - Cloud sync

## Notes

- No actual alarm functionality implemented (UI only)
- Location picker is placeholder
- All data is dummy/static
- No database implementation
- No API integration

## License

This is an MVP project for demonstration purposes.

## Author

Created with Flutter & GetX
Version 1.0.0
