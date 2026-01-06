# Flutter Training - Branch 07: Theme & Styling

## Mục tiêu học tập (Learning Goals)

Branch này giúp bạn hiểu được:
- Tại sao không nên hard-code styles
- Cách sử dụng ThemeData để quản lý styles
- ColorScheme và cách sử dụng màu sắc từ theme
- TextTheme và cách sử dụng kiểu chữ từ theme
- Button styling qua theme
- Light và Dark theme
- Cách sử dụng Theme.of(context)

## Khái niệm chính (Key Concepts)

### 1. Tại sao không hard-code styles?

**Vấn đề với hard-code styles:**

1. **Khó bảo trì**
   - Phải thay đổi ở nhiều nơi khi muốn đổi style
   - Dễ quên một số nơi, tạo ra inconsistency

2. **Không nhất quán**
   - Mỗi developer có thể dùng màu/kích thước khác nhau
   - Khó đảm bảo tất cả widget có cùng style

3. **Không hỗ trợ dark mode**
   - Phải viết lại code để hỗ trợ dark mode
   - Khó quản lý khi có nhiều màn hình

4. **Khó tùy chỉnh**
   - Người dùng không thể thay đổi theme
   - Khó thay đổi theme cho toàn bộ ứng dụng

**Ví dụ hard-code (SAI):**
```dart
// SAI - Hard-code màu sắc
Container(
  color: Colors.blue, // Hard-code
  child: Text(
    'Hello',
    style: TextStyle(
      color: Colors.white, // Hard-code
      fontSize: 16, // Hard-code
    ),
  ),
)
```

**Ví dụ dùng theme (ĐÚNG):**
```dart
// ĐÚNG - Dùng theme
Container(
  color: Theme.of(context).colorScheme.primary, // Từ theme
  child: Text(
    'Hello',
    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: Theme.of(context).colorScheme.onPrimary, // Từ theme
    ),
  ),
)
```

### 2. ThemeData - Quản lý theme

**ThemeData là gì:**
- Là class định nghĩa giao diện cho ứng dụng
- Chứa tất cả styles: màu sắc, kiểu chữ, button styles, etc.
- Được truyền vào MaterialApp

**Các thành phần chính của ThemeData:**

1. **colorScheme**: Bảng màu
2. **textTheme**: Kiểu chữ
3. **elevatedButtonTheme**: Style cho ElevatedButton
4. **cardTheme**: Style cho Card
5. **appBarTheme**: Style cho AppBar
6. Và nhiều hơn nữa...

**Cú pháp cơ bản:**
```dart
ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  textTheme: TextTheme(...),
  elevatedButtonTheme: ElevatedButtonThemeData(...),
  // ...
)
```

**Ví dụ:**
```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    textTheme: TextTheme(
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  ),
  home: MyHomePage(),
)
```

### 3. ColorScheme - Bảng màu

**ColorScheme là gì:**
- Định nghĩa bảng màu nhất quán cho ứng dụng
- Cung cấp các màu chính: primary, secondary, tertiary, error, etc.
- Tự động tạo màu tương phản (onPrimary, onSecondary, etc.)

**Các màu chính:**
- `primary`: Màu chủ đạo
- `secondary`: Màu phụ
- `tertiary`: Màu thứ ba
- `error`: Màu lỗi
- `surface`: Màu nền surface
- `background`: Màu nền chính

**Màu tương phản:**
- `onPrimary`: Màu text trên primary
- `onSecondary`: Màu text trên secondary
- `onSurface`: Màu text trên surface
- `onBackground`: Màu text trên background

**Cách tạo ColorScheme:**
```dart
// Từ seed color (tự động tạo bảng màu)
ColorScheme.fromSeed(seedColor: Colors.blue)

// Tùy chỉnh
ColorScheme(
  primary: Colors.blue,
  secondary: Colors.green,
  // ...
)
```

**Ví dụ sử dụng:**
```dart
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'Hello',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
    ),
  ),
)
```

### 4. TextTheme - Kiểu chữ

