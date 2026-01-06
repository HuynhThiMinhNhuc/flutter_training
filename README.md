# Flutter Training - Branch 02: State Lifecycle

## Mục tiêu học tập (Learning Goals)

Branch này giúp bạn hiểu được vòng đời (lifecycle) của StatefulWidget:
- Các lifecycle methods và thứ tự gọi của chúng
- Khi nào mỗi method được gọi
- Mục đích và cách sử dụng từng method
- Tại sao `dispose()` quan trọng để tránh memory leaks

## Khái niệm chính (Key Concepts)

### 1. Vòng đời của StatefulWidget

StatefulWidget có một vòng đời rõ ràng với các giai đoạn:

```
createState() 
    ↓
initState() 
    ↓
didChangeDependencies() 
    ↓
build() [có thể gọi nhiều lần]
    ↓
didUpdateWidget() [khi widget được cập nhật]
    ↓
dispose() [khi widget bị hủy]
```

### 2. initState() - Khởi tạo

**Khi nào được gọi:**
- CHỈ MỘT LẦN khi State object được tạo
- TRƯỚC build() method lần đầu tiên
- Ngay sau khi createState() tạo State object

**Mục đích:**
- Khởi tạo dữ liệu ban đầu
- Đăng ký listeners (Stream, AnimationController, etc.)
- Gọi API một lần
- Thiết lập các giá trị mặc định

**Lưu ý:**
- ❌ KHÔNG gọi `setState()` ở đây (sẽ gây lỗi)
- ❌ KHÔNG truy cập InheritedWidget ở đây
- ✅ Luôn gọi `super.initState()` đầu tiên

**Ví dụ:**
```dart
@override
void initState() {
  super.initState();
  _counter = 0;
  _controller = AnimationController(vsync: this);
  _loadData();
}
```

### 3. didChangeDependencies() - Dependencies thay đổi

**Khi nào được gọi:**
- SAU initState() (lần đầu)
- Khi InheritedWidget mà widget này phụ thuộc vào thay đổi
- Ví dụ: Theme, MediaQuery, Localizations thay đổi

**Mục đích:**
- Lấy dữ liệu từ InheritedWidget (Theme, MediaQuery, etc.)
- Khởi tạo dữ liệu phụ thuộc vào context
- Cập nhật state khi dependencies thay đổi

**Lưu ý:**
- ✅ Có thể gọi `setState()` ở đây (nhưng cẩn thận)
- ✅ Được gọi trước build() lần đầu tiên
- ✅ Có thể được gọi nhiều lần

**Ví dụ:**
```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final theme = Theme.of(context);
  final mediaQuery = MediaQuery.of(context);
  // Sử dụng theme và mediaQuery
}
```

### 4. build() - Xây dựng UI

**Khi nào được gọi:**
- Sau initState() và didChangeDependencies() (lần đầu)
- Mỗi khi `setState()` được gọi
- Khi parent widget rebuild và truyền props mới
- Khi InheritedWidget thay đổi (nếu widget phụ thuộc)

**Mục đích:**
- Xây dựng widget tree (UI)
- Trả về widget để hiển thị

**Lưu ý:**
- ❌ KHÔNG gọi `setState()` ở đây (gây vòng lặp vô hạn)
- ❌ KHÔNG thực hiện logic nặng ở đây
- ✅ build() phải là pure function (không có side effects)
- ✅ build() có thể được gọi 60 lần/giây (60 FPS)

