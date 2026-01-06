# Flutter Training - Branch 05: Basic Layout

## Mục tiêu học tập (Learning Goals)

Branch này giúp bạn hiểu được:
- Hệ thống layout trong Flutter
- Cách sử dụng Row, Column để sắp xếp widget
- Expanded và Flexible để phân chia không gian
- Padding và SizedBox để tạo khoảng cách
- Center và Align để căn chỉnh vị trí
- Stack để xếp chồng widget
- Constraint system (hệ thống ràng buộc) - khái niệm quan trọng nhất

## Khái niệm chính (Key Concepts)

### 1. Constraint System - Hệ thống ràng buộc

**Constraint System là gì:**
- Flutter sử dụng constraint-based layout system
- Widget cha truyền constraints (ràng buộc) cho widget con
- Constraints bao gồm: min/max width và min/max height
- Widget con PHẢI tuân theo constraints của cha

**Constraints bao gồm:**
- `minWidth` và `maxWidth`: Giới hạn chiều rộng
- `minHeight` và `maxHeight`: Giới hạn chiều cao

**Ví dụ:**
```
Parent widget: "Con của tôi có thể rộng từ 0 đến 300px, cao từ 0 đến 200px"
Child widget: "Tôi sẽ chọn kích thước phù hợp trong giới hạn đó"
```

**Tại sao quan trọng:**
- Hiểu constraints giúp tránh lỗi layout
- Giải thích tại sao một số layout không hoạt động như mong đợi
- Giúp sử dụng Expanded/Flexible đúng cách

### 2. Row - Sắp xếp theo chiều ngang

**Row widget là gì:**
- Sắp xếp các widget con theo chiều ngang (từ trái sang phải)
- Main axis: Chiều ngang (horizontal)
- Cross axis: Chiều dọc (vertical)

**Cú pháp cơ bản:**
```dart
Row(
  children: [
    Widget1(),
    Widget2(),
    Widget3(),
  ],
)
```

**Các thuộc tính quan trọng:**
- `mainAxisAlignment`: Căn chỉnh theo main axis (start, center, end, spaceBetween, spaceAround, spaceEvenly)
- `crossAxisAlignment`: Căn chỉnh theo cross axis (start, center, end, stretch)
- `children`: Danh sách widget con

**Ví dụ:**
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều ngang
  crossAxisAlignment: CrossAxisAlignment.start, // Căn trên theo chiều dọc
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

**Lưu ý:**
- Row không thể có kích thước vô hạn
- Nếu children quá rộng, sẽ bị overflow
- Phải dùng Expanded/Flexible hoặc kích thước cố định

### 3. Column - Sắp xếp theo chiều dọc

**Column widget là gì:**
- Sắp xếp các widget con theo chiều dọc (từ trên xuống dưới)
- Main axis: Chiều dọc (vertical)
- Cross axis: Chiều ngang (horizontal)

**Cú pháp cơ bản:**
```dart
Column(
  children: [
    Widget1(),
    Widget2(),
    Widget3(),
  ],
)
```

**Các thuộc tính quan trọng:**
- `mainAxisAlignment`: Căn chỉnh theo main axis (start, center, end, spaceBetween, spaceAround, spaceEvenly)
- `crossAxisAlignment`: Căn chỉnh theo cross axis (start, center, end, stretch)
- `children`: Danh sách widget con

**Ví dụ:**
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
  crossAxisAlignment: CrossAxisAlignment.end, // Căn phải theo chiều ngang
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

**Lưu ý:**
- Column không thể có kích thước vô hạn
- Nếu children quá cao, sẽ bị overflow
- Phải dùng Expanded/Flexible hoặc kích thước cố định

### 4. Expanded - Chiếm không gian còn lại

**Expanded widget là gì:**
- Cho phép widget con chiếm không gian còn lại trong Row/Column
- Bắt buộc widget con phải chiếm hết không gian được phân bổ
- Chỉ dùng được trong Row, Column, hoặc Flex

**Cú pháp cơ bản:**
```dart
Row(
  children: [
    Expanded(
      child: Widget1(), // Chiếm không gian còn lại
    ),
    Widget2(), // Kích thước cố định
  ],
)
```

**Expanded với flex:**
```dart
Row(
  children: [
    Expanded(
      flex: 2, // Chiếm 2 phần
      child: Widget1(),
    ),
    Expanded(
      flex: 1, // Chiếm 1 phần
      child: Widget2(),
    ),
  ],
)
// Widget1 chiếm 2/3 không gian, Widget2 chiếm 1/3
```

**Ví dụ:**
```dart
Row(
  children: [
    Expanded(child: Container(color: Colors.red)),
    Expanded(child: Container(color: Colors.green)),
    Expanded(child: Container(color: Colors.blue)),
  ],
)
// Ba container chia đều không gian
```

**Lưu ý:**
- Expanded chỉ dùng được trong Row/Column
- Expanded bắt buộc widget con phải chiếm hết không gian
- Nếu muốn linh hoạt hơn, dùng Flexible

### 5. Flexible - Linh hoạt hơn Expanded