**TextTheme là gì:**
- Định nghĩa các kiểu chữ nhất quán cho ứng dụng
- Cung cấp các kiểu: display, headline, title, body, label

**Các kiểu chữ:**
- `displayLarge`, `displayMedium`, `displaySmall`: Text lớn nhất
- `headlineLarge`, `headlineMedium`, `headlineSmall`: Tiêu đề lớn
- `titleLarge`, `titleMedium`, `titleSmall`: Tiêu đề
- `bodyLarge`, `bodyMedium`, `bodySmall`: Văn bản body
- `labelLarge`, `labelMedium`, `labelSmall`: Label

**Cú pháp:**
```dart
TextTheme(
  displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(fontSize: 16),
  bodyMedium: TextStyle(fontSize: 14),
)
```

**Ví dụ sử dụng:**
```dart
Text(
  'Title',
  style: Theme.of(context).textTheme.titleLarge,
)

Text(
  'Body text',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

### 5. Button Styling qua Theme

**Button Theme là gì:**
- Định nghĩa style cho các loại button
- Áp dụng tự động cho tất cả button cùng loại
- Bao gồm: ElevatedButton, OutlinedButton, TextButton

**Các loại Button Theme:**
- `elevatedButtonTheme`: Style cho ElevatedButton
- `outlinedButtonTheme`: Style cho OutlinedButton
- `textButtonTheme`: Style cho TextButton

**Cú pháp:**
```dart
elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
)
```

**Ví dụ:**
```dart
// Button tự động dùng style từ theme
ElevatedButton(
  onPressed: () {},
  child: Text('Click me'),
)
// Không cần chỉ định style, tự động lấy từ theme
```

### 6. Light & Dark Theme

**Light Theme:**
- Theme cho chế độ sáng
- Màu nền sáng, text tối
- Đặt trong `MaterialApp.theme`

**Dark Theme:**
- Theme cho chế độ tối
- Màu nền tối, text sáng
- Đặt trong `MaterialApp.darkTheme`

**ThemeMode:**
- `ThemeMode.system`: Theo hệ thống
- `ThemeMode.light`: Luôn dùng light theme
- `ThemeMode.dark`: Luôn dùng dark theme

**Cú pháp:**
```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light, // Light theme
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark, // Dark theme
    ),
  ),
  themeMode: ThemeMode.system, // Theo hệ thống
)
```

**Ví dụ:**
```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
  ),
  themeMode: ThemeMode.system,
)
```

### 7. Theme.of(context) - Lấy theme

**Theme.of(context) là gì:**
- Method để lấy ThemeData từ BuildContext
- Trả về ThemeData hiện tại (light hoặc dark)
- Tự động cập nhật khi theme thay đổi

**Cách sử dụng:**
```dart
// Lấy ColorScheme
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.secondary

// Lấy TextTheme
Theme.of(context).textTheme.bodyLarge
Theme.of(context).textTheme.titleMedium

// Lấy Button Theme
Theme.of(context).elevatedButtonTheme

// Lấy Brightness
Theme.of(context).brightness // Brightness.light hoặc Brightness.dark
```

**Ví dụ:**
```dart
Widget build(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.primary,
    child: Text(
      'Hello',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ),
  );
}
```

**Lưu ý:**
- Theme.of(context) chỉ hoạt động trong widget tree có MaterialApp
- Tự động rebuild khi theme thay đổi
- Nên dùng thay vì hard-code styles

## Cấu trúc code

```
lib/
  └── main.dart
      ├── MyApp (StatelessWidget) - Widget gốc với ThemeData
      │   ├── theme (Light theme)
      │   ├── darkTheme (Dark theme)
      │   └── themeMode
      └── ThemeAndStylingDemo (StatefulWidget) - Demo theme
          └── _ThemeAndStylingDemoState
              ├── _themeMode - Quản lý theme mode
              ├── _toggleTheme() - Chuyển đổi theme
              └── build() - Hiển thị demo
