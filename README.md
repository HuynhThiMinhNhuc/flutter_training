# Flutter Training - Branch 03: Navigation

## Mục tiêu học tập (Learning Goals)

Branch này giúp bạn hiểu được:
- Cách điều hướng giữa các màn hình trong Flutter
- Navigator stack (ngăn xếp điều hướng) hoạt động như thế nào
- Cách truyền dữ liệu từ màn hình này sang màn hình khác
- Cách nhận dữ liệu trả về từ màn hình khác
- BuildContext là gì và tại sao nó quan trọng

## Khái niệm chính (Key Concepts)

### 1. Navigator - Quản lý điều hướng

**Navigator là gì:**
- Navigator là một widget quản lý một stack (ngăn xếp) các route
- Route là một màn hình (screen) trong ứng dụng
- Navigator.push() thêm route mới vào stack
- Navigator.pop() xóa route khỏi stack

**Navigator Stack:**
```
[HomePage]                    ← Stack ban đầu
[HomePage, DetailPage]        ← Sau khi push DetailPage
[HomePage]                    ← Sau khi pop DetailPage
```

**Tại sao dùng Stack:**
- Stack cho phép quay lại màn hình trước đó một cách tự nhiên
- Route ở đỉnh stack là màn hình hiện tại đang hiển thị
- Khi pop, route ở đỉnh bị xóa, route trước đó hiển thị lại

### 2. Navigator.push() - Điều hướng đến màn hình mới

**Cú pháp:**
```dart
final result = await Navigator.push<T>(
  context,
  MaterialPageRoute(
    builder: (context) => NewScreen(),
  ),
);
```

**Navigator.push() làm gì:**
1. Tạo route mới (NewScreen)
2. Đẩy route mới vào đỉnh của Navigator stack
3. Hiển thị NewScreen (màn hình mới che phủ màn hình cũ)
4. Trả về `Future<T?>` - sẽ complete khi NewScreen được pop

**await:**
- `await` đợi cho đến khi Future complete
- Khi NewScreen gọi `Navigator.pop(result)`, Future này sẽ complete với giá trị `result`
- Nếu NewScreen pop mà không có result, Future sẽ complete với `null`

**Ví dụ:**
```dart
// Điều hướng đến DetailPage
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(item: 'Hello'),
  ),
);

// Sau khi DetailPage trả về
if (result != null) {
  print('Nhận được: $result');
}
```

### 3. Navigator.pop() - Quay lại màn hình trước

**Cú pháp:**
```dart
Navigator.pop(context);              // Không trả về dữ liệu
Navigator.pop(context, result);      // Trả về dữ liệu
```

**Navigator.pop() làm gì:**
1. Xóa route hiện tại khỏi Navigator stack
2. Hiển thị lại route trước đó
3. Trả về giá trị `result` cho Future trong Navigator.push()

**Ví dụ:**
```dart
// Trong DetailPage
void _saveAndGoBack() {
  final editedData = _textController.text;
  Navigator.pop(context, editedData); // Trả về dữ liệu đã chỉnh sửa
}

void _goBackWithoutSaving() {
  Navigator.pop(context); // Không trả về dữ liệu (null)
}
```

### 4. Truyền dữ liệu giữa các màn hình

**Cách 1: Truyền qua Constructor (Điều hướng đến màn hình mới)**

```dart
// Trong HomePage
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(
      item: 'Dữ liệu cần truyền', // Truyền qua constructor
    ),
  ),
);

// Trong DetailPage
class DetailPage extends StatelessWidget {
  final String item; // Nhận dữ liệu qua constructor
  
  const DetailPage({super.key, required this.item});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(item), // Sử dụng dữ liệu
    );
  }
}
```

**Cách 2: Trả về dữ liệu (Quay lại màn hình trước)**

```dart
// Trong HomePage
final result = await Navigator.push<String>(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(),
  ),
);
// result chứa dữ liệu trả về từ DetailPage

// Trong DetailPage
Navigator.pop(context, 'Dữ liệu trả về');
```

### 5. BuildContext - Ngữ cảnh của Widget

**BuildContext là gì:**
- BuildContext chứa thông tin về vị trí widget trong widget tree
- BuildContext cần thiết để truy cập các dịch vụ như Navigator, Theme, MediaQuery
- Mỗi widget có BuildContext riêng của nó

