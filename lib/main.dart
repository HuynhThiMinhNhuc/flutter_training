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
      title: 'Flutter Training - Basic Layout',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Màn hình chính của ứng dụng
      home: const BasicLayoutDemo(),
    );
  }
}

/// ============================================
/// BASIC LAYOUT DEMO
/// ============================================
///
/// Màn hình này minh họa hệ thống layout trong Flutter:
/// - Row / Column: Sắp xếp widget theo chiều ngang/dọc
/// - Expanded / Flexible: Phân chia không gian
/// - Padding / SizedBox: Tạo khoảng cách
/// - Center / Align: Căn chỉnh vị trí
/// - Stack: Xếp chồng widget
///
/// KHÁI NIỆM QUAN TRỌNG: Constraints (Ràng buộc)
/// - Widget cha truyền constraints (giới hạn) cho widget con
/// - Widget con phải tuân theo constraints của cha
/// - Constraints bao gồm: min/max width và min/max height
/// - Flutter sử dụng constraint-based layout system
class BasicLayoutDemo extends StatelessWidget {
  const BasicLayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Layout Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView cho phép cuộn khi nội dung dài
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ============================================
            // 1. ROW - Sắp xếp theo chiều ngang
            // ============================================
            _buildSection(
              context: context,
              title: '1. Row - Sắp xếp theo chiều ngang',
              description:
                  'Row sắp xếp các widget con theo chiều ngang (từ trái sang phải)',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row cơ bản
                  const Text(
                    'Row cơ bản:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildColoredBox('1', Colors.red),
                      _buildColoredBox('2', Colors.green),
                      _buildColoredBox('3', Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Row với mainAxisAlignment
                  const Text(
                    'Row với mainAxisAlignment (căn chỉnh theo chiều ngang):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Căn giữa
                    children: [
                      _buildColoredBox('1', Colors.red),
                      _buildColoredBox('2', Colors.green),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Căn đều
                    children: [
                      _buildColoredBox('1', Colors.red),
                      _buildColoredBox('2', Colors.green),
                      _buildColoredBox('3', Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Row với crossAxisAlignment
                  const Text(
                    'Row với crossAxisAlignment (căn chỉnh theo chiều dọc):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Căn trên
                    children: [
                      _buildColoredBox('1', Colors.red, height: 60),
                      _buildColoredBox('2', Colors.green, height: 80),
                      _buildColoredBox('3', Colors.blue, height: 40),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 2. COLUMN - Sắp xếp theo chiều dọc
            // ============================================
            _buildSection(
              context: context,
              title: '2. Column - Sắp xếp theo chiều dọc',
              description:
                  'Column sắp xếp các widget con theo chiều dọc (từ trên xuống dưới)',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column cơ bản
                  const Text(
                    'Column cơ bản:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Column(
                        children: [
                          _buildColoredBox('1', Colors.red),
                          _buildColoredBox('2', Colors.green),
                          _buildColoredBox('3', Colors.blue),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Column với mainAxisAlignment
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa
                        children: [
                          _buildColoredBox('1', Colors.red),
                          _buildColoredBox('2', Colors.green),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // Column với crossAxisAlignment
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end, // Căn phải
                        children: [
                          _buildColoredBox('1', Colors.red, width: 60),
                          _buildColoredBox('2', Colors.green, width: 80),
                          _buildColoredBox('3', Colors.blue, width: 40),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 3. EXPANDED - Chiếm không gian còn lại
            // ============================================
            _buildSection(
              context: context,
              title: '3. Expanded - Chiếm không gian còn lại',
              description:
                  'Expanded cho phép widget con chiếm không gian còn lại trong Row/Column',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Row với Expanded (chia đều không gian):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildColoredBox('1', Colors.red),
                      ),
                      Expanded(
                        child: _buildColoredBox('2', Colors.green),
                      ),
                      Expanded(
                        child: _buildColoredBox('3', Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Row với Expanded và flex (tỷ lệ khác nhau):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 2, // Chiếm 2 phần
                        child: _buildColoredBox('1', Colors.red),
                      ),
                      Expanded(
                        flex: 1, // Chiếm 1 phần
                        child: _buildColoredBox('2', Colors.green),
                      ),
                      Expanded(
                        flex: 1, // Chiếm 1 phần
                        child: _buildColoredBox('3', Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Row với widget thường và Expanded:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildColoredBox('Fixed', Colors.orange,
                          width: 80), // Kích thước cố định
                      Expanded(
                        child: _buildColoredBox('Expanded',
                            Colors.purple), // Chiếm không gian còn lại
                      ),
                      _buildColoredBox('Fixed', Colors.orange,
                          width: 80), // Kích thước cố định
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 4. FLEXIBLE - Linh hoạt hơn Expanded
            // ============================================
            _buildSection(
              context: context,
              title: '4. Flexible - Linh hoạt hơn Expanded',
              description:
                  'Flexible cho phép widget con chiếm không gian nhưng không bắt buộc phải chiếm hết',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sự khác biệt giữa Expanded và Flexible:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Expanded: Bắt buộc chiếm hết không gian còn lại'),
                  const Text(
                      'Flexible: Có thể chiếm ít hơn nếu widget con nhỏ'),
                  const SizedBox(height: 16),
                  const Text(
                    'Row với Flexible:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: _buildColoredBox('Flexible', Colors.teal),
                      ),
                      _buildColoredBox('Fixed', Colors.orange, width: 100),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 5. PADDING - Tạo khoảng cách bên trong
            // ============================================
            _buildSection(
              context: context,
              title: '5. Padding - Tạo khoảng cách bên trong',
              description:
                  'Padding tạo khoảng cách bên trong widget (giữa border và nội dung)',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Padding với EdgeInsets.all (tất cả các phía):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildColoredBox('Padding 16', Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Padding với EdgeInsets.symmetric (ngang/dọc):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: _buildColoredBox('H:20 V:10', Colors.green),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Padding với EdgeInsets.only (từng phía):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, top: 10, right: 10, bottom: 20),
                    child: _buildColoredBox('L:30 T:10 R:10 B:20', Colors.red),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 6. SIZEDBOX - Tạo khoảng cách hoặc kích thước cố định
            // ============================================
            _buildSection(
              context: context,
              title: '6. SizedBox - Khoảng cách hoặc kích thước cố định',
              description:
                  'SizedBox có thể tạo khoảng cách (spacer) hoặc widget với kích thước cố định',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SizedBox làm spacer (khoảng cách):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildColoredBox('1', Colors.red),
                      const SizedBox(width: 20), // Khoảng cách 20px
                      _buildColoredBox('2', Colors.green),
                      const SizedBox(width: 40), // Khoảng cách 40px
                      _buildColoredBox('3', Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'SizedBox với kích thước cố định:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 200,
                    height: 100,
                    child: _buildColoredBox('200x100', Colors.purple),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 7. CENTER - Căn giữa widget
            // ============================================
            _buildSection(
              context: context,
              title: '7. Center - Căn giữa widget',
              description:
                  'Center căn giữa widget con trong không gian của widget cha',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Center căn giữa widget:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 100,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: _buildColoredBox('Centered', Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 8. ALIGN - Căn chỉnh vị trí tùy chỉnh
            // ============================================
            _buildSection(
              context: context,
              title: '8. Align - Căn chỉnh vị trí tùy chỉnh',
              description:
                  'Align cho phép căn chỉnh widget con ở vị trí bất kỳ trong widget cha',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Align với các vị trí khác nhau:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,
                          color: Colors.grey.shade200,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: _buildColoredBox('TL', Colors.red,
                                width: 50, height: 50),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 100,
                          color: Colors.grey.shade200,
                          child: Align(
                            alignment: Alignment.center,
                            child: _buildColoredBox('C', Colors.green,
                                width: 50, height: 50),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 100,
                          color: Colors.grey.shade200,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: _buildColoredBox('BR', Colors.blue,
                                width: 50, height: 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 9. STACK - Xếp chồng widget
            // ============================================
            _buildSection(
              context: context,
              title: '9. Stack - Xếp chồng widget',
              description:
                  'Stack xếp chồng các widget con lên nhau, widget sau che widget trước',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Stack cơ bản (xếp chồng):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      // Widget đầu tiên (ở dưới)
                      Container(
                        width: 150,
                        height: 150,
                        color: Colors.red.shade300,
                        child: const Center(child: Text('Layer 1')),
                      ),
                      // Widget thứ hai (ở giữa, lệch một chút)
                      Positioned(
                        left: 30,
                        top: 30,
                        child: Container(
                          width: 150,
                          height: 150,
                          color: Colors.green.shade300,
                          child: const Center(child: Text('Layer 2')),
                        ),
                      ),
                      // Widget thứ ba (ở trên, lệch thêm)
                      Positioned(
                        left: 60,
                        top: 60,
                        child: Container(
                          width: 150,
                          height: 150,
                          color: Colors.blue.shade300,
                          child: const Center(child: Text('Layer 3')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Stack với Positioned (vị trí tuyệt đối):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 120,
                    color: Colors.grey.shade200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: 10,
                          child: _buildColoredBox('L:10 T:10', Colors.red,
                              width: 80, height: 40),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: _buildColoredBox('R:10 T:10', Colors.green,
                              width: 80, height: 40),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 10,
                          child: _buildColoredBox('L:10 B:10', Colors.blue,
                              width: 80, height: 40),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: _buildColoredBox('R:10 B:10', Colors.orange,
                              width: 80, height: 40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // TỔNG KẾT: CONSTRAINTS
            // ============================================
            _buildSection(
              context: context,
              title: 'Tổng kết: Constraints (Ràng buộc)',
              description:
                  'Hiểu về constraint system là chìa khóa để làm layout trong Flutter',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber, width: 2),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Constraint System:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('• Widget cha truyền constraints cho widget con'),
                    Text('• Constraints: min/max width và min/max height'),
                    Text('• Widget con PHẢI tuân theo constraints của cha'),
                    Text('• Expanded/Flexible giúp phân chia không gian'),
                    SizedBox(height: 12),
                    Text(
                      'Lưu ý:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('• Row/Column không thể có kích thước vô hạn'),
                    Text(
                        '• Phải dùng Expanded/Flexible hoặc kích thước cố định'),
                    Text('• Stack cho phép xếp chồng và định vị tuyệt đối'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method để tạo một section (phần) cho mỗi layout widget
  Widget _buildSection({
    required BuildContext context,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề section
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),

            const SizedBox(height: 8),

            // Mô tả
            Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 16),

            // Nội dung (child widget)
            child,
          ],
        ),
      ),
    );
  }

  /// Helper method để tạo một box có màu để minh họa
  Widget _buildColoredBox(String text, Color color,
      {double? width, double? height}) {
    return Container(
      width: width ?? 60,
      height: height ?? 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
