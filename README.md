# Flutter Training - Branch 01: Stateless vs Stateful Widget

## Mục tiêu học tập (Learning Goals)

Branch này giúp bạn hiểu được sự khác biệt cơ bản nhất trong Flutter:
- **StatelessWidget**: Widget không có trạng thái, không thể tự cập nhật UI
- **StatefulWidget**: Widget có trạng thái, có thể cập nhật UI thông qua `setState()`

## Khái niệm chính (Key Concepts)

### 1. StatelessWidget

**Định nghĩa:**
- Widget **bất biến** (immutable)
- Không có trạng thái có thể thay đổi
- `build()` method chỉ được gọi khi widget được tạo lần đầu

**Đặc điểm:**
- Không có `State` object
- Không có phương thức `setState()`
- Dữ liệu chỉ có thể thay đổi thông qua constructor (từ parent widget)

**Khi nào dùng:**
- Widget chỉ hiển thị dữ liệu tĩnh
- Widget nhận dữ liệu từ parent và hiển thị
- Ví dụ: Text, Icon, Image (khi không cần thay đổi)

### 2. StatefulWidget

**Định nghĩa:**
- Widget có thể thay đổi trạng thái
- Tách biệt thành 2 phần:
  - `StatefulWidget`: Phần cấu hình (immutable)
  - `State`: Phần trạng thái (mutable)

**Đặc điểm:**
- Có `State` object để lưu trữ dữ liệu
- Có phương thức `setState()` để thông báo thay đổi
- `build()` được gọi lại mỗi khi `setState()` được gọi

**Khi nào dùng:**
- Widget cần thay đổi UI dựa trên tương tác người dùng
- Widget cần lưu trữ dữ liệu có thể thay đổi
- Ví dụ: Form input, counter, toggle button

### 3. setState() - Phương thức quan trọng

**Chức năng:**
- Thông báo cho Flutter framework biết có thay đổi trong state
- Trigger việc rebuild widget tree
- Gọi lại `build()` method với dữ liệu mới

**Cách hoạt động:**
```dart
setState(() {
  // Thay đổi dữ liệu ở đây
  counter++;
});
// Sau khi setState() hoàn thành, build() được gọi lại
```

**Lưu ý quan trọng:**
- CHỈ gọi `setState()` khi thực sự cần thay đổi UI
- KHÔNG gọi `setState()` trong `build()` method (sẽ gây vòng lặp vô hạn)
- Mọi thay đổi state phải nằm trong callback của `setState()`

### 4. build() Method

**Chức năng:**
- Tạo ra widget tree (cây widget)
- Được gọi tự động bởi Flutter framework

**Khi nào được gọi:**
- Lần đầu khi widget được tạo
- Khi `setState()` được gọi (chỉ với StatefulWidget)
- Khi parent widget rebuild và truyền props mới

**Lưu ý:**
- `build()` có thể được gọi NHIỀU LẦN
- Không nên thực hiện logic nặng trong `build()`
- Không nên gọi `setState()` trong `build()`

## Cấu trúc code

```
lib/
  └── main.dart
      ├── MyApp (StatelessWidget) - Widget gốc
      ├── CounterComparisonScreen (StatelessWidget) - Màn hình chính
      ├── StatelessCounter (StatelessWidget) - Bộ đếm không hoạt động
      └── StatefulCounter (StatefulWidget) - Bộ đếm hoạt động
          └── _StatefulCounterState (State) - Quản lý trạng thái
```

## Cách chạy ứng dụng

1. Đảm bảo bạn đang ở branch `01-stateless_vs_stateful`
2. Chạy lệnh:
   ```bash
   flutter run -d windows
   ```
3. Quan sát sự khác biệt:
   - Nhấn nút "Tăng Counter" ở StatelessWidget → Giá trị KHÔNG thay đổi
   - Nhấn nút "Tăng Counter" ở StatefulWidget → Giá trị TĂNG LÊN

## Thử nghiệm (Experiments)

Để hiểu rõ hơn, hãy thử:

1. **Thử nghiệm 1: Xem console log**
   - Mở console/terminal khi chạy app
   - Nhấn nút ở StatelessWidget → Xem log "Counter tăng lên: X"
   - Nhấn nút ở StatefulWidget → Xem log "build() được gọi"
   - Nhận xét: StatelessWidget không rebuild, StatefulWidget có rebuild

2. **Thử nghiệm 2: Thêm biến trong StatelessWidget**
   - Thử thêm biến `int counter = 0;` ngoài `build()` method
   - Tăng counter trong `onPressed`
   - Kết quả: Vẫn không hoạt động vì không có `setState()`

3. **Thử nghiệm 3: Gọi setState() trong StatelessWidget**
   - Thử gọi `setState()` trong StatelessWidget
   - Kết quả: Lỗi compile vì StatelessWidget không có `setState()`

## Lỗi thường gặp (Common Mistakes)

### ❌ Lỗi 1: Quên gọi setState()
```dart
// SAI - UI không cập nhật
void _incrementCounter() {
  counter++; // Thiếu setState()
}

// ĐÚNG - UI được cập nhật
void _incrementCounter() {
  setState(() {
    counter++;
  });
}
```

### ❌ Lỗi 2: Gọi setState() trong build()
```dart
// SAI - Gây vòng lặp vô hạn
@override
Widget build(BuildContext context) {
  setState(() {
    counter++;
  });
  return Text('$counter');
}
```

### ❌ Lỗi 3: Khai báo biến trong build()
```dart
// SAI - Biến bị reset mỗi lần build()
@override
Widget build(BuildContext context) {
  int counter = 0; // Bị reset về 0 mỗi lần build()
  return Text('$counter');
}

// ĐÚNG - Biến nằm trong State class
class _MyState extends State<MyWidget> {
  int counter = 0; // Giữ nguyên giá trị giữa các lần build()
  // ...
}
```

### ❌ Lỗi 4: Dùng StatelessWidget khi cần thay đổi UI
```dart
// SAI - StatelessWidget không thể cập nhật
class Counter extends StatelessWidget {
  int counter = 0; // Không thể thay đổi
  // ...
}

// ĐÚNG - Dùng StatefulWidget
class Counter extends StatefulWidget {
  // ...
}
class _CounterState extends State<Counter> {
  int counter = 0; // Có thể thay đổi với setState()
  // ...
}
```

## Tóm tắt (Summary)

| Đặc điểm | StatelessWidget | StatefulWidget |
|----------|----------------|----------------|
| Trạng thái | Không có | Có (trong State class) |
| setState() | Không có | Có |
| build() được gọi lại | Chỉ khi parent rebuild | Khi setState() được gọi |
| Cập nhật UI | Không thể tự cập nhật | Có thể tự cập nhật |
| Khi nào dùng | Hiển thị dữ liệu tĩnh | Cần tương tác người dùng |

## Câu hỏi tự kiểm tra (Self-check Questions)

1. Tại sao StatelessWidget không thể cập nhật UI?
2. `setState()` làm gì?
3. Khi nào `build()` method được gọi?
4. Sự khác biệt giữa biến trong `build()` và biến trong `State` class?
5. Khi nào nên dùng StatelessWidget và khi nào dùng StatefulWidget?

## Tài liệu tham khảo

- [Flutter Documentation - StatelessWidget](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html)
- [Flutter Documentation - StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [Flutter Documentation - State](https://api.flutter.dev/flutter/widgets/State-class.html)
