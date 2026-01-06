# Flutter Training - Branch 04: Basic Widgets

## Mục tiêu học tập (Learning Goals)

Branch này giúp bạn hiểu được:
- Các widget cơ bản trong Flutter và cách sử dụng chúng
- Khái niệm "Everything is a Widget" (Mọi thứ đều là widget)
- Widget composition (Widget lồng nhau)
- Cách các widget tương tác với nhau để tạo UI

## Khái niệm chính (Key Concepts)

### 1. "Everything is a Widget" - Mọi thứ đều là Widget

**Khái niệm quan trọng nhất trong Flutter:**
- Trong Flutter, MỌI THỨ đều là widget
- Text là widget, Icon là widget, Button là widget
- Ngay cả layout (Row, Column, Container) cũng là widget
- Scaffold, AppBar, Body - tất cả đều là widget

**Ví dụ:**
```dart
// Text là widget
Text('Hello')

// Icon là widget
Icon(Icons.home)

// Button là widget (chứa Text widget bên trong)
ElevatedButton(
  child: Text('Click me'), // Text là widget con
)

// Container là widget (chứa nhiều widget con)
Container(
  child: Column( // Column cũng là widget
    children: [
      Text('Item 1'), // Widget con
      Text('Item 2'), // Widget con
    ],
  ),
)
```

**Tại sao quan trọng:**
- Giúp hiểu cách Flutter xây dựng UI
- Widget có thể chứa widget khác (composition)
- Tạo ra widget tree (cây widget) để render UI

### 2. Widget Composition - Widget lồng nhau

**Widget Composition là gì:**
- Widget có thể chứa widget khác
- Tạo ra cấu trúc phân cấp (hierarchical structure)
- Widget cha chứa widget con, widget con có thể chứa widget cháu

**Ví dụ:**
```dart
Scaffold(                    // Widget cha
  appBar: AppBar(            // Widget con
    title: Text('Title'),    // Widget cháu
  ),
  body: Column(              // Widget con
    children: [
      Text('Item 1'),        // Widget cháu
      ElevatedButton(         // Widget cháu
        child: Text('Click'), // Widget chắt
      ),
    ],
  ),
)
```

### 3. Text Widget - Hiển thị văn bản

**Text widget là gì:**
- Widget cơ bản nhất để hiển thị văn bản
- Có thể tùy chỉnh style (màu sắc, font, kích thước, etc.)

**Cú pháp cơ bản:**
```dart
Text('Văn bản cơ bản')

Text(
  'Văn bản với style',
  style: TextStyle(
    color: Colors.red,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
)
```

**Các thuộc tính quan trọng:**
- `style`: TextStyle để tùy chỉnh giao diện
- `textAlign`: Căn chỉnh văn bản (left, center, right)
- `maxLines`: Số dòng tối đa
- `overflow`: Xử lý khi văn bản quá dài

**Ví dụ:**
```dart
Text('Hello World')
Text('Red text', style: TextStyle(color: Colors.red))
Text('Bold text', style: TextStyle(fontWeight: FontWeight.bold))
```

### 4. Icon Widget - Hiển thị biểu tượng

**Icon widget là gì:**
- Widget hiển thị biểu tượng (icon)
- Sử dụng Material Icons hoặc custom icons

**Cú pháp cơ bản:**
```dart
Icon(Icons.home)

Icon(
  Icons.favorite,
  color: Colors.red,
  size: 40,
)
```

**Các thuộc tính quan trọng:**
- `icon`: IconData (ví dụ: Icons.home, Icons.favorite)
- `color`: Màu sắc của icon
- `size`: Kích thước của icon

**Ví dụ:**
```dart
Icon(Icons.home)
Icon(Icons.favorite, color: Colors.red)
Icon(Icons.star, size: 50)
```

### 5. Image Widget - Hiển thị hình ảnh

**Image widget là gì:**
- Widget hiển thị hình ảnh từ nhiều nguồn khác nhau
- Có thể load từ assets, network, hoặc memory

**Các loại Image:**
- `Image.asset()`: Hình ảnh từ assets trong project
- `Image.network()`: Hình ảnh từ URL
- `Image.file()`: Hình ảnh từ file system
- `Image.memory()`: Hình ảnh từ memory

**Cách dùng AssetImage:**
```dart
// 1. Tạo thư mục assets/images/
// 2. Thêm hình ảnh vào thư mục đó
// 3. Khai báo trong pubspec.yaml:
//    flutter:
//      assets:
//        - assets/images/your_image.png
// 4. Sử dụng:
Image.asset('assets/images/your_image.png')
```

