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
      title: 'Flutter Training - Basic Widgets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Màn hình chính của ứng dụng
      home: const BasicWidgetsDemo(),
    );
  }
}

/// ============================================
/// BASIC WIDGETS DEMO
/// ============================================
///
/// Màn hình này minh họa các widget cơ bản trong Flutter:
/// - Text: Hiển thị văn bản
/// - Icon: Hiển thị biểu tượng
/// - Image: Hiển thị hình ảnh
/// - ElevatedButton: Nút bấm
/// - GestureDetector: Phát hiện cử chỉ (tap, long press, etc.)
/// - TextField: Ô nhập văn bản
///
/// KHÁI NIỆM QUAN TRỌNG: "Everything is a Widget"
/// - Trong Flutter, MỌI THỨ đều là widget
/// - Text là widget, Icon là widget, Button là widget
/// - Ngay cả layout (Row, Column) cũng là widget
/// - Widget có thể chứa widget khác (widget composition)
/// - Widget tree là cây các widget lồng nhau
class BasicWidgetsDemo extends StatefulWidget {
  const BasicWidgetsDemo({super.key});

  @override
  State<BasicWidgetsDemo> createState() => _BasicWidgetsDemoState();
}

class _BasicWidgetsDemoState extends State<BasicWidgetsDemo> {
  // Biến để lưu giá trị từ TextField
  String _textFieldValue = '';

  // Biến để đếm số lần nhấn button
  int _buttonPressCount = 0;

