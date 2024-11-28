# Qitaby 📚

A Flutter-based school book marketplace app designed to connect students and parents for buying and selling school books.

## Overview

**Qitaby** is a modern platform that simplifies the process of trading school books. Built with Flutter and powered by Firebase, the app offers a seamless experience for users to upload books for sale, browse available books, and manage purchases through a cart system.

## Features

- **User Authentication**:
  - Sign in and sign up using Firebase Authentication.
  - Guest access for browsing books.
- **Book Management**:
  - Upload books for sale, complete with details like name, price, condition, school name, and grade.
  - Browse books uploaded by other users.
- **Search and Filters**:
  - Search for books based on `name` and `schoolName`.
  - Filter books by grade, price, and other criteria.
- **Cart System**:
  - Add books to your cart for easy purchase management.
- **User Profile**:
  - View and edit user profile information, including username, address, and phone number.
- **Admin Features**:
  - Admin interface to manage books and users (view, filter, edit, and delete).
- **Dark Green Theme**:
  - A visually appealing UI styled with dark green accents for consistency and elegance.
- **Disclaimer**:
  - A dedicated section outlining responsibilities regarding book quality and condition.

## Tech Stack

### Frontend
- **Flutter**: For building a responsive and cross-platform user interface.

### Backend
- **Firebase**:
  - **Authentication**: User sign-in/sign-up functionality.
  - **Firestore**: Database for storing books and user data.
  - **Storage**: For uploading and managing book images.

## App Screens

### 1. **Home Screen**
   - Displays a list of available books with options to view details, add to cart, or buy.

### 2. **Book Details**
   - Detailed view of a selected book with information like title, school name, price, and seller details.

### 3. **Sign Up and Sign In**
   - User authentication for account creation and login.

### 4. **Profile Screen**
   - A personalized profile page for managing user details and viewing uploaded books.

### 5. **Admin Interface**
   - Tools for admins to manage user-uploaded content.

## Used Packages

- **firebase_auth**: User authentication.
- **cloud_firestore**: Database for books and users.
- **provider**: State management for efficient UI updates.
- **fl_chart**: For visualizing data (e.g., sales charts, book stats).
- **shared_preferences**: Storing user preferences locally.
- **flutter_local_notifications**: For notifications on book updates and messages.

