# HandyCourse 📚

A comprehensive iOS course management application built with SwiftUI and Firebase, enabling seamless interaction between instructors and students in an educational environment.

## 🌟 Features

### For Students
- **Course Discovery**: Browse and enroll in courses across multiple categories
- **Interactive Learning**: Watch video content and track learning progress
- **Grade Tracking**: View grades and academic performance
- **Profile Management**: Manage personal information and course enrollment

### For Instructors
- **Course Management**: Create, edit, and manage course offerings
- **Content Creation**: Add video content and learning materials
- **Student Management**: Track enrolled students and manage class rosters
- **Grade Management**: Assign and update student grades

### General Features
- **User Authentication**: Secure login and registration system
- **Role-based Access**: Different interfaces for students and instructors
- **Real-time Data**: Live updates using Firebase Firestore
- **Media Storage**: Video and image storage with Firebase Storage
- **Responsive UI**: Modern SwiftUI interface optimized for iOS

## 🏗️ Architecture

### Technology Stack
- **Frontend**: SwiftUI (iOS)
- **Backend**: Firebase
  - Authentication: Firebase Auth
  - Database: Firestore
  - Storage: Firebase Storage
- **Language**: Swift
- **Minimum iOS Version**: iOS 14.0+

### Project Structure
```
CollegeApplication/
├── Models/
│   ├── Course/           # Course-related data models
│   │   ├── Course.swift
│   │   ├── CourseCategory.swift
│   │   ├── CourseContents.swift
│   │   └── StudentGrade.swift
│   └── Users/            # User-related data models
│       ├── User.swift
│       └── UserRole.swift
├── Views/
│   ├── Student/          # Student-specific views
│   ├── Instructor/       # Instructor-specific views
│   └── [Common Views]    # Shared UI components
├── Controllers/          # Firebase and utility helpers
│   ├── FireAuthHelper.swift
│   ├── FireDBHelper.swift
│   └── FireStorageHelper.swift
└── Components/           # Reusable UI components
```

## 🚀 Getting Started

### Prerequisites
- Xcode 12.0 or later
- iOS 14.0 or later
- Swift 5.3 or later
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/renhotsai/HandyCourse.git
   cd HandyCourse
   ```

2. **Open the project**
   ```bash
   open CollegeApplication.xcodeproj
   ```

3. **Firebase Configuration**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add an iOS app to your project
   - Download `GoogleService-Info.plist` and add it to your Xcode project
   - Enable the following Firebase services:
     - Authentication
     - Firestore Database
     - Storage

4. **Install Dependencies**
   - Dependencies are managed through Swift Package Manager
   - Firebase SDK will be automatically resolved when building the project

5. **Build and Run**
   - Select your target device/simulator
   - Press `Cmd + R` to build and run the application

## 📱 Usage

### Getting Started
1. Launch the app and create an account or sign in
2. Choose your role (Student or Instructor) during registration
3. Complete your profile setup

### As a Student
1. Browse available courses by category
2. Enroll in courses that interest you
3. Access course content and watch videos
4. Track your progress and grades

### As an Instructor
1. Create new courses with detailed descriptions
2. Upload course content and videos
3. Manage enrolled students
4. Assign and update grades

## 🎨 Course Categories

The application supports the following course categories:
- **Tech**: Technology and programming courses
- **Data Science**: Analytics and data-related courses
- **Business**: Business and management courses
- **Language**: Language learning courses
- **Art**: Creative and artistic courses
- **Personal Dev**: Personal development courses

## 🔧 Configuration

### Firebase Setup
Ensure your `GoogleService-Info.plist` contains the correct configuration for:
- Project ID
- API Keys
- Storage Bucket
- App ID

### App Configuration
Key configuration files:
- `Info.plist`: App permissions and settings
- Firebase configuration is handled automatically through `GoogleService-Info.plist`

## 🤝 Contributing

We welcome contributions to HandyCourse! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines
- Follow Swift and SwiftUI best practices
- Maintain consistent code formatting
- Add appropriate comments for complex logic
- Test your changes thoroughly
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Renho Tsai** - Lead Developer
- **이현성 (Hyunseong Lee)** - UI/UX Developer
- **Aman Chahal** - Backend Developer

## 🐛 Issues and Support

If you encounter any issues or have questions:
1. Check existing issues on GitHub
2. Create a new issue with detailed description
3. Provide steps to reproduce the problem
4. Include screenshots if applicable

## 🔄 Version History

- **v1.0.0** - Initial release with core functionality
- Course management system
- User authentication
- Video content support
- Grade tracking

## 🛠️ Future Enhancements

- Push notifications for new course content
- Offline course content viewing
- Discussion forums for courses
- Certificate generation
- Payment integration
- Multi-language support

---

Made with ❤️ by the HandyCourse Team