**Ví dụ:**
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Text('Counter: $_counter'),
  );
}
```

### 5. didUpdateWidget() - Widget được cập nhật

**Khi nào được gọi:**
- Khi parent widget rebuild và truyền widget mới (cùng type)
- Widget cũ và widget mới có cùng runtimeType
- Widget mới có props khác với widget cũ

**Mục đích:**
- So sánh props cũ và mới
- Cập nhật state dựa trên props mới
- Hủy đăng ký listeners cũ và đăng ký listeners mới

**Lưu ý:**
- ✅ Được gọi TRƯỚC build() khi widget được cập nhật
- ✅ Có thể gọi `setState()` ở đây
- ✅ oldWidget chứa props cũ để so sánh

**Ví dụ:**
```dart
@override
void didUpdateWidget(MyWidget oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.title != widget.title) {
    // Cập nhật state khi title thay đổi
    _updateTitle();
  }
}
```

### 6. dispose() - Dọn dẹp

**Khi nào được gọi:**
- CHỈ MỘT LẦN khi State object bị HỦY
- Khi widget bị xóa vĩnh viễn khỏi widget tree
- Khi Navigator.pop() được gọi
- Khi parent widget rebuild và không còn widget này

**Mục đích:**
- Hủy đăng ký listeners (Stream, AnimationController, etc.)
- Đóng connections (database, network, etc.)
- Giải phóng tài nguyên (timers, file handles, etc.)
- Dọn dẹp để tránh memory leaks

**Lưu ý:**
- ❌ KHÔNG gọi `setState()` ở đây (widget đã bị hủy)
- ❌ KHÔNG truy cập BuildContext sau dispose()
- ✅ QUAN TRỌNG: Luôn hủy đăng ký listeners để tránh memory leaks
- ✅ Luôn gọi `super.dispose()` CUỐI CÙNG

**Ví dụ:**
```dart
@override
void dispose() {
  // Hủy đăng ký listeners
  _streamSubscription?.cancel();
  _animationController?.dispose();
  _timer?.cancel();
  
  super.dispose(); // QUAN TRỌNG: Gọi cuối cùng
}
```

## Cấu trúc code

```
lib/
  └── main.dart
      ├── MyApp (StatelessWidget) - Widget gốc
      ├── HomeScreen (StatelessWidget) - Màn hình chính
      └── LifecycleDemoScreen (StatefulWidget) - Demo lifecycle
          └── _LifecycleDemoScreenState (State) - Quản lý lifecycle
              ├── initState()
              ├── didChangeDependencies()
              ├── build()
              ├── didUpdateWidget()
              └── dispose()
```

## Cách chạy ứng dụng

1. Đảm bảo bạn đang ở branch `02-state_lifecycle`
2. Chạy lệnh:
   ```bash
   flutter run -d windows
   ```
3. Mở console/terminal để xem logs
4. Thực hiện các bước sau:
   - Nhấn "Xem Lifecycle Demo" → Quan sát logs: initState(), didChangeDependencies(), build()
   - Nhấn "Tăng Counter" → Quan sát: build() được gọi lại
   - Nhấn "Quay lại" → Quan sát: dispose() được gọi

## Thứ tự gọi lifecycle methods

### Khi widget được tạo lần đầu:
```
1. createState() (tự động)
2. initState()
3. didChangeDependencies()
4. build()
```

### Khi setState() được gọi:
```
1. setState()
2. build() (được gọi lại)
```

### Khi widget được cập nhật (props thay đổi):
```
1. didUpdateWidget()
2. build() (được gọi lại)
```

### Khi widget bị hủy:
```
1. dispose()
```

## Thử nghiệm (Experiments)

Để hiểu rõ hơn, hãy thử:

1. **Thử nghiệm 1: Quan sát thứ tự gọi**
   - Mở console khi chạy app
   - Nhấn "Xem Lifecycle Demo"
   - Quan sát thứ tự: initState() → didChangeDependencies() → build()

2. **Thử nghiệm 2: setState() trigger build()**
   - Trong LifecycleDemoScreen, nhấn "Tăng Counter"
   - Quan sát: build() được gọi lại mỗi lần nhấn
   - Nhận xét: setState() luôn trigger build()

3. **Thử nghiệm 3: dispose() khi quay lại**
   - Nhấn "Quay lại" từ LifecycleDemoScreen
   - Quan sát: dispose() được gọi
   - Nhận xét: Widget bị hủy khi pop khỏi navigation stack

4. **Thử nghiệm 4: Widget được tạo lại**
   - Quay lại HomeScreen
   - Nhấn "Xem Lifecycle Demo" lại
   - Quan sát: initState() được gọi lại (widget mới được tạo)

## Lỗi thường gặp (Common Mistakes)

### ❌ Lỗi 1: Quên gọi super.initState()
```dart
// SAI - Thiếu super.initState()
@override
void initState() {
  _counter = 0; // Lỗi!
}

// ĐÚNG - Luôn gọi super.initState() đầu tiên
@override
void initState() {
  super.initState();
  _counter = 0;
}
```

### ❌ Lỗi 2: Gọi setState() trong initState()
```dart
// SAI - Gây lỗi vì build() chưa được gọi
@override
void initState() {
  super.initState();
  setState(() {
    _counter = 0; // Lỗi!
  });
}