  // Biến để đếm số lần tap vào GestureDetector
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Widgets Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView cho phép cuộn khi nội dung dài
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ============================================
            // 1. TEXT WIDGET
            // ============================================
            _buildSection(
              title: '1. Text Widget',
              description: 'Text widget hiển thị văn bản trên màn hình',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text cơ bản
                  const Text('Đây là Text widget cơ bản'),

                  const SizedBox(height: 8),

                  // Text với style
                  const Text(
                    'Text với style (màu đỏ, đậm)',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Text với nhiều style khác nhau
                  const Text(
                    'Text với nhiều style: màu xanh, nghiêng, gạch chân',
                    style: TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Text với theme
                  Text(
                    'Text sử dụng theme từ MaterialApp',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 2. ICON WIDGET
            // ============================================
            _buildSection(
              title: '2. Icon Widget',
              description: 'Icon widget hiển thị biểu tượng (icon)',
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  // Icon cơ bản
                  const Icon(Icons.home),

                  // Icon với màu và kích thước
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 40,
                  ),

                  // Icon với màu từ theme
                  Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.primary,
                    size: 50,
                  ),

                  // Icon với nhiều style khác nhau
                  const Icon(
                    Icons.settings,
                    color: Colors.blue,
                    size: 30,
                  ),

                  const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 35,
                  ),

                  const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 45,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 3. IMAGE WIDGET
            // ============================================
            _buildSection(
              title: '3. Image Widget',
              description:
                  'Image widget hiển thị hình ảnh từ nhiều nguồn khác nhau',
              child: Column(
                children: [
                  // Image từ AssetImage (hình ảnh trong project)
                  // Lưu ý: Cần thêm hình ảnh vào thư mục assets và khai báo trong pubspec.yaml
                  // Ở đây chúng ta dùng Container với màu để minh họa
                  Container(
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 50, color: Colors.blue),
                          SizedBox(height: 8),
                          Text('Asset Image\n(200x150)'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Giải thích cách dùng AssetImage
                  const Text(
                    'Để dùng AssetImage:\n'
                    '1. Tạo thư mục assets/images/\n'
                    '2. Thêm hình ảnh vào thư mục đó\n'
                    '3. Khai báo trong pubspec.yaml:\n'
                    '   assets:\n'
                    '     - assets/images/your_image.png\n'
                    '4. Dùng: Image.asset(\'assets/images/your_image.png\')',
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 4. ELEVATED BUTTON WIDGET
            // ============================================
            _buildSection(
              title: '4. ElevatedButton Widget',
              description:
                  'ElevatedButton là nút bấm với hiệu ứng nổi (elevated)',
              child: Column(
                children: [
                  // ElevatedButton cơ bản
                  ElevatedButton(
                    onPressed: () {
                      // onPressed được gọi khi người dùng nhấn nút
                      setState(() {
                        _buttonPressCount++;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Button đã được nhấn $_buttonPressCount lần'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text('Nhấn tôi!'),
                  ),

                  const SizedBox(height: 12),

                  // Hiển thị số lần nhấn
                  Text(
                    'Đã nhấn: $_buttonPressCount lần',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  // ElevatedButton với icon
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _buttonPressCount++;
                      });
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Button với Icon'),
                  ),

                  const SizedBox(height: 12),

                  // ElevatedButton bị vô hiệu hóa
                  const ElevatedButton(
                    onPressed: null, // null = button bị vô hiệu hóa
                    child: Text('Button bị vô hiệu hóa'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 5. GESTURE DETECTOR WIDGET
            // ============================================
            _buildSection(
              title: '5. GestureDetector Widget',
              description:
                  'GestureDetector phát hiện các cử chỉ: tap, long press, double tap, etc.',
              child: Column(
                children: [
                  // GestureDetector với onTap
                  GestureDetector(
                    onTap: () {
                      // onTap được gọi khi người dùng tap một lần
                      setState(() {
                        _tapCount++;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green, width: 2),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Tap vào đây!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Đã tap: $_tapCount lần',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  // GestureDetector với onLongPress
                  GestureDetector(
                    onLongPress: () {
                      // onLongPress được gọi khi người dùng giữ lâu
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bạn đã long press!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange, width: 2),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            'Giữ lâu vào đây!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // GestureDetector với onDoubleTap
                  GestureDetector(
                    onDoubleTap: () {
                      // onDoubleTap được gọi khi người dùng tap hai lần nhanh
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bạn đã double tap!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.touch_app, color: Colors.purple),
                          SizedBox(width: 8),
                          Text(
                            'Double tap vào đây!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 6. TEXT FIELD WIDGET
            // ============================================
            _buildSection(
              title: '6. TextField Widget',
              description: 'TextField là ô nhập văn bản từ người dùng',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TextField cơ bản
                  TextField(
                    // onChanged được gọi mỗi khi người dùng thay đổi text
                    onChanged: (value) {
                      setState(() {
                        _textFieldValue = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nhập văn bản',
                      hintText: 'Gõ gì đó vào đây...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.edit),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Hiển thị giá trị đã nhập
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Giá trị đã nhập:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _textFieldValue.isEmpty
                              ? '(chưa nhập gì)'
                              : _textFieldValue,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // TextField với nhiều tùy chọn
                  TextField(
                    maxLines: 3, // Cho phép nhiều dòng
                    decoration: const InputDecoration(
                      labelText: 'TextField nhiều dòng',
                      hintText: 'Nhập nhiều dòng văn bản...',
                      border: OutlineInputBorder(),
                      helperText: 'Có thể nhập nhiều dòng',
                    ),
                  ),

                  const SizedBox(height: 16),

                  // TextField với password
                  TextField(
                    obscureText: true, // Ẩn text (dùng cho password)
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu',
                      hintText: 'Nhập mật khẩu...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // TỔNG KẾT: WIDGET COMPOSITION
            // ============================================
            _buildSection(
              title: 'Tổng kết: Widget Composition',
              description:
                  'Widget có thể chứa widget khác - đây là cách xây dựng UI trong Flutter',
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
                      'Ví dụ về Widget Composition:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text('• Container chứa Column'),
                    Text('• Column chứa nhiều Text widgets'),
                    Text('• ElevatedButton chứa Text và Icon'),
                    Text('• GestureDetector chứa Container'),
                    Text('• Scaffold chứa AppBar, Body, và nhiều widget khác'),
                    SizedBox(height: 12),
                    Text(
                      'Tất cả đều là widget!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
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

  /// Helper method để tạo một section (phần) cho mỗi widget
  /// Đây cũng là một ví dụ về widget composition
  Widget _buildSection({
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
}
