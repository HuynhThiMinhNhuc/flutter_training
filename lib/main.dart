import 'package:flutter/material.dart';

/// Hàm main là điểm khởi đầu của ứng dụng Flutter
/// runApp() khởi chạy ứng dụng với widget gốc (root widget)
void main() {
  runApp(const MyApp());
}

/// ============================================
/// MYAPP - Widget gốc với MaterialApp
/// ============================================
///
/// MaterialApp là widget QUAN TRỌNG NHẤT trong Flutter Material Design
///
/// TẠI SAO MaterialApp là BẮT BUỘC?
/// 1. Cung cấp Material Design theme (màu sắc, kiểu chữ, etc.)
/// 2. Quản lý navigation (Navigator)
/// 3. Cung cấp Material Design widgets (AppBar, FloatingActionButton, etc.)
/// 4. Xử lý localization (đa ngôn ngữ)
/// 5. Cung cấp context cho Material widgets
///
/// KHÔNG THỂ dùng Scaffold, AppBar, FloatingActionButton mà không có MaterialApp
/// Vì các widget này cần MaterialApp để lấy theme và context
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training - Material Overview',
      // ThemeData định nghĩa giao diện Material Design
      // Bao gồm: màu sắc, kiểu chữ, button styles, etc.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true, // Sử dụng Material Design 3
      ),
      // Màn hình chính của ứng dụng
      home: const MaterialOverviewDemo(),
    );
  }
}

/// ============================================
/// MATERIAL OVERVIEW DEMO
/// ============================================
///
/// Màn hình này minh họa các Material widgets:
/// - Scaffold: Cấu trúc cơ bản của màn hình Material
/// - AppBar: Thanh tiêu đề ở trên cùng
/// - FloatingActionButton: Nút nổi ở góc dưới bên phải
/// - BottomNavigationBar: Thanh điều hướng ở dưới cùng
///
/// MATERIAL WIDGET HIERARCHY (Thứ bậc widget):
/// MaterialApp (gốc)
///   └── Scaffold (cấu trúc màn hình)
///       ├── AppBar (thanh tiêu đề)
///       ├── Body (nội dung chính)
///       ├── FloatingActionButton (nút nổi)
///       └── BottomNavigationBar (thanh điều hướng)
class MaterialOverviewDemo extends StatefulWidget {
  const MaterialOverviewDemo({super.key});

  @override
  State<MaterialOverviewDemo> createState() => _MaterialOverviewDemoState();
}

class _MaterialOverviewDemoState extends State<MaterialOverviewDemo> {
  // Index của tab hiện tại trong BottomNavigationBar
  int _currentIndex = 0;