// ĐÚNG - Gán trực tiếp, không cần setState()
@override
void initState() {
  super.initState();
  _counter = 0; // OK
}
```

### ❌ Lỗi 3: Quên dispose() listeners
```dart
// SAI - Memory leak!
class _MyState extends State<MyWidget> {
  StreamSubscription? _subscription;
  
  @override
  void initState() {
    super.initState();
    _subscription = stream.listen((data) {});
  }
  
  // Thiếu dispose() → Memory leak!
}

// ĐÚNG - Luôn dispose() listeners
@override
void dispose() {
  _subscription?.cancel(); // Hủy đăng ký
  super.dispose();
}
```

### ❌ Lỗi 4: Gọi setState() trong dispose()
```dart
// SAI - Widget đã bị hủy
@override
void dispose() {
  setState(() {
    _counter = 0; // Lỗi! Widget đã bị hủy
  });
  super.dispose();
}

// ĐÚNG - Không gọi setState() trong dispose()
@override
void dispose() {
  _subscription?.cancel();
  super.dispose();
}
```

### ❌ Lỗi 5: Thực hiện logic nặng trong build()
```dart
// SAI - build() được gọi nhiều lần
@override
Widget build(BuildContext context) {
  // Logic nặng → Chậm app
  final data = expensiveCalculation(); // SAI!
  return Text('$data');
}

// ĐÚNG - Tính toán trước, cache kết quả
int? _cachedData;

@override
void initState() {
  super.initState();
  _cachedData = expensiveCalculation(); // Tính 1 lần
}

@override
Widget build(BuildContext context) {
  return Text('$_cachedData'); // Dùng kết quả đã cache
}
```

## Tại sao dispose() quan trọng?

### Memory Leaks (Rò rỉ bộ nhớ)

Nếu không dispose() đúng cách, bạn có thể gây ra memory leaks:

1. **StreamSubscription không được cancel**
   - Stream vẫn chạy ngầm
   - Widget đã bị hủy nhưng listener vẫn hoạt động
   - → Memory leak

2. **AnimationController không được dispose**
   - Animation vẫn chạy
   - Tài nguyên không được giải phóng
   - → Memory leak

3. **Timer không được cancel**
   - Timer vẫn chạy
   - Callback vẫn được gọi
   - → Memory leak

### Best Practices

```dart
class _MyState extends State<MyWidget> {
  StreamSubscription? _subscription;
  AnimationController? _controller;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    // Đăng ký listeners
    _subscription = stream.listen((data) {});
    _controller = AnimationController(vsync: this);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  }
  
  @override
  void dispose() {
    // QUAN TRỌNG: Hủy đăng ký TẤT CẢ listeners
    _subscription?.cancel();
    _controller?.dispose();
    _timer?.cancel();
    
    super.dispose(); // Gọi cuối cùng
  }
}
```

## Tóm tắt (Summary)

| Lifecycle Method | Số lần gọi | Khi nào gọi | Có thể setState()? |
|-----------------|-----------|-------------|-------------------|
| initState() | 1 lần | Khi widget được tạo | ❌ Không |
| didChangeDependencies() | Nhiều lần | Khi dependencies thay đổi | ✅ Có (cẩn thận) |
| build() | Nhiều lần | Khi cần rebuild UI | ❌ Không |
| didUpdateWidget() | Nhiều lần | Khi widget được cập nhật | ✅ Có |
| dispose() | 1 lần | Khi widget bị hủy | ❌ Không |

## Câu hỏi tự kiểm tra (Self-check Questions)

1. Thứ tự gọi các lifecycle methods khi widget được tạo?
2. Tại sao không nên gọi setState() trong initState()?
3. Khi nào didChangeDependencies() được gọi?
4. Tại sao dispose() quan trọng?
5. build() được gọi khi nào?
6. Sự khác biệt giữa didUpdateWidget() và build()?
7. Tại sao không nên thực hiện logic nặng trong build()?

## Tài liệu tham khảo

- [Flutter Documentation - State](https://api.flutter.dev/flutter/widgets/State-class.html)
- [Flutter Documentation - initState](https://api.flutter.dev/flutter/widgets/State/initState.html)
- [Flutter Documentation - dispose](https://api.flutter.dev/flutter/widgets/State/dispose.html)
- [Flutter Lifecycle Explained](https://flutter.dev/docs/development/ui/interactive#stateful-widget-lifecycle)