**Ví dụ:**
```dart
Image.asset('assets/images/logo.png')
Image.network('https://example.com/image.jpg')
```

### 6. ElevatedButton Widget - Nút bấm

**ElevatedButton widget là gì:**
- Widget tạo nút bấm với hiệu ứng nổi (elevated)
- Có thể xử lý sự kiện khi người dùng nhấn

**Cú pháp cơ bản:**
```dart
ElevatedButton(
  onPressed: () {
    // Xử lý khi nút được nhấn
    print('Button pressed!');
  },
  child: Text('Click me'),
)
```

**Các thuộc tính quan trọng:**
- `onPressed`: Callback được gọi khi nút được nhấn (null = vô hiệu hóa)
- `child`: Widget con (thường là Text hoặc Icon)
- `style`: ButtonStyle để tùy chỉnh giao diện

**ElevatedButton với Icon:**
```dart
ElevatedButton.icon(
  onPressed: () {},
  icon: Icon(Icons.add),
  label: Text('Add'),
)
```

**Ví dụ:**
```dart
ElevatedButton(
  onPressed: () => print('Clicked'),
  child: Text('Click me'),
)

ElevatedButton(
  onPressed: null, // Button bị vô hiệu hóa
  child: Text('Disabled'),
)
```

### 7. GestureDetector Widget - Phát hiện cử chỉ

**GestureDetector widget là gì:**
- Widget phát hiện các cử chỉ của người dùng
- Có thể wrap bất kỳ widget nào để thêm tương tác

**Các cử chỉ phổ biến:**
- `onTap`: Tap một lần
- `onLongPress`: Giữ lâu
- `onDoubleTap`: Tap hai lần nhanh
- `onPanUpdate`: Kéo
- `onScaleUpdate`: Pinch/zoom

**Cú pháp cơ bản:**
```dart
GestureDetector(
  onTap: () {
    print('Tapped!');
  },
  child: Container(
    child: Text('Tap me'),
  ),
)
```

**Ví dụ:**
```dart
GestureDetector(
  onTap: () => print('Single tap'),
  onLongPress: () => print('Long press'),
  onDoubleTap: () => print('Double tap'),
  child: Container(
    padding: EdgeInsets.all(20),
    child: Text('Interact with me'),
  ),
)
```

### 8. TextField Widget - Ô nhập văn bản

**TextField widget là gì:**
- Widget cho phép người dùng nhập văn bản
- Có thể xử lý sự kiện khi text thay đổi

**Cú pháp cơ bản:**
```dart
TextField(
  onChanged: (value) {
    print('Text changed: $value');
  },
  decoration: InputDecoration(
    labelText: 'Label',
    hintText: 'Hint text',
    border: OutlineInputBorder(),
  ),
)
```

**Các thuộc tính quan trọng:**
- `onChanged`: Callback được gọi khi text thay đổi
- `decoration`: InputDecoration để tùy chỉnh giao diện
- `controller`: TextEditingController để quản lý text
- `obscureText`: Ẩn text (dùng cho password)
- `maxLines`: Số dòng tối đa

**Ví dụ:**
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Username',
    border: OutlineInputBorder(),
  ),
)

TextField(
  obscureText: true, // Ẩn text
  decoration: InputDecoration(
    labelText: 'Password',
    border: OutlineInputBorder(),
  ),
)

TextField(
  maxLines: 3, // Nhiều dòng
  decoration: InputDecoration(
    labelText: 'Description',
    border: OutlineInputBorder(),
  ),
)
```

## Cấu trúc code

```
lib/
  └── main.dart
      ├── MyApp (StatelessWidget) - Widget gốc
      └── BasicWidgetsDemo (StatefulWidget) - Demo các widget cơ bản
          └── _BasicWidgetsDemoState
              ├── build() - Hiển thị tất cả các widget
              └── _buildSection() - Helper method tạo section
```

## Cách chạy ứng dụng

1. Đảm bảo bạn đang ở branch `04-basic_widgets`
2. Chạy lệnh:
   ```bash
   flutter run -d windows
   ```
3. Thử nghiệm các widget:
   - Xem các ví dụ về Text, Icon, Image
   - Nhấn vào ElevatedButton và quan sát
   - Tap, long press, double tap vào GestureDetector
   - Nhập text vào TextField và xem giá trị thay đổi

## Widget Tree (Cây Widget)

**Ví dụ về Widget Tree:**
```
MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text
    └── Body (SingleChildScrollView)
        └── Column
            ├── Card (Text Widget Section)
            │   └── Column
            │       └── Text (nhiều Text widgets)
            ├── Card (Icon Widget Section)
            │   └── Wrap
            │       └── Icon (nhiều Icon widgets)
            ├── Card (Button Widget Section)
            │   └── Column
            │       └── ElevatedButton
            │           └── Text
            └── ... (các widget khác)
