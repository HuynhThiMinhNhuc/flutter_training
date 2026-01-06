import 'package:flutter/material.dart';

/// Hàm main là điểm khởi đầu của ứng dụng Flutter
/// runApp() khởi chạy ứng dụng với widget gốc (root widget)
void main() {
  runApp(const MyApp());
}

/// MyApp là widget gốc của ứng dụng
/// Đây là StatelessWidget vì nó không cần thay đổi trạng thái
/// MaterialApp cung cấp các thành phần Material Design cơ bản
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training - Navigation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Màn hình chính của ứng dụng
      home: const HomePage(),
    );
  }
}

/// ============================================
/// HOME PAGE - Màn hình chính
/// ============================================
///
/// Màn hình này minh họa:
/// - Điều hướng đến DetailPage bằng Navigator.push()
/// - Truyền dữ liệu đến DetailPage (qua constructor)
/// - Nhận dữ liệu trả về từ DetailPage (qua Navigator.pop())
///
/// NAVIGATOR STACK (Ngăn xếp điều hướng):
/// - Navigator quản lý một stack (ngăn xếp) các route
/// - Navigator.push() thêm route mới vào đỉnh stack
/// - Navigator.pop() xóa route ở đỉnh stack
/// - Route ở đỉnh stack là màn hình hiện tại đang hiển thị
///
/// BuildContext:
/// - BuildContext chứa thông tin về vị trí widget trong widget tree
/// - BuildContext cần thiết để truy cập Navigator
/// - Mỗi widget có BuildContext riêng của nó
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Danh sách các item để hiển thị
  final List<String> _items = [
    'Item 1: Học Flutter',
    'Item 2: Làm dự án',
    'Item 3: Thực hành Navigation',
    'Item 4: Hiểu BuildContext',
  ];

  // Lưu dữ liệu trả về từ DetailPage
  String? _returnedData;

  /// Điều hướng đến DetailPage
  ///
  /// Navigator.push() làm gì:
  /// 1. Tạo route mới (DetailPage)
  /// 2. Đẩy route mới vào đỉnh của Navigator stack
  /// 3. Hiển thị DetailPage (màn hình mới che phủ HomePage)
  /// 4. Trả về Future - sẽ complete khi DetailPage được pop
  ///
  /// await: Đợi cho đến khi DetailPage trả về kết quả
  /// Khi DetailPage gọi Navigator.pop(result), Future này sẽ complete với giá trị result
  Future<void> _navigateToDetail(String item) async {
    // Navigator.push() trả về Future<T?>
    // Future này sẽ complete khi DetailPage gọi Navigator.pop()
    // Giá trị trả về là tham số của Navigator.pop(result)
    final result = await Navigator.push<String>(
      context, // BuildContext cần thiết để truy cập Navigator
      MaterialPageRoute(
        builder: (context) => DetailPage(
          item: item, // Truyền dữ liệu qua constructor
        ),
      ),
    );

    // Sau khi DetailPage trả về (Navigator.pop() được gọi)
    // result sẽ chứa giá trị được trả về từ DetailPage
    if (result != null) {
      setState(() {
        _returnedData = result; // Cập nhật UI với dữ liệu trả về
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card giải thích Navigator Stack
            Card(
              elevation: 4,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigator Stack',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Stack hiện tại: [HomePage]'),
                    const Text('→ Nhấn item để push DetailPage'),
                    const Text('→ Stack sẽ thành: [HomePage, DetailPage]'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Danh sách các item
            Text(
              'Danh sách Items:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            // ListView hiển thị các item
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(item),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      // Khi nhấn vào item, điều hướng đến DetailPage
                      onTap: () => _navigateToDetail(item),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Hiển thị dữ liệu trả về từ DetailPage
            if (_returnedData != null)
              Card(
                elevation: 4,
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dữ liệu trả về từ DetailPage:',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _returnedData!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ============================================
/// DETAIL PAGE - Màn hình chi tiết
/// ============================================
///
/// Màn hình này minh hướa:
/// - Nhận dữ liệu từ HomePage (qua constructor)
/// - Cho phép người dùng chỉnh sửa dữ liệu
/// - Trả về dữ liệu về HomePage (qua Navigator.pop())
///
/// NAVIGATOR.POP():
/// - Xóa route hiện tại (DetailPage) khỏi Navigator stack
/// - Quay lại màn hình trước đó (HomePage)
/// - Có thể trả về dữ liệu về màn hình trước
///
/// BuildContext trong DetailPage:
/// - BuildContext này khác với BuildContext trong HomePage
/// - Mỗi widget có BuildContext riêng
/// - BuildContext này được truyền vào builder của MaterialPageRoute
class DetailPage extends StatefulWidget {
  // Nhận dữ liệu từ HomePage qua constructor
  final String item;

  const DetailPage({
    super.key,
    required this.item, // Dữ liệu được truyền từ HomePage
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // TextEditingController để quản lý TextField
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo TextEditingController với giá trị ban đầu từ widget.item
    _textController = TextEditingController(text: widget.item);
  }

  @override
  void dispose() {
    // QUAN TRỌNG: Dispose TextEditingController để tránh memory leak
    _textController.dispose();
    super.dispose();
  }

  /// Quay lại HomePage và trả về dữ liệu
  ///
  /// Navigator.pop() làm gì:
  /// 1. Xóa route hiện tại (DetailPage) khỏi Navigator stack
  /// 2. Hiển thị lại route trước đó (HomePage)
  /// 3. Trả về giá trị result cho Future trong Navigator.push()
  ///
  /// Nếu không truyền result, Navigator.pop() sẽ trả về null
  void _goBack() {
    // Navigator.pop() với result
    // Giá trị này sẽ được trả về cho Future trong HomePage._navigateToDetail()
    Navigator.pop(context, _textController.text);
  }

  /// Quay lại HomePage mà không trả về dữ liệu
  void _goBackWithoutData() {
    // Navigator.pop() không có result
    // Future trong HomePage sẽ nhận null
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card giải thích
            Card(
              elevation: 4,
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thông tin:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text('Dữ liệu nhận được: ${widget.item}'),
                    const SizedBox(height: 8),
                    const Text('→ Chỉnh sửa dữ liệu bên dưới'),
                    const Text('→ Nhấn "Lưu và quay lại" để trả về dữ liệu'),
                    const Text('→ Nhấn "Quay lại" để không trả về dữ liệu'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // TextField để chỉnh sửa dữ liệu
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Chỉnh sửa dữ liệu',
                border: OutlineInputBorder(),
                hintText: 'Nhập dữ liệu mới...',
              ),
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            // Nút lưu và quay lại (trả về dữ liệu)
            ElevatedButton.icon(
              onPressed: _goBack,
              icon: const Icon(Icons.save),
              label: const Text('Lưu và quay lại'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const SizedBox(height: 12),

            // Nút quay lại (không trả về dữ liệu)
            OutlinedButton.icon(
              onPressed: _goBackWithoutData,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Quay lại (không lưu)'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            const Spacer(),

            // Card giải thích Navigator Stack
            Card(
              elevation: 4,
              color: Colors.purple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Navigator Stack hiện tại:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text('[HomePage, DetailPage] ← Bạn đang ở đây'),
                    const SizedBox(height: 8),
                    const Text('→ Nhấn "Quay lại" để pop DetailPage'),
                    const Text('→ Stack sẽ thành: [HomePage]'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