**Flexible widget là gì:**
- Tương tự Expanded nhưng linh hoạt hơn
- Cho phép widget con chiếm ít hơn không gian được phân bổ nếu cần
- Chỉ dùng được trong Row, Column, hoặc Flex

**Sự khác biệt với Expanded:**
- Expanded: Bắt buộc chiếm hết không gian
- Flexible: Có thể chiếm ít hơn nếu widget con nhỏ

**Cú pháp cơ bản:**
```dart
Row(
  children: [
    Flexible(
      child: Widget1(), // Có thể chiếm ít hơn không gian
    ),
    Widget2(), // Kích thước cố định
  ],
)
```

**Ví dụ:**
```dart
Row(
  children: [
    Flexible(
      child: Text('Short text'), // Chỉ chiếm không gian cần thiết
    ),
    Expanded(
      child: Container(color: Colors.blue), // Chiếm hết không gian còn lại
    ),
  ],
)
```

### 6. Padding - Tạo khoảng cách bên trong

**Padding widget là gì:**
- Tạo khoảng cách bên trong widget (giữa border và nội dung)
- Có thể tùy chỉnh khoảng cách cho từng phía

**Cú pháp cơ bản:**
```dart
Padding(
  padding: EdgeInsets.all(16.0), // Tất cả các phía
  child: Widget(),
)
```

**Các loại EdgeInsets:**
- `EdgeInsets.all(value)`: Tất cả các phía
- `EdgeInsets.symmetric(horizontal: h, vertical: v)`: Ngang và dọc
- `EdgeInsets.only(left: l, top: t, right: r, bottom: b)`: Từng phía
- `EdgeInsets.fromLTRB(left, top, right, bottom)`: Từng phía

**Ví dụ:**
```dart
Padding(
  padding: EdgeInsets.all(16.0),
  child: Text('Padded text'),
)

Padding(
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  child: Text('H:20 V:10'),
)

Padding(
  padding: EdgeInsets.only(left: 30, top: 10),
  child: Text('L:30 T:10'),
)
```

### 7. SizedBox - Khoảng cách hoặc kích thước cố định

**SizedBox widget là gì:**
- Có thể tạo khoảng cách (spacer) giữa các widget
- Hoặc tạo widget với kích thước cố định

**Cú pháp cơ bản:**
```dart
// Làm spacer (khoảng cách)
SizedBox(width: 20, height: 20)

// Widget với kích thước cố định
SizedBox(
  width: 100,
  height: 100,
  child: Widget(),
)
```

**Ví dụ:**
```dart
Row(
  children: [
    Widget1(),
    SizedBox(width: 20), // Khoảng cách 20px
    Widget2(),
  ],
)

SizedBox(
  width: 200,
  height: 100,
  child: Container(color: Colors.blue),
)
```

**Lưu ý:**
- SizedBox(width: 20) tương đương SizedBox(width: 20, height: 0)
- SizedBox(height: 20) tương đương SizedBox(width: 0, height: 20)

### 8. Center - Căn giữa widget

**Center widget là gì:**
- Căn giữa widget con trong không gian của widget cha
- Tương đương Align với alignment: Alignment.center

**Cú pháp cơ bản:**
```dart
Center(
  child: Widget(),
)
```

**Ví dụ:**
```dart
Container(
  width: 200,
  height: 200,
  color: Colors.grey,
  child: Center(
    child: Text('Centered'),
  ),
)
```

### 9. Align - Căn chỉnh vị trí tùy chỉnh

**Align widget là gì:**
- Cho phép căn chỉnh widget con ở vị trí bất kỳ trong widget cha
- Linh hoạt hơn Center

**Cú pháp cơ bản:**
```dart
Align(
  alignment: Alignment.topLeft, // Vị trí căn chỉnh
  child: Widget(),
)
```

**Các vị trí phổ biến:**
- `Alignment.topLeft`, `Alignment.topCenter`, `Alignment.topRight`
- `Alignment.centerLeft`, `Alignment.center`, `Alignment.centerRight`
- `Alignment.bottomLeft`, `Alignment.bottomCenter`, `Alignment.bottomRight`

**Ví dụ:**
```dart
Container(
  width: 200,
  height: 200,
  color: Colors.grey,
  child: Align(
    alignment: Alignment.bottomRight,
    child: Text('Bottom Right'),
  ),
)
```

### 10. Stack - Xếp chồng widget

**Stack widget là gì:**
- Xếp chồng các widget con lên nhau
- Widget sau che widget trước
- Cho phép định vị tuyệt đối với Positioned

**Cú pháp cơ bản:**
```dart
Stack(
  children: [
    Widget1(), // Ở dưới
    Widget2(), // Ở giữa
    Widget3(), // Ở trên
  ],
)
```

**Stack với Positioned:**
```dart
Stack(
  children: [
    Positioned(
      left: 10,
      top: 10,
      child: Widget1(),
    ),
    Positioned(
      right: 10,
      bottom: 10,
      child: Widget2(),
    ),
  ],
)
```

