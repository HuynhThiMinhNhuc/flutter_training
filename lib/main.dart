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
      title: 'Flutter Training - Stateless vs Stateful',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Màn hình chính của ứng dụng
      home: const CounterComparisonScreen(),
    );
  }
}

/// Màn hình so sánh giữa StatelessWidget và StatefulWidget
/// Màn hình này chứa 2 bộ đếm để minh họa sự khác biệt
class CounterComparisonScreen extends StatelessWidget {
  const CounterComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widget'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bộ đếm dùng StatelessWidget - KHÔNG thể cập nhật
            StatelessCounter(),

            SizedBox(height: 40),

            // Bộ đếm dùng StatefulWidget - CÓ THỂ cập nhật
            StatefulCounter(),
          ],
        ),
      ),
    );
  }
}

/// ============================================
/// STATELESS COUNTER - BỘ ĐẾM KHÔNG THỂ CẬP NHẬT
/// ============================================
///
/// StatelessWidget là widget KHÔNG có trạng thái có thể thay đổi
/// - Không có State object
/// - Không có phương thức setState()
/// - build() chỉ được gọi một lần khi widget được tạo
/// - Nếu muốn thay đổi UI, phải tạo widget mới với dữ liệu mới
///
/// TẠI SAO StatelessWidget không thể cập nhật UI?
/// - StatelessWidget là immutable (bất biến)
/// - Khi bạn thay đổi biến, widget không biết để rebuild
/// - Flutter framework không theo dõi thay đổi trong StatelessWidget
/// - Do đó, UI không được cập nhật khi biến thay đổi
class StatelessCounter extends StatelessWidget {
  const StatelessCounter({super.key});

  @override
  Widget build(BuildContext context) {
    // Biến counter được khai báo trong build()
    // Mỗi lần build() được gọi, biến này được khởi tạo lại = 0
    // NHƯNG: build() chỉ được gọi khi widget được tạo lần đầu
    // Khi nhấn nút, biến tăng lên nhưng build() KHÔNG được gọi lại
    // => UI không cập nhật!
    int counter = 0;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Tiêu đề với màu đỏ để cảnh báo
            Text(
              'StatelessWidget Counter',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              '(Giá trị KHÔNG thay đổi khi nhấn nút)',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),

            // Hiển thị giá trị counter
            // Giá trị này luôn là 0 vì build() không được gọi lại
            Text(
              '$counter',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.red,
                  ),
            ),
            const SizedBox(height: 20),

            // Nút tăng counter
            ElevatedButton(
              onPressed: () {
                // Khi nhấn nút này:
                // 1. Biến counter tăng lên (counter++)
                // 2. NHƯNG build() KHÔNG được gọi lại
                // 3. Flutter không biết có thay đổi
                // 4. UI vẫn hiển thị giá trị cũ (0)
                counter++;
                print(
                    'Counter tăng lên: $counter'); // In ra console để kiểm tra
                // Nhưng UI không cập nhật vì không có setState()
              },
              child: const Text('Tăng Counter (Không hoạt động)'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================
/// STATEFUL COUNTER - BỘ ĐẾM CÓ THỂ CẬP NHẬT
/// ============================================
///
/// StatefulWidget là widget CÓ trạng thái có thể thay đổi
/// - Có State object riêng để lưu trữ dữ liệu
/// - Có phương thức setState() để thông báo thay đổi
/// - build() được gọi lại mỗi khi setState() được gọi
/// - UI được cập nhật tự động khi trạng thái thay đổi
///
/// TẠI SAO StatefulWidget có thể cập nhật UI?
/// - StatefulWidget tách biệt widget (immutable) và state (mutable)
/// - State object lưu trữ dữ liệu có thể thay đổi
/// - setState() thông báo cho Flutter framework biết có thay đổi
/// - Flutter gọi lại build() để rebuild UI với dữ liệu mới
class StatefulCounter extends StatefulWidget {
  const StatefulCounter({super.key});

  // createState() tạo ra State object
  // State object này sẽ lưu trữ và quản lý trạng thái của widget
  @override
  State<StatefulCounter> createState() => _StatefulCounterState();
}

/// State class chứa logic và dữ liệu của StatefulWidget
/// Đây là nơi lưu trữ trạng thái có thể thay đổi
class _StatefulCounterState extends State<StatefulCounter> {
  // Biến counter được khai báo trong State class
  // Biến này PERSIST (tồn tại) giữa các lần rebuild
  // Không bị reset về 0 mỗi lần build() được gọi
  int counter = 0;

  // Phương thức tăng counter
  void _incrementCounter() {
    // setState() là phương thức QUAN TRỌNG NHẤT
    // Nó thông báo cho Flutter framework biết:
    // "Có thay đổi trong state, hãy rebuild UI!"
    setState(() {
      // Tất cả thay đổi trong callback này sẽ trigger rebuild
      counter++;
      print('Counter tăng lên: $counter'); // In ra console để kiểm tra
    });

    // Sau khi setState() hoàn thành:
    // 1. Flutter framework biết có thay đổi
    // 2. Flutter gọi lại build() method
    // 3. build() tạo widget tree mới với giá trị counter mới
    // 4. UI được cập nhật để hiển thị giá trị mới
  }

  @override
  Widget build(BuildContext context) {
    // build() được gọi:
    // - Lần đầu khi widget được tạo
    // - Mỗi khi setState() được gọi
    // - Khi parent widget rebuild và truyền props mới

    // LƯU Ý: build() có thể được gọi NHIỀU LẦN
    // Nhưng biến counter trong State class KHÔNG bị reset
    // Vì nó nằm ngoài build() method

    print('build() được gọi, counter = $counter'); // Debug log

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Tiêu đề với màu xanh để chỉ ra hoạt động tốt
            Text(
              'StatefulWidget Counter',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              '(Giá trị THAY ĐỔI khi nhấn nút)',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),

            // Hiển thị giá trị counter
            // Giá trị này CẬP NHẬT mỗi khi setState() được gọi
            Text(
              '$counter',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.green,
                  ),
            ),
            const SizedBox(height: 20),

            // Nút tăng counter
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Tăng Counter (Hoạt động!)'),
            ),
          ],
        ),
      ),
    );
  }
}
