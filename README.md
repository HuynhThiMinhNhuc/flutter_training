# Flutter Training - Branch 06: Material Overview

## Mục tiêu học tập (Learning Goals)

Branch này giúp bạn hiểu được:
- Material Design trong Flutter là gì
- Tại sao MaterialApp là bắt buộc
- Cấu trúc và thứ bậc của Material widgets
- Cách sử dụng Scaffold, AppBar, FloatingActionButton, BottomNavigationBar
- Mối quan hệ giữa các Material widgets

## Khái niệm chính (Key Concepts)

### 1. Material Design là gì?

**Material Design:**
- Là hệ thống thiết kế được Google phát triển
- Cung cấp hướng dẫn về giao diện, màu sắc, typography, animation
- Tạo ra trải nghiệm người dùng nhất quán trên các nền tảng

**Material Design trong Flutter:**
- Flutter cung cấp Material widgets để xây dựng UI theo Material Design
- MaterialApp là điểm khởi đầu để sử dụng Material Design
- Tất cả Material widgets đều cần MaterialApp

### 2. MaterialApp - Widget gốc

**MaterialApp là gì:**
- Widget gốc (root widget) để sử dụng Material Design
- BẮT BUỘC phải có để dùng các Material widgets khác
- Cung cấp theme, navigation, và context cho Material widgets

**Tại sao MaterialApp là BẮT BUỘC?**

1. **Cung cấp Material Design Theme**
   - Màu sắc (colors)
   - Kiểu chữ (typography)
   - Button styles
   - Card styles
   - Và nhiều hơn nữa

2. **Quản lý Navigation**
   - Navigator để điều hướng giữa các màn hình
   - Route management
   - Back button handling

3. **Cung cấp Context cho Material Widgets**
   - AppBar cần MaterialApp để lấy theme
   - FloatingActionButton cần MaterialApp để lấy colors
   - BottomNavigationBar cần MaterialApp để lấy style

4. **Xử lý Localization**
   - Đa ngôn ngữ
   - Date/time formatting
   - Number formatting

5. **Material Design Widgets**
   - Không thể dùng Scaffold, AppBar, FloatingActionButton mà không có MaterialApp
   - Các widget này sẽ lỗi nếu không có MaterialApp

**Cú pháp cơ bản:**
```dart
MaterialApp(
  title: 'My App',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  ),
  home: MyHomePage(),
)
```

**Ví dụ lỗi nếu không có MaterialApp:**
```dart
// SAI - Không có MaterialApp
void main() {
  runApp(Scaffold(
    appBar: AppBar(title: Text('Hello')),
    body: Text('World'),
  ));
}
// Lỗi: Scaffold cần MaterialApp

// ĐÚNG - Có MaterialApp
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Hello')),
      body: Text('World'),
    ),
  ));
}
```

### 3. Scaffold - Cấu trúc màn hình

**Scaffold là gì:**
- Widget cung cấp cấu trúc cơ bản cho màn hình Material Design
- Giống như "khung xương" của màn hình
- Chứa các thành phần: AppBar, Body, FloatingActionButton, BottomNavigationBar

**Các thành phần của Scaffold:**

1. **appBar**: Thanh tiêu đề ở trên cùng
2. **body**: Nội dung chính của màn hình
3. **floatingActionButton**: Nút nổi ở góc dưới bên phải
4. **bottomNavigationBar**: Thanh điều hướng ở dưới cùng
5. **drawer**: Menu bên (có thể kéo ra)
6. **endDrawer**: Menu bên phải

**Cú pháp cơ bản:**
```dart
Scaffold(
  appBar: AppBar(title: Text('Title')),
  body: Center(child: Text('Body')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: [...],
  ),
)
```

**Lưu ý:**
- Scaffold CẦN MaterialApp để hoạt động
- Không phải tất cả thành phần đều bắt buộc
- Có thể chỉ dùng appBar và body

### 4. AppBar - Thanh tiêu đề

**AppBar là gì:**
- Widget hiển thị thanh tiêu đề ở trên cùng màn hình
- Theo Material Design guidelines
- Tự động xử lý back button, elevation, và animation

**Các thành phần của AppBar:**