  /// Xử lý khi người dùng chọn tab trong BottomNavigationBar
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Cập nhật tab được chọn
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============================================
      // APPBAR - Thanh tiêu đề ở trên cùng
      // ============================================
      //
      // AppBar là widget Material Design hiển thị thanh tiêu đề
      //
      // Các thành phần của AppBar:
      // - leading: Widget ở bên trái (thường là menu hoặc back button)
      // - title: Tiêu đề chính (ở giữa)
      // - actions: Các widget ở bên phải (thường là icon buttons)
      // - backgroundColor: Màu nền
      //
      // AppBar CẦN MaterialApp để:
      // - Lấy theme colors
      // - Hiển thị Material Design style
      // - Sử dụng Material Icons
      appBar: AppBar(
        // Tiêu đề của AppBar
        title: const Text('Material Design Overview'),

        // Màu nền của AppBar
        // Theme.of(context) lấy theme từ MaterialApp
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        // Các widget ở bên phải AppBar
        actions: [
          // Icon button để tìm kiếm
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tìm kiếm được nhấn')),
              );
            },
            tooltip: 'Tìm kiếm',
          ),
          // Icon button để cài đặt
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cài đặt được nhấn')),
              );
            },
            tooltip: 'Cài đặt',
          ),
        ],
      ),

      // ============================================
      // BODY - Nội dung chính của màn hình
      // ============================================
      //
      // Body là nơi hiển thị nội dung chính
      // Có thể là bất kỳ widget nào
      // Ở đây chúng ta hiển thị nội dung dựa trên tab được chọn
      body: _buildBody(),

      // ============================================
      // FLOATING ACTION BUTTON - Nút nổi
      // ============================================
      //
      // FloatingActionButton là nút nổi ở góc dưới bên phải
      //
      // Đặc điểm:
      // - Luôn hiển thị ở vị trí cố định (góc dưới phải)
      // - Có hiệu ứng nổi (elevated) theo Material Design
      // - Thường dùng cho hành động chính (primary action)
      //
      // FloatingActionButton CẦN MaterialApp để:
      // - Lấy theme colors
      // - Hiển thị Material Design style
      // - Sử dụng Material Icons
      floatingActionButton: FloatingActionButton(
        // Callback khi nút được nhấn
        onPressed: () {
          // ScaffoldMessenger hiển thị thông báo tạm thời
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('FloatingActionButton được nhấn!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        // Tooltip hiển thị khi hover
        tooltip: 'Thêm mới',
        // Icon hiển thị trên button
        child: const Icon(Icons.add),
      ),

      // ============================================
      // BOTTOM NAVIGATION BAR - Thanh điều hướng dưới cùng
      // ============================================
      //
      // BottomNavigationBar là thanh điều hướng ở dưới cùng màn hình
      //
      // Đặc điểm:
      // - Hiển thị các tab/icon để điều hướng
      // - Thường có 2-5 items
      // - Item được chọn sẽ được highlight
      //
      // BottomNavigationBar CẦN MaterialApp để:
      // - Lấy theme colors
      // - Hiển thị Material Design style
      // - Sử dụng Material Icons
      bottomNavigationBar: BottomNavigationBar(
        // Index của item được chọn
        currentIndex: _currentIndex,

        // Callback khi người dùng chọn item
        onTap: _onTabTapped,

        // Số lượng items tối đa hiển thị (nếu > 3, sẽ chuyển sang type: shifting)
        type: BottomNavigationBarType.fixed,

        // Danh sách các items
        items: const [
          // Tab 1: Trang chủ
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          // Tab 2: Hồ sơ
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }

  /// Xây dựng nội dung body dựa trên tab được chọn
  Widget _buildBody() {
    // Hiển thị nội dung khác nhau tùy theo tab
    switch (_currentIndex) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  /// Xây dựng nội dung cho tab Trang chủ
  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card giải thích về MaterialApp
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MaterialApp - Widget gốc',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'MaterialApp là widget BẮT BUỘC để sử dụng Material Design.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tại sao cần MaterialApp?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Cung cấp Material Design theme'),
                  const Text('• Quản lý navigation (Navigator)'),
                  const Text('• Cung cấp context cho Material widgets'),
                  const Text('• Xử lý localization'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Card giải thích về Scaffold
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scaffold - Cấu trúc màn hình',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Scaffold cung cấp cấu trúc cơ bản cho màn hình Material Design.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Các thành phần của Scaffold:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('• appBar: Thanh tiêu đề ở trên'),
                  const Text('• body: Nội dung chính'),
                  const Text('• floatingActionButton: Nút nổi'),
                  const Text('• bottomNavigationBar: Thanh điều hướng'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Card giải thích về AppBar
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AppBar - Thanh tiêu đề',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'AppBar hiển thị thanh tiêu đề ở trên cùng màn hình.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Các thành phần:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('• leading: Widget bên trái (menu/back)'),
                  const Text('• title: Tiêu đề chính'),
                  const Text('• actions: Các widget bên phải (icons)'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Card giải thích về FloatingActionButton
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FloatingActionButton - Nút nổi',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'FloatingActionButton là nút nổi ở góc dưới bên phải.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Đặc điểm:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Luôn ở vị trí cố định (góc dưới phải)'),
                  const Text('• Có hiệu ứng nổi (elevated)'),
                  const Text('• Thường dùng cho hành động chính'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Card giải thích về BottomNavigationBar
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BottomNavigationBar - Thanh điều hướng',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'BottomNavigationBar hiển thị thanh điều hướng ở dưới cùng.',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Đặc điểm:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Thường có 2-5 items'),
                  const Text('• Item được chọn sẽ highlight'),
                  const Text('• Dùng để điều hướng giữa các màn hình'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Card về Material Widget Hierarchy
          Card(
            elevation: 4,
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Material Widget Hierarchy',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Thứ bậc widget Material:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('MaterialApp (gốc)'),
                  const Text('  └── Scaffold'),
                  const Text('      ├── AppBar'),
                  const Text('      ├── Body'),
                  const Text('      ├── FloatingActionButton'),
                  const Text('      └── BottomNavigationBar'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Xây dựng nội dung cho tab Hồ sơ
  Widget _buildProfileTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon profile lớn
            Icon(
              Icons.person,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),

            // Tên người dùng
            Text(
              'Người dùng',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Email
            Text(
              'user@example.com',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 40),

            // Card thông tin
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: const Text('user@example.com'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Điện thoại'),
                      subtitle: const Text('+84 123 456 789'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Địa chỉ'),
                      subtitle: const Text('Hà Nội, Việt Nam'),
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
