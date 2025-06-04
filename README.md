# Kitetech Student Portal

A comprehensive Flutter application for managing student information and services at Kitetech University.

## Features

- **Student Card Management**: Digital student ID cards with barcode functionality
- **Student Information Display**: Comprehensive student profile viewing
- **Interactive UI**: Modern design with animations and gradients
- **Chat System**: Communication platform for students
- **Responsive Design**: Optimized for mobile devices

## Project Structure

- `lib/presentation/widget/student/` - Student-related UI components
  - `student_card.dart` - Animated student card with gradient design
  - `student_detail_card.dart` - Detailed student information card with barcode
- `lib/presentation/view/main/chat/` - Chat functionality
- `lib/data/repository/` - Data models and repository patterns

## Key Components

### StudentCard
An animated, gradient-styled card displaying basic student information with tap animations.

### StudentDetailCard
A formal student ID card layout with institutional branding, student photo, and barcode generation.

## Getting Started

This is a Flutter application for Kitetech University's student portal system.

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio / VS Code

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

- `flutter/material.dart` - Material Design components
- `barcode_widget` - Barcode generation functionality

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
