import 'package:flutter/material.dart';

/// Hàm main là điểm khởi đầu của ứng dụng Flutter
/// runApp() khởi chạy ứng dụng với widget gốc (root widget)
void main() {
  runApp(const MyApp());
}

/// ============================================
/// MYAPP - Widget gốc với Theme Management
/// ============================================
///
/// MyApp quản lý theme cho toàn bộ ứng dụng
///
/// TẠI SAO KHÔNG HARD-CODE STYLES?
/// 1. Khó bảo trì: Phải thay đổi ở nhiều nơi
/// 2. Không nhất quán: Dễ tạo ra styles khác nhau
/// 3. Không hỗ trợ dark mode: Phải viết lại code
/// 4. Khó tùy chỉnh: Người dùng không thể thay đổi theme
///
/// SỬ DỤNG THEME:
/// 1. Tập trung quản lý: Tất cả styles ở một nơi
/// 2. Nhất quán: Tất cả widget dùng cùng theme
/// 3. Hỗ trợ dark mode: Dễ dàng thêm dark theme
/// 4. Dễ tùy chỉnh: Thay đổi theme một lần, áp dụng toàn bộ
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ThemeMode hiện tại (system, light, dark)
  ThemeMode _themeMode = ThemeMode.system;

  /// Chuyển đổi theme mode
  void _toggleTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Training - Theme & Styling',

      // ============================================
      // LIGHT THEME - Theme sáng
      // ============================================
      //
      // ThemeData định nghĩa giao diện cho light mode
      // Bao gồm: màu sắc, kiểu chữ, button styles, etc.
      theme: ThemeData(
        // ColorScheme định nghĩa bảng màu cho ứng dụng
        // fromSeed tạo bảng màu từ một màu seed
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Màu chủ đạo
          brightness: Brightness.light, // Chế độ sáng
        ),

        // useMaterial3: Sử dụng Material Design 3
        useMaterial3: true,

        // TextTheme định nghĩa kiểu chữ cho các loại text
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),

        // ElevatedButtonTheme định nghĩa style cho ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // CardTheme định nghĩa style cho Card
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // ============================================
      // DARK THEME - Theme tối
      // ============================================
      //
      // darkTheme định nghĩa giao diện cho dark mode
      // Tự động được sử dụng khi hệ thống ở chế độ dark
      darkTheme: ThemeData(
        // ColorScheme cho dark mode
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark, // Chế độ tối
        ),

        useMaterial3: true,

        // TextTheme cho dark mode (có thể khác với light mode)
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),

        // ElevatedButtonTheme cho dark mode
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // CardTheme cho dark mode
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // themeMode: Quyết định sử dụng theme nào
      // ThemeMode.system: Theo hệ thống
      // ThemeMode.light: Luôn dùng light theme
      // ThemeMode.dark: Luôn dùng dark theme
      themeMode: _themeMode,

      // Màn hình chính của ứng dụng
      // Truyền callback để chuyển đổi theme
      home: ThemeAndStylingDemo(onThemeChanged: _toggleTheme),
    );
  }
}

/// ============================================
/// THEME AND STYLING DEMO
/// ============================================
///
/// Màn hình này minh họa:
/// - Cách sử dụng Theme.of(context)
/// - ColorScheme và các màu từ theme
/// - TextTheme và các kiểu chữ từ theme
/// - Button styling qua theme
/// - Chuyển đổi giữa light và dark theme
///
/// TẠI SAO DÙNG Theme.of(context)?
/// 1. Tự động thay đổi khi theme thay đổi
/// 2. Hỗ trợ dark mode tự động
/// 3. Nhất quán với theme của ứng dụng
/// 4. Dễ bảo trì và tùy chỉnh
class ThemeAndStylingDemo extends StatelessWidget {
  // Callback để chuyển đổi theme (từ MyApp)
  final Function(ThemeMode) onThemeChanged;