```

## Thử nghiệm (Experiments)

Để hiểu rõ hơn, hãy thử:

1. **Thử nghiệm 1: Widget Composition**
   - Tạo một Container chứa Column
   - Column chứa nhiều Text widgets
   - Quan sát cách widget lồng nhau

2. **Thử nghiệm 2: TextField với Controller**
   - Tạo TextEditingController
   - Gán controller cho TextField
   - Đọc giá trị từ controller

3. **Thử nghiệm 3: GestureDetector với nhiều cử chỉ**
   - Thêm onTap, onLongPress, onDoubleTap vào cùng một GestureDetector
   - Quan sát cử chỉ nào được gọi

4. **Thử nghiệm 4: Custom Widget**
   - Tạo một widget tùy chỉnh chứa nhiều widget con
   - Sử dụng widget đó nhiều lần

## Lỗi thường gặp (Common Mistakes)

### ❌ Lỗi 1: Quên child trong ElevatedButton
```dart
// SAI - Thiếu child
ElevatedButton(
  onPressed: () {},
)

// ĐÚNG - Có child
ElevatedButton(
  onPressed: () {},
  child: Text('Click me'),
)
```

### ❌ Lỗi 2: Quên onPressed trong ElevatedButton
```dart
// SAI - Thiếu onPressed (button sẽ bị vô hiệu hóa)
ElevatedButton(
  child: Text('Click me'),
)

// ĐÚNG - Có onPressed
ElevatedButton(
  onPressed: () {},
  child: Text('Click me'),
)
```

### ❌ Lỗi 3: Quên dispose TextEditingController
```dart
// SAI - Memory leak
class _MyState extends State<MyWidget> {
  final _controller = TextEditingController();
  
  // Thiếu dispose()
}

// ĐÚNG - Dispose controller
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### ❌ Lỗi 4: Dùng TextField không có decoration
```dart
// SAI - TextField không có border, khó nhìn
TextField(
  onChanged: (value) {},
)

// ĐÚNG - Có decoration
TextField(
  onChanged: (value) {},
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Input',
  ),
)
```

### ❌ Lỗi 5: Quên setState() khi cập nhật state từ TextField
```dart
// SAI - UI không cập nhật
String _value = '';

TextField(
  onChanged: (value) {
    _value = value; // Thiếu setState()
  },
)

// ĐÚNG - Có setState()
TextField(
  onChanged: (value) {
    setState(() {
      _value = value;
    });
  },
)
```

## Tóm tắt (Summary)

| Widget | Mục đích | Thuộc tính quan trọng |
|--------|----------|----------------------|
| Text | Hiển thị văn bản | style, textAlign |
| Icon | Hiển thị biểu tượng | icon, color, size |
| Image | Hiển thị hình ảnh | src, fit, width, height |
| ElevatedButton | Nút bấm | onPressed, child |
| GestureDetector | Phát hiện cử chỉ | onTap, onLongPress, child |
| TextField | Ô nhập văn bản | onChanged, decoration, controller |

## Câu hỏi tự kiểm tra (Self-check Questions)

1. "Everything is a Widget" nghĩa là gì?
2. Widget Composition là gì? Cho ví dụ.
3. Làm sao tùy chỉnh style của Text?
4. Làm sao tạo button với icon?
5. GestureDetector có thể phát hiện những cử chỉ nào?
6. Làm sao xử lý khi người dùng nhập text vào TextField?
7. Tại sao cần dispose TextEditingController?

## Tài liệu tham khảo

- [Flutter Documentation - Widgets](https://docs.flutter.dev/ui/widgets)
- [Flutter Documentation - Text](https://api.flutter.dev/flutter/widgets/Text-class.html)
- [Flutter Documentation - Icon](https://api.flutter.dev/flutter/widgets/Icon-class.html)
- [Flutter Documentation - Image](https://api.flutter.dev/flutter/widgets/Image-class.html)
- [Flutter Documentation - ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)
- [Flutter Documentation - GestureDetector](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html)
- [Flutter Documentation - TextField](https://api.flutter.dev/flutter/material/TextField-class.html)