**Tại sao BuildContext quan trọng:**
- Navigator.push() cần BuildContext để biết Navigator nào đang quản lý route
- Theme.of(context) cần BuildContext để tìm Theme widget gần nhất
- MediaQuery.of(context) cần BuildContext để tìm MediaQuery widget gần nhất

**Lưu ý:**
- BuildContext chỉ hợp lệ trong build() method
- Không lưu BuildContext vào biến để dùng sau (có thể gây lỗi)
- Mỗi widget có BuildContext riêng, không dùng chung

**Ví dụ:**
```dart
@override
Widget build(BuildContext context) {
  // context này là BuildContext của widget này
  return ElevatedButton(
    onPressed: () {
      // Có thể dùng context ở đây vì đang trong build()
      Navigator.push(
        context, // BuildContext cần thiết
        MaterialPageRoute(builder: (context) => NewScreen()),
      );
    },
    child: Text('Navigate'),
  );
}
```

### 6. MaterialPageRoute - Route với Material Design

**MaterialPageRoute là gì:**
- MaterialPageRoute là một loại Route với animation Material Design
- Tạo transition mượt mà khi điều hướng
- Tự động thêm nút back trên AppBar

**Cú pháp:**
```dart
MaterialPageRoute(
  builder: (context) => NewScreen(), // Widget để hiển thị
  settings: RouteSettings(name: '/detail'), // Tùy chọn: tên route
)
```

**Các loại Route khác:**
- `CupertinoPageRoute` - iOS style transition
- `PageRouteBuilder` - Custom transition
- Named routes (sẽ học ở bài nâng cao)

## Cấu trúc code

```
lib/
  └── main.dart
      ├── MyApp (StatelessWidget) - Widget gốc
      ├── HomePage (StatefulWidget) - Màn hình chính
      │   └── _HomePageState
      │       ├── _navigateToDetail() - Điều hướng đến DetailPage
      │       └── build() - Hiển thị danh sách items
      └── DetailPage (StatefulWidget) - Màn hình chi tiết
          └── _DetailPageState
              ├── _goBack() - Quay lại và trả về dữ liệu
              └── build() - Hiển thị và chỉnh sửa dữ liệu
```

## Cách chạy ứng dụng

1. Đảm bảo bạn đang ở branch `03-navigation`
2. Chạy lệnh:
   ```bash
   flutter run -d windows
   ```
3. Thực hiện các bước sau:
   - Nhấn vào một item trong danh sách → DetailPage sẽ hiển thị
   - Chỉnh sửa dữ liệu trong TextField
   - Nhấn "Lưu và quay lại" → Dữ liệu được trả về HomePage
   - Nhấn "Quay lại (không lưu)" → Quay lại mà không trả về dữ liệu

## Luồng điều hướng (Navigation Flow)

### Luồng 1: Điều hướng và trả về dữ liệu

```
1. HomePage: Người dùng nhấn vào item
   ↓
2. HomePage: Gọi Navigator.push() → DetailPage được push vào stack
   ↓
3. DetailPage: Hiển thị, người dùng chỉnh sửa dữ liệu
   ↓
4. DetailPage: Người dùng nhấn "Lưu và quay lại"
   ↓
5. DetailPage: Gọi Navigator.pop(context, data) → DetailPage bị pop khỏi stack
   ↓
6. HomePage: Nhận dữ liệu từ Future và cập nhật UI
```

### Luồng 2: Điều hướng và quay lại không lưu

```
1. HomePage: Người dùng nhấn vào item
   ↓
2. HomePage: Gọi Navigator.push() → DetailPage được push vào stack
   ↓
3. DetailPage: Hiển thị, người dùng chỉnh sửa dữ liệu
   ↓
4. DetailPage: Người dùng nhấn "Quay lại (không lưu)"
   ↓
5. DetailPage: Gọi Navigator.pop(context) → DetailPage bị pop khỏi stack
   ↓
6. HomePage: Future nhận null, không cập nhật UI
```

## Thử nghiệm (Experiments)

Để hiểu rõ hơn, hãy thử:

1. **Thử nghiệm 1: Quan sát Navigator Stack**
   - Nhấn vào item → Xem DetailPage hiển thị
   - Nhấn nút back trên AppBar → Quay lại HomePage
   - Nhận xét: Navigator tự động quản lý stack

2. **Thử nghiệm 2: Trả về dữ liệu**
   - Nhấn vào item → Chỉnh sửa dữ liệu → Nhấn "Lưu và quay lại"
   - Quan sát: Dữ liệu được hiển thị trên HomePage
   - Nhận xét: Navigator.pop() với result trả về dữ liệu