1. **leading**: Widget ở bên trái
   - Thường là menu icon hoặc back button
   - Mặc định: back button (nếu có route trước đó)

2. **title**: Tiêu đề chính
   - Ở giữa AppBar
   - Thường là Text widget

3. **actions**: Các widget ở bên phải
   - Thường là IconButton
   - Có thể có nhiều actions

4. **backgroundColor**: Màu nền
   - Lấy từ theme hoặc tùy chỉnh

**Cú pháp cơ bản:**
```dart
AppBar(
  title: Text('My App'),
  backgroundColor: Colors.blue,
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {},
    ),
  ],
)
```

**Ví dụ:**
```dart
AppBar(
  title: Text('Home'),
  leading: IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
  ),
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
  ],
)
```

### 5. FloatingActionButton - Nút nổi

**FloatingActionButton là gì:**
- Nút nổi (floating) ở góc dưới bên phải màn hình
- Có hiệu ứng nổi (elevated) theo Material Design
- Thường dùng cho hành động chính (primary action)

**Đặc điểm:**
- Luôn ở vị trí cố định (góc dưới phải)
- Có elevation (bóng đổ) để tạo hiệu ứng nổi
- Thường chứa Icon
- Có thể có tooltip

**Cú pháp cơ bản:**
```dart
FloatingActionButton(
  onPressed: () {
    // Xử lý khi nhấn
  },
  tooltip: 'Add',
  child: Icon(Icons.add),
)
```

**Các biến thể:**
- `FloatingActionButton`: Nút tròn tiêu chuẩn
- `FloatingActionButton.extended`: Nút mở rộng với text
- `FloatingActionButton.small`: Nút nhỏ hơn

**Ví dụ:**
```dart
FloatingActionButton(
  onPressed: () => print('Add pressed'),
  tooltip: 'Thêm mới',
  child: Icon(Icons.add),
)

FloatingActionButton.extended(
  onPressed: () {},
  icon: Icon(Icons.add),
  label: Text('Thêm mới'),
)
```

**Lưu ý:**
- FloatingActionButton CẦN MaterialApp
- Thường đặt trong Scaffold.floatingActionButton
- Có thể có nhiều FloatingActionButton (dùng Stack)

### 6. BottomNavigationBar - Thanh điều hướng

**BottomNavigationBar là gì:**
- Thanh điều hướng ở dưới cùng màn hình
- Hiển thị các tab/icon để điều hướng
- Theo Material Design guidelines

**Đặc điểm:**
- Thường có 2-5 items
- Item được chọn sẽ được highlight
- Dùng để điều hướng giữa các màn hình/tab
- Có 2 loại: fixed và shifting

**Cú pháp cơ bản:**
```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ],
)
```

**Các thuộc tính quan trọng:**
- `currentIndex`: Index của item được chọn
- `onTap`: Callback khi người dùng chọn item
- `items`: Danh sách các items
- `type`: Loại (fixed hoặc shifting)

**Ví dụ:**
```dart
int _currentIndex = 0;

BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  type: BottomNavigationBarType.fixed,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Trang chủ',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Hồ sơ',
    ),
  ],
)
```

**Lưu ý:**
- BottomNavigationBar CẦN MaterialApp
- Thường đặt trong Scaffold.bottomNavigationBar
- Nên có 2-5 items (Material Design guideline)

## Material Widget Hierarchy

**Thứ bậc widget Material:**

```
MaterialApp (gốc - BẮT BUỘC)
  └── Scaffold (cấu trúc màn hình)
      ├── AppBar (thanh tiêu đề)
      │   ├── leading (widget bên trái)
      │   ├── title (tiêu đề)
      │   └── actions (widgets bên phải)
      ├── Body (nội dung chính)
      │   └── (bất kỳ widget nào)
      ├── FloatingActionButton (nút nổi)
      │   └── child (thường là Icon)
      └── BottomNavigationBar (thanh điều hướng)
          └── items (danh sách các tab)
```

**Tại sao cần thứ bậc này:**
- MaterialApp cung cấp theme và context
- Scaffold sử dụng theme từ MaterialApp
- AppBar, FloatingActionButton, BottomNavigationBar sử dụng theme từ MaterialApp
- Tất cả đều phụ thuộc vào MaterialApp