**Ví dụ:**
```dart
Stack(
  children: [
    Container(
      width: 200,
      height: 200,
      color: Colors.red,
    ),
    Positioned(
      top: 20,
      left: 20,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    ),
  ],
)
```

## Cấu trúc code

```
lib/
  └── main.dart
      ├── MyApp (StatelessWidget) - Widget gốc
      └── BasicLayoutDemo (StatelessWidget) - Demo layout
          ├── build() - Hiển thị tất cả các layout widget
          ├── _buildSection() - Helper method tạo section
          └── _buildColoredBox() - Helper method tạo box màu
```

## Cách chạy ứng dụng

1. Đảm bảo bạn đang ở branch `05-basic_layout`
2. Chạy lệnh:
   ```bash
   flutter run -d windows
   ```
3. Thử nghiệm các layout:
   - Xem các ví dụ về Row, Column
   - Quan sát cách Expanded phân chia không gian
   - Xem Padding và SizedBox tạo khoảng cách
   - Thử Center và Align
   - Xem Stack xếp chồng widget

## Lỗi thường gặp (Common Mistakes)

### ❌ Lỗi 1: Row/Column overflow
```dart
// SAI - Children quá rộng/cao, gây overflow
Row(
  children: [
    Container(width: 400, color: Colors.red),
    Container(width: 400, color: Colors.blue),
  ],
)

// ĐÚNG - Dùng Expanded
Row(
  children: [
    Expanded(child: Container(color: Colors.red)),
    Expanded(child: Container(color: Colors.blue)),
  ],
)
```

### ❌ Lỗi 2: Expanded không trong Row/Column
```dart
// SAI - Expanded chỉ dùng trong Row/Column
Container(
  child: Expanded(child: Text('Hello')),
)

// ĐÚNG - Expanded trong Row/Column
Row(
  children: [
    Expanded(child: Text('Hello')),
  ],
)
```

### ❌ Lỗi 3: Quên constraints
```dart
// SAI - Column trong Row không có constraints
Row(
  children: [
    Column(
      children: [Text('Item 1'), Text('Item 2')],
    ),
  ],
)

// ĐÚNG - Dùng Expanded hoặc kích thước cố định
Row(
  children: [
    Expanded(
      child: Column(
        children: [Text('Item 1'), Text('Item 2')],
      ),
    ),
  ],
)
```

### ❌ Lỗi 4: SizedBox không có child
```dart
// SAI - SizedBox không có child và không có width/height
SizedBox()

// ĐÚNG - Có width/height để làm spacer
SizedBox(width: 20, height: 20)
```

### ❌ Lỗi 5: Stack không có kích thước
```dart
// SAI - Stack không có kích thước, children không hiển thị
Stack(
  children: [Container(color: Colors.red)],
)

// ĐÚNG - Stack có kích thước hoặc children có kích thước
Container(
  height: 200,
  child: Stack(
    children: [Container(color: Colors.red)],
  ),
)
```

## Tóm tắt (Summary)

| Widget | Mục đích | Lưu ý |
|--------|----------|-------|
| Row | Sắp xếp ngang | Không thể vô hạn, dùng Expanded |
| Column | Sắp xếp dọc | Không thể vô hạn, dùng Expanded |
| Expanded | Chiếm không gian còn lại | Chỉ trong Row/Column, bắt buộc chiếm hết |
| Flexible | Linh hoạt hơn Expanded | Chỉ trong Row/Column, có thể chiếm ít hơn |
| Padding | Khoảng cách bên trong | EdgeInsets để tùy chỉnh |
| SizedBox | Khoảng cách hoặc kích thước | Có thể làm spacer |
| Center | Căn giữa | Tương đương Align.center |
| Align | Căn chỉnh tùy chỉnh | Linh hoạt hơn Center |
| Stack | Xếp chồng | Dùng Positioned để định vị |

## Câu hỏi tự kiểm tra (Self-check Questions)

1. Constraint system là gì? Tại sao quan trọng?
2. Sự khác biệt giữa Row và Column?
3. Expanded và Flexible khác nhau như thế nào?
4. Khi nào dùng Padding và khi nào dùng SizedBox?
5. Center và Align khác nhau như thế nào?
6. Stack dùng để làm gì? Khi nào dùng Positioned?
7. Tại sao Row/Column có thể bị overflow?

## Tài liệu tham khảo

- [Flutter Documentation - Layout](https://docs.flutter.dev/ui/layout)
- [Flutter Documentation - Row](https://api.flutter.dev/flutter/widgets/Row-class.html)
- [Flutter Documentation - Column](https://api.flutter.dev/flutter/widgets/Column-class.html)
- [Flutter Documentation - Expanded](https://api.flutter.dev/flutter/widgets/Expanded-class.html)
- [Flutter Documentation - Flexible](https://api.flutter.dev/flutter/widgets/Flexible-class.html)
- [Flutter Documentation - Stack](https://api.flutter.dev/flutter/widgets/Stack-class.html)
- [Understanding Constraints](https://docs.flutter.dev/ui/layout/constraints)