  const ThemeAndStylingDemo({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme & Styling Demo'),
        // backgroundColor tự động lấy từ theme
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Actions để chuyển đổi theme
        actions: [
          // Nút chuyển sang light theme
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () => onThemeChanged(ThemeMode.light),
            tooltip: 'Light Theme',
          ),
          // Nút chuyển sang dark theme
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () => onThemeChanged(ThemeMode.dark),
            tooltip: 'Dark Theme',
          ),
          // Nút chuyển sang system theme
          IconButton(
            icon: const Icon(Icons.brightness_auto),
            onPressed: () => onThemeChanged(ThemeMode.system),
            tooltip: 'System Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ============================================
            // 1. COLORSCHEME - Bảng màu từ theme
            // ============================================
            _buildSection(
              context: context,
              title: '1. ColorScheme - Bảng màu',
              description:
                  'ColorScheme cung cấp bảng màu nhất quán cho ứng dụng',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Primary color
                  _buildColorCard(
                    context: context,
                    label: 'Primary',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  // Secondary color
                  _buildColorCard(
                    context: context,
                    label: 'Secondary',
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 8),
                  // Tertiary color
                  _buildColorCard(
                    context: context,
                    label: 'Tertiary',
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(height: 8),
                  // Error color
                  _buildColorCard(
                    context: context,
                    label: 'Error',
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 8),
                  // Surface color
                  _buildColorCard(
                    context: context,
                    label: 'Surface',
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  const SizedBox(height: 8),
                  // Background color
                  _buildColorCard(
                    context: context,
                    label: 'Background',
                    color: Theme.of(context).colorScheme.background,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 2. TEXT THEME - Kiểu chữ từ theme
            // ============================================
            _buildSection(
              context: context,
              title: '2. TextTheme - Kiểu chữ',
              description: 'TextTheme cung cấp các kiểu chữ nhất quán',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Large
                  Text(
                    'Display Large',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  // Headline Medium
                  Text(
                    'Headline Medium',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  // Title Large
                  Text(
                    'Title Large',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  // Body Large
                  Text(
                    'Body Large - Đây là văn bản body với kiểu chữ từ theme.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  // Body Medium
                  Text(
                    'Body Medium - Văn bản body medium từ theme.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  // Body Small
                  Text(
                    'Body Small - Văn bản nhỏ từ theme.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 3. BUTTON STYLING - Style button từ theme
            // ============================================
            _buildSection(
              context: context,
              title: '3. Button Styling - Style từ theme',
              description: 'Buttons tự động sử dụng style từ theme',
              child: Column(
                children: [
                  // ElevatedButton - Tự động dùng style từ theme
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('ElevatedButton'),
                  ),
                  const SizedBox(height: 12),
                  // ElevatedButton với icon
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('ElevatedButton với Icon'),
                  ),
                  const SizedBox(height: 12),
                  // OutlinedButton
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('OutlinedButton'),
                  ),
                  const SizedBox(height: 12),
                  // TextButton
                  TextButton(
                    onPressed: () {},
                    child: const Text('TextButton'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 4. CARD STYLING - Style card từ theme
            // ============================================
            _buildSection(
              context: context,
              title: '4. Card Styling - Style từ theme',
              description: 'Card tự động sử dụng style từ theme',
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card với theme',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Card này tự động sử dụng elevation và shape từ theme.',
                            style: Theme.of(context).textTheme.bodyMedium,
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
            // 5. SO SÁNH: Hard-code vs Theme
            // ============================================
            _buildSection(
              context: context,
              title: '5. So sánh: Hard-code vs Theme',
              description: 'Tại sao không nên hard-code styles?',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hard-code style (SAI)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue, // Hard-code màu
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Hard-code style (SAI)',
                      style: TextStyle(
                        color: Colors.white, // Hard-code màu
                        fontSize: 16, // Hard-code kích thước
                        fontWeight: FontWeight.bold, // Hard-code weight
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Theme style (ĐÚNG)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary, // Từ theme
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Theme style (ĐÚNG)',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary, // Từ theme
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Lợi ích của Theme:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Tự động thay đổi khi theme thay đổi'),
                  const Text('• Hỗ trợ dark mode tự động'),
                  const Text('• Nhất quán trong toàn bộ ứng dụng'),
                  const Text('• Dễ bảo trì và tùy chỉnh'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ============================================
            // 6. THEME.OF(CONTEXT) - Lấy theme từ context
            // ============================================
            _buildSection(
              context: context,
              title: '6. Theme.of(context) - Lấy theme',
              description: 'Cách lấy theme từ BuildContext',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cách sử dụng Theme.of(context):',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Theme.of(context).colorScheme.primary'),
                  const Text('• Theme.of(context).textTheme.bodyLarge'),
                  const Text('• Theme.of(context).elevatedButtonTheme'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ví dụ:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Màu primary: ${Theme.of(context).colorScheme.primary}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Brightness: ${Theme.of(context).brightness}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method để tạo một section
  Widget _buildSection({
    required BuildContext context,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  /// Helper method để tạo color card
  Widget _buildColorCard({
    required BuildContext context,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: _getContrastColor(color),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Text(
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: _getContrastColor(color),
                ),
          ),
        ],
      ),
    );
  }

  /// Lấy màu tương phản (trắng hoặc đen) dựa trên độ sáng
  Color _getContrastColor(Color color) {
    // Tính độ sáng của màu
    final brightness = color.computeLuminance();
    // Nếu màu sáng, dùng đen; nếu màu tối, dùng trắng
    return brightness > 0.5 ? Colors.black : Colors.white;
  }
}
