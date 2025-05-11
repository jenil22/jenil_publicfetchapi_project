# Flutter Article App
A Flutter app that fetches and displays a list of articles from a public
API.
## Features
- List of articles
- Search functionality
- Detail view
- Responsive UI
## Setup Instructions
1. Clone the repo:
git clone <your-repo-link>
cd flutter_article_app
2. Install dependencies:
flutter pub get
3. Run the app:
flutter run
## Tech Stack
- Flutter SDK: 3.29.3
- State Management: Cubit, Clean Architecture
- HTTP Client: http
- Persistence: hive

## State Management Explanation
In this project, i have used cubit state mangement with clean architecture. And create differenet state for loading, loaded and error. 
Also Hanlde the client filter logic from state mangement itself.

## Known Issues / Limitations
- Can add Fav Button from Post Details Page.