3. **Thử nghiệm 3: Không trả về dữ liệu**
   - Nhấn vào item → Chỉnh sửa dữ liệu → Nhấn "Quay lại (không lưu)"
   - Quan sát: HomePage không cập nhật
   - Nhận xét: Navigator.pop() không có result trả về null

4. **Thử nghiệm 4: Nhiều lần điều hướng**
   - Nhấn vào item → Chỉnh sửa → Lưu
   - Nhấn vào item khác → Chỉnh sửa → Lưu
   - Quan sát: Mỗi lần điều hướng là một route mới trong stack

## Lỗi thường gặp (Common Mistakes)

### ❌ Lỗi 1: Quên await khi push
```dart
// SAI - Không đợi kết quả trả về
void _navigate() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailPage()),
  );
  // Code này chạy ngay, không đợi DetailPage trả về
  print('Đã điều hướng'); // In ngay lập tức
}

// ĐÚNG - Đợi kết quả trả về
Future<void> _navigate() async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailPage()),
  );
  // Code này chỉ chạy sau khi DetailPage trả về
  print('Nhận được: $result');
}
```

### ❌ Lỗi 2: Dùng BuildContext sau dispose()
```dart
// SAI - BuildContext không còn hợp lệ
class _MyState extends State<MyWidget> {
  BuildContext? _savedContext;
  
  @override
  Widget build(BuildContext context) {
    _savedContext = context; // Lưu context
    return Container();
  }
  
  void _someMethod() {
    Navigator.push(_savedContext!, ...); // LỖI! Context không còn hợp lệ
  }
}

// ĐÚNG - Dùng context trong build() hoặc callback
@override
Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(context, ...); // OK - context vẫn hợp lệ
    },
    child: Text('Navigate'),
  );
}
```

### ❌ Lỗi 3: Pop khi không có route nào trong stack
```dart
// SAI - Có thể gây lỗi nếu không có route nào để pop
void _goBack() {
  Navigator.pop(context); // Lỗi nếu đây là route cuối cùng
}

// ĐÚNG - Kiểm tra trước khi pop
void _goBack() {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    // Xử lý trường hợp không thể pop (ví dụ: đóng app)
  }
}
```

### ❌ Lỗi 4: Quên truyền dữ liệu qua constructor
```dart
// SAI - DetailPage không nhận được dữ liệu
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(), // Thiếu tham số
  ),
);

// ĐÚNG - Truyền dữ liệu qua constructor
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(item: 'Hello'), // Có tham số
  ),
);
```

### ❌ Lỗi 5: Không xử lý null khi nhận dữ liệu
```dart
// SAI - Có thể gây lỗi nếu result là null
final result = await Navigator.push<String>(context, ...);
print(result.length); // Lỗi nếu result là null

// ĐÚNG - Kiểm tra null trước
final result = await Navigator.push<String>(context, ...);
if (result != null) {
  print(result.length); // An toàn
}
```

## Tóm tắt (Summary)

| Khái niệm | Mô tả |
|-----------|-------|
| Navigator | Quản lý stack các route (màn hình) |
| Navigator.push() | Thêm route mới vào stack, điều hướng đến màn hình mới |
| Navigator.pop() | Xóa route khỏi stack, quay lại màn hình trước |
| Navigator Stack | Ngăn xếp các route, route ở đỉnh là màn hình hiện tại |
| BuildContext | Ngữ cảnh của widget, cần thiết để truy cập Navigator |
| MaterialPageRoute | Route với Material Design transition |
| Truyền dữ liệu | Qua constructor khi push, qua result khi pop |

## Câu hỏi tự kiểm tra (Self-check Questions)

1. Navigator stack là gì? Tại sao dùng stack?
2. Navigator.push() làm gì? Tại sao cần await?
3. Navigator.pop() làm gì? Làm sao trả về dữ liệu?
4. BuildContext là gì? Tại sao quan trọng?
5. Làm sao truyền dữ liệu từ HomePage đến DetailPage?
6. Làm sao nhận dữ liệu trả về từ DetailPage?
7. Khi nào nên dùng Navigator.pop() với result và khi nào không?

## Tài liệu tham khảo

- [Flutter Documentation - Navigation](https://docs.flutter.dev/ui/navigation)
- [Flutter Documentation - Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
- [Flutter Documentation - MaterialPageRoute](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html)
- [Flutter Documentation - BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)
