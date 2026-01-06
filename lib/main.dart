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
      title: 'Flutter Training - State Lifecycle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Màn hình chính của ứng dụng
      home: const HomeScreen(),
    );
  }
}

/// Màn hình chính - HomeScreen
/// Màn hình này có nút để điều hướng đến LifecycleDemoScreen
/// Khi quay lại, chúng ta có thể quan sát lifecycle methods được gọi
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Màn hình chính'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nhấn nút bên dưới để xem\nLifecycle Demo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigator.push tạo một route mới và đẩy vào stack
                // Khi điều hướng, LifecycleDemoScreen sẽ được tạo
                // => initState() sẽ được gọi
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LifecycleDemoScreen(),
                  ),
                );
              },
              child: const Text('Xem Lifecycle Demo'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================
/// LIFECYCLE DEMO SCREEN
/// ============================================
///
/// Màn hình này minh họa tất cả các lifecycle methods của StatefulWidget
/// Mỗi lifecycle method sẽ in log ra console để bạn có thể theo dõi
///
/// VÒNG ĐỜI CỦA STATEFULWIDGET:
/// 1. createState() - Tạo State object (tự động, không override)
/// 2. initState() - Khởi tạo, chỉ gọi 1 lần
/// 3. didChangeDependencies() - Gọi sau initState(), có thể gọi nhiều lần
/// 4. build() - Xây dựng UI, gọi nhiều lần
/// 5. didUpdateWidget() - Khi widget được cập nhật (props thay đổi)
/// 6. dispose() - Dọn dẹp, chỉ gọi 1 lần khi widget bị hủy
class LifecycleDemoScreen extends StatefulWidget {
  const LifecycleDemoScreen({super.key});

  @override
  State<LifecycleDemoScreen> createState() => _LifecycleDemoScreenState();
}

/// State class quản lý trạng thái và lifecycle của LifecycleDemoScreen
class _LifecycleDemoScreenState extends State<LifecycleDemoScreen> {
  // Biến đếm để minh họa setState()
  int _counter = 0;

  // Biến để lưu số lần build() được gọi
  int _buildCount = 0;

  /// ============================================
  /// 1. initState()
  /// ============================================
  ///
  /// Được gọi CHỈ MỘT LẦN khi State object được tạo
  ///
  /// Khi nào được gọi:
  /// - Ngay sau khi createState() tạo State object
  /// - TRƯỚC build() method lần đầu tiên
  ///
  /// Dùng để làm gì:
  /// - Khởi tạo dữ liệu
  /// - Đăng ký listeners (Stream, AnimationController, etc.)
  /// - Gọi API một lần
  /// - Thiết lập các giá trị ban đầu
  ///
  /// LƯU Ý:
  /// - KHÔNG gọi setState() ở đây (sẽ gây lỗi)
  /// - KHÔNG truy cập BuildContext.dependOnInheritedWidgetOfExactType() ở đây
  /// - Nếu cần, dùng SchedulerBinding.instance.addPostFrameCallback()
  @override
  void initState() {
    super.initState(); // QUAN TRỌNG: Luôn gọi super.initState() trước

    debugPrint('═══════════════════════════════════════');
    print('🟢 initState() được gọi');
    print('   → Widget vừa được tạo');
    print('   → Đây là nơi khởi tạo dữ liệu');
    print('═══════════════════════════════════════');

    // Ví dụ: Khởi tạo giá trị ban đầu
    _counter = 0;
    _buildCount = 0;
  }

  /// ============================================
  /// 2. didChangeDependencies()
  /// ============================================
  ///
  /// Được gọi SAU initState() và SAU build() lần đầu
  /// Có thể được gọi NHIỀU LẦN nếu InheritedWidget thay đổi
  ///
  /// Khi nào được gọi:
  /// - Sau initState() (lần đầu)
  /// - Khi InheritedWidget mà widget này phụ thuộc vào thay đổi
  /// - Ví dụ: Theme, MediaQuery, Localizations thay đổi
  ///
  /// Dùng để làm gì:
  /// - Lấy dữ liệu từ InheritedWidget (Theme, MediaQuery, etc.)
  /// - Khởi tạo dữ liệu phụ thuộc vào context
  ///
  /// LƯU Ý:
  /// - Có thể gọi setState() ở đây (nhưng cẩn thận)
  /// - Được gọi trước build() lần đầu tiên
  @override
  void didChangeDependencies() {
    super.didChangeDependencies(); // QUAN TRỌNG: Luôn gọi super

    print('🟡 didChangeDependencies() được gọi');
    print('   → Dependencies đã sẵn sàng');
    print('   → Có thể truy cập Theme, MediaQuery, etc.');

    // Ví dụ: Lấy dữ liệu từ InheritedWidget
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    print('   → Theme primary color: ${theme.colorScheme.primary}');
    print('   → Screen width: ${mediaQuery.size.width}');
  }

  /// ============================================
  /// 3. build()
  /// ============================================
  ///
  /// Được gọi NHIỀU LẦN để xây dựng UI
  ///
  /// Khi nào được gọi:
  /// - Sau initState() và didChangeDependencies() (lần đầu)
  /// - Mỗi khi setState() được gọi
  /// - Khi parent widget rebuild và truyền props mới
  /// - Khi InheritedWidget thay đổi (nếu widget phụ thuộc)
  ///
  /// Dùng để làm gì:
  /// - Xây dựng widget tree (UI)
  /// - Trả về widget để hiển thị
  ///
  /// LƯU Ý:
  /// - KHÔNG gọi setState() ở đây (gây vòng lặp vô hạn)
  /// - KHÔNG thực hiện logic nặng ở đây
  /// - build() phải là pure function (không có side effects)
  /// - build() có thể được gọi 60 lần/giây (60 FPS)
  @override
  Widget build(BuildContext context) {
    // Tăng số lần build() được gọi
    _buildCount++;

    print('🔵 build() được gọi (lần $_buildCount)');
    print('   → Xây dựng UI với counter = $_counter');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifecycle Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card hiển thị thông tin lifecycle
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lifecycle Methods',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildLifecycleInfo('initState()', 'Đã gọi', Colors.green),
                    _buildLifecycleInfo(
                        'didChangeDependencies()', 'Đã gọi', Colors.orange),
                    _buildLifecycleInfo(
                        'build()', 'Đã gọi $_buildCount lần', Colors.blue),
                    _buildLifecycleInfo(
                        'didUpdateWidget()', 'Chưa gọi', Colors.grey),
                    _buildLifecycleInfo('dispose()', 'Chưa gọi', Colors.red),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Card hiển thị counter
            Card(
              elevation: 4,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Counter Demo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.blue,
                          ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // setState() sẽ trigger build() được gọi lại
                        setState(() {
                          _counter++;
                        });
                        print(
                            '   → setState() được gọi → build() sẽ được gọi lại');
                      },
                      child: const Text('Tăng Counter'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Hướng dẫn
            Card(
              color: Colors.amber.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📝 Hướng dẫn:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('1. Xem console để theo dõi lifecycle methods'),
                    Text('2. Nhấn "Tăng Counter" → build() được gọi lại'),
                    Text('3. Nhấn "Quay lại" → dispose() được gọi'),
                    Text(
                        '4. Nhấn "Xem Lifecycle Demo" lại → initState() được gọi lại'),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Nút quay lại
            ElevatedButton(
              onPressed: () {
                // Navigator.pop() xóa route hiện tại khỏi stack
                // => dispose() sẽ được gọi
                print('   → Navigator.pop() được gọi → dispose() sẽ được gọi');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Quay lại (Gọi dispose())'),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method để hiển thị thông tin lifecycle
  Widget _buildLifecycleInfo(String method, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            method,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '→ $status',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  /// ============================================
  /// 4. didUpdateWidget()
  /// ============================================
  ///
  /// Được gọi khi widget được CẬP NHẬT với widget mới cùng loại
  ///
  /// Khi nào được gọi:
  /// - Khi parent widget rebuild và truyền widget mới (cùng type)
  /// - Widget cũ và widget mới có cùng runtimeType
  /// - Widget mới có props khác với widget cũ
  ///
  /// Dùng để làm gì:
  /// - So sánh props cũ và mới
  /// - Cập nhật state dựa trên props mới
  /// - Hủy đăng ký listeners cũ và đăng ký listeners mới
  ///
  /// LƯU Ý:
  /// - Được gọi TRƯỚC build() khi widget được cập nhật
  /// - Có thể gọi setState() ở đây
  /// - oldWidget chứa props cũ để so sánh
  @override
  void didUpdateWidget(LifecycleDemoScreen oldWidget) {
    super.didUpdateWidget(oldWidget); // QUAN TRỌNG: Luôn gọi super

    print('🟣 didUpdateWidget() được gọi');
    print('   → Widget được cập nhật với props mới');
    print('   → oldWidget: $oldWidget');
    print('   → widget: ${widget}');

    // Ví dụ: So sánh và cập nhật state
    // Nếu có props thay đổi, có thể cập nhật state ở đây
  }

  /// ============================================
  /// 5. dispose()
  /// ============================================
  ///
  /// Được gọi CHỈ MỘT LẦN khi State object bị HỦY
  ///
  /// Khi nào được gọi:
  /// - Khi widget bị xóa vĩnh viễn khỏi widget tree
  /// - Khi Navigator.pop() được gọi
  /// - Khi parent widget rebuild và không còn widget này
  ///
  /// Dùng để làm gì:
  /// - Hủy đăng ký listeners (Stream, AnimationController, etc.)
  /// - Đóng connections (database, network, etc.)
  /// - Giải phóng tài nguyên (timers, file handles, etc.)
  /// - Dọn dẹp để tránh memory leaks
  ///
  /// LƯU Ý:
  /// - KHÔNG gọi setState() ở đây (widget đã bị hủy)
  /// - KHÔNG truy cập BuildContext sau dispose()
  /// - QUAN TRỌNG: Luôn hủy đăng ký listeners để tránh memory leaks
  @override
  void dispose() {
    print('═══════════════════════════════════════');
    print('🔴 dispose() được gọi');
    print('   → Widget đang bị hủy');
    print('   → Đây là nơi dọn dẹp tài nguyên');
    print('   → Hủy đăng ký listeners, đóng connections, etc.');
    print('═══════════════════════════════════════');

    // Ví dụ: Hủy đăng ký listeners
    // streamSubscription?.cancel();
    // animationController?.dispose();
    // timer?.cancel();

    super.dispose(); // QUAN TRỌNG: Luôn gọi super.dispose() CUỐI CÙNG
  }
}
