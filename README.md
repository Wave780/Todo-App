

# 📝 Riverpod Todo App

A clean and functional **Todo app** built with **Flutter** and **Riverpod**, showcasing state management best practices and essential task management features.

## ✨ Features

✅ **Add new todos** with a text input  
✅ **Mark todos as complete/incomplete** using checkboxes  
✅ **Delete todos** with a delete button  
✅ **Filter todos** by status:
- All
- Active
- Completed  
  ✅ **Show todo counts**: total, completed, and pending  
  ✅ **Edit existing todos** with an inline dialog  
  ✅ **Simple theme persistence** using `SharedPreferences`

---

## 📸 Screenshots

![](https://github.com/Wave780/Todo-App/blob/main/assets/Mobile-view-preview.gif)

 ![](https://github.com/Wave780/Todo-App/blob/main/assets/Web-view-dark-theme.png) 
 ![](https://github.com/Wave780/Todo-App/blob/main/assets/Web-view-edit-dialog.png)
 ![](https://github.com/Wave780/Todo-App/blob/main/assets/Web-view-home-page.png) 
 ![](https://github.com/Wave780/Todo-App/blob/main/assets/mobile-view-home-page.png) 
 ![](https://github.com/Wave780/Todo-App/blob/main/assets/mobile-view-theme.png) 


---

## 🛠️ Tech Stack

- **Flutter** — UI framework
- **Riverpod** — State management
- **SharedPreferences** — Local storage for theme persistence
- **Dart** — Programming language

---

## 🚀 Getting Started

### 1️⃣ Clone the repository
```bash
git clone https://github.com/Wave780/Todo-App.git
cd riverpod_todo_app
```

### 2️⃣ Install dependencies
```bash
flutter pub get
```

### 3️⃣ Run the app
```bash
flutter run
```

---

## 📂 Project Structure
```
lib/
│
├── model/
│
├── provider/
│   └── todo_providers.dart
│
├── screen/
│   ├── todo_dashboard.dart
│   └── todo_setting.dart
│
├── theme/
│   ├── app_theme.dart
│   └── theme_provider.dart
│
├── utils/
│   ├── preference_service.dart
│   └── widgets/
│       ├── todo_filter.dart
│       ├── todo_item.dart
│       └── todo_stats.dart
│
└── main.dart
```

---

## ⚙️ How It Works

- **State Management:** All app state is handled by Riverpod providers and `StateNotifier`.
- **Persistence:** The selected theme is saved locally using `SharedPreferences` and restored on launch.
- **Editing Todos:** Opens a dialog with the current title pre-filled for easy changes.
- **Filtering:** A simple toggle system updates the UI reactively based on selected filter.

---

## 📌 Todo Enhancements

- [ ] Add dark mode toggle
- [ ] Support for cloud sync (Supabase / Firebase)
- [ ] Drag-and-drop todo reordering

---