```

## Cách chạy ứng dụng

1. Đảm bảo bạn đang ở branch `07-theme_and_styling`
2. Chạy lệnh:
   ```bash
   flutter run -d windows
   ```
3. Thử nghiệm:
   - Xem các màu từ ColorScheme
   - Xem các kiểu chữ từ TextTheme
   - Nhấn các button và quan sát style từ theme
   - Chuyển đổi giữa light và dark theme bằng các icon trên AppBar
   - So sánh hard-code style vs theme style

## Lỗi thường gặp (Common Mistakes)

### ❌ Lỗi 1: Hard-code màu sắc
```dart
// SAI - Hard-code màu
Container(
  color: Colors.blue, // SAI!
  child: Text('Hello', style: TextStyle(color: Colors.white)),
)

// ĐÚNG - Dùng theme
Container(
  color: Theme.of(context).colorScheme.primary, // ĐÚNG
  child: Text(
    'Hello',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
    ),
  ),
)
```

### ❌ Lỗi 2: Hard-code kích thước font
```dart
// SAI - Hard-code kích thước
Text('Hello', style: TextStyle(fontSize: 16)) // SAI!

// ĐÚNG - Dùng TextTheme
Text('Hello', style: Theme.of(context).textTheme.bodyLarge) // ĐÚNG
```

### ❌ Lỗi 3: Quên dark theme
```dart
// SAI - Chỉ có light theme
MaterialApp(
  theme: ThemeData(...),
  // Thiếu darkTheme
)

// ĐÚNG - Có cả light và dark theme
MaterialApp(
  theme: ThemeData(...),
  darkTheme: ThemeData(...), // Có dark theme
  themeMode: ThemeMode.system,
)
```

### ❌ Lỗi 4: Dùng Theme.of(context) ngoài MaterialApp
```dart
// SAI - Không có MaterialApp
void main() {
  runApp(Container(
    color: Theme.of(context).colorScheme.primary, // Lỗi!
  ));
}

// ĐÚNG - Có MaterialApp
void main() {
  runApp(MaterialApp(
    theme: ThemeData(...),
    home: MyWidget(), // MyWidget có thể dùng Theme.of(context)
  ));
}
```

### ❌ Lỗi 5: Không dùng màu tương phản
```dart
// SAI - Text không đọc được
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'Hello',
    style: TextStyle(
      color: Theme.of(context).colorScheme.primary, // SAI - Cùng màu!
    ),
  ),
)

// ĐÚNG - Dùng màu tương phản
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'Hello',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onPrimary, // ĐÚNG - Tương phản
    ),
  ),
)
```

## Tóm tắt (Summary)

| Khái niệm | Mô tả | Lợi ích |
|-----------|-------|---------|
| ThemeData | Quản lý tất cả styles | Tập trung, nhất quán |
| ColorScheme | Bảng màu | Tự động tương phản, hỗ trợ dark mode |
| TextTheme | Kiểu chữ | Nhất quán, dễ bảo trì |
| Button Theme | Style button | Áp dụng tự động cho tất cả button |
| Light/Dark Theme | Theme sáng/tối | Hỗ trợ dark mode |
| Theme.of(context) | Lấy theme | Tự động cập nhật, dễ sử dụng |

## Câu hỏi tự kiểm tra (Self-check Questions)

1. Tại sao không nên hard-code styles?
2. ThemeData làm gì? Các thành phần chính?
3. ColorScheme là gì? Các màu chính?
4. TextTheme là gì? Các kiểu chữ?
5. Làm sao style button qua theme?
6. Làm sao tạo light và dark theme?
7. Theme.of(context) làm gì? Cách sử dụng?

## Tài liệu tham khảo

- [Flutter Documentation - Themes](https://docs.flutter.dev/cookbook/design/themes)
- [Flutter Documentation - ThemeData](https://api.flutter.dev/flutter/material/ThemeData-class.html)
- [Flutter Documentation - ColorScheme](https://api.flutter.dev/flutter/material/ColorScheme-class.html)
- [Flutter Documentation - TextTheme](https://api.flutter.dev/flutter/material/TextTheme-class.html)
- [Material Design - Color System](https://material.io/design/color/the-color-system.html)