## Cấu trúc code

```
lib/
  └── main.dart
      ├── MyApp (StatelessWidget) - Widget gốc với MaterialApp
      └── MaterialOverviewDemo (StatefulWidget) - Demo Material widgets
          └── _MaterialOverviewDemoState
              ├── build() - Scaffold với tất cả Material widgets
              ├── _buildBody() - Nội dung body
              ├── _buildHomeTab() - Tab trang chủ
              └── _buildProfileTab() - Tab hồ sơ
```

## Cách chạy ứng dụng

1. Đảm bảo bạn đang ở branch `06-material_overview`
2. Chạy lệnh:
   ```bash
   flutter run -d windows
   ```
3. Thử nghiệm:
   - Xem AppBar với actions
   - Nhấn FloatingActionButton
   - Chuyển đổi giữa các tab trong BottomNavigationBar
   - Quan sát cách các widget tương tác với nhau

## Lỗi thường gặp (Common Mistakes)

### ❌ Lỗi 1: Dùng Scaffold mà không có MaterialApp
```dart
// SAI - Lỗi vì không có MaterialApp
void main() {
  runApp(Scaffold(
    appBar: AppBar(title: Text('Hello')),
    body: Text('World'),
  ));
}

// ĐÚNG - Có MaterialApp
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Hello')),
      body: Text('World'),
    ),
  ));
}
```

### ❌ Lỗi 2: Quên setState() khi thay đổi currentIndex
```dart
// SAI - UI không cập nhật
int _currentIndex = 0;

BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    _currentIndex = index; // Thiếu setState()
  },
)

// ĐÚNG - Có setState()
onTap: (index) {
  setState(() {
    _currentIndex = index;
  });
}
```

### ❌ Lỗi 3: Dùng FloatingActionButton không có onPressed
```dart
// SAI - Button bị vô hiệu hóa
FloatingActionButton(
  child: Icon(Icons.add),
  // Thiếu onPressed
)

// ĐÚNG - Có onPressed
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
)
```

### ❌ Lỗi 4: Quên items trong BottomNavigationBar
```dart
// SAI - Thiếu items
BottomNavigationBar(
  currentIndex: 0,
  onTap: (index) {},
  // Thiếu items
)

// ĐÚNG - Có items
BottomNavigationBar(
  currentIndex: 0,
  onTap: (index) {},
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  ],
)
```

### ❌ Lỗi 5: Dùng Theme.of(context) mà không có MaterialApp
```dart
// SAI - Lỗi vì không có MaterialApp
Widget build(BuildContext context) {
  return Container(
    color: Theme.of(context).primaryColor, // Lỗi!
  );
}

// ĐÚNG - Có MaterialApp
MaterialApp(
  theme: ThemeData(...),
  home: MyWidget(), // MyWidget có thể dùng Theme.of(context)
)
```

## Tóm tắt (Summary)

| Widget | Mục đích | Có cần MaterialApp? |
|--------|----------|---------------------|
| MaterialApp | Widget gốc, cung cấp theme | Không (nó là gốc) |
| Scaffold | Cấu trúc màn hình | ✅ Có |
| AppBar | Thanh tiêu đề | ✅ Có |
| FloatingActionButton | Nút nổi | ✅ Có |
| BottomNavigationBar | Thanh điều hướng | ✅ Có |

## Câu hỏi tự kiểm tra (Self-check Questions)

1. Tại sao MaterialApp là bắt buộc?
2. Scaffold làm gì? Các thành phần của nó?
3. AppBar có những thành phần nào?
4. FloatingActionButton dùng để làm gì?
5. BottomNavigationBar có bao nhiêu items nên có?
6. Material Widget Hierarchy là gì?
7. Tại sao không thể dùng Scaffold mà không có MaterialApp?

## Tài liệu tham khảo

- [Flutter Documentation - Material Design](https://docs.flutter.dev/ui/design/material)
- [Flutter Documentation - MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
- [Flutter Documentation - Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html)
- [Flutter Documentation - AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html)
- [Flutter Documentation - FloatingActionButton](https://api.flutter.dev/flutter/material/FloatingActionButton-class.html)
- [Flutter Documentation - BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)
- [Material Design Guidelines](https://material.io/design)
