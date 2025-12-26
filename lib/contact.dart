import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;
  bool _isScrolling = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _handleScroll(PointerScrollEvent event) {
    if (_isScrolling) return;

    if (event.scrollDelta.dy > 0) {
      if (_currentSection < 1) {
        _scrollToSection(_currentSection + 1);
      }
    } else if (event.scrollDelta.dy < 0) {
      if (_currentSection > 0) {
        _scrollToSection(_currentSection - 1);
      }
    }
  }

  void _scrollToSection(int section) {
    if (_isScrolling) return;

    setState(() {
      _isScrolling = true;
      _currentSection = section;
    });

    final screenHeight = MediaQuery.of(context).size.height;
    _scrollController
        .animateTo(
          section * screenHeight,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        )
        .then((_) {
          setState(() {
            _isScrolling = false;
          });
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(context),
          Expanded(
            child: Listener(
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  _handleScroll(event);
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0xFFF5F5FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // 섹션 0: 연락처 정보
                        _buildSection(
                          screenHeight,
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '연락처',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3436),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    '언제든지 연락 주세요!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF636E72),
                                    ),
                                  ),
                                  const SizedBox(height: 60),
                                  _buildContactItem(
                                    context,
                                    Icons.phone,
                                    '전화번호',
                                    '010-9390-5081',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 섹션 1: 이메일 보내기
                        _buildSection(
                          screenHeight,
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    '이메일 보내기',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3436),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    '메시지를 남겨주시면 빠르게 답변드리겠습니다.',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF636E72),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const SelectableText(
                                    'pjy3065081@yonsei.ac.kr',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF6C63FF),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 60),
                                  _buildEmailForm(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(double height, Widget child) {
    return SizedBox(height: height, child: child);
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: const Color(0xFF6C63FF)),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF95A5A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2D3436),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.copy, size: 20),
            color: const Color(0xFF6C63FF),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$label가 클립보드에 복사되었습니다.'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: const Color(0xFF6C63FF),
                ),
              );
            },
            tooltip: '복사',
          ),
        ],
      ),
    );
  }

  Widget _buildEmailForm(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            label: '이름',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _emailController,
            label: '이메일',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _messageController,
            label: '메시지',
            icon: Icons.message_outlined,
            minLines: 5,
            maxLines: 10,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                final email = _emailController.text.trim();
                final message = _messageController.text.trim();

                if (name.isEmpty || email.isEmpty || message.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('모든 필드를 입력해주세요.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // EmailJS를 사용한 이메일 전송
                // https://www.emailjs.com/ 에서 계정 생성 후 아래 값들을 설정하세요
                try {
                  final response = await http.post(
                    Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode({
                      'service_id': 'service_14lw6u6',
                      'template_id': 'template_d213cji',
                      'user_id': 'u37YhvTEB623WFInj',
                      'template_params': {
                        'from_name': name,
                        'from_email': email,
                        'message': message,
                        'to_email': 'pjy3065081@yonsei.ac.kr',
                      },
                    }),
                  );

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('메시지가 성공적으로 전송되었습니다!'),
                        backgroundColor: Color(0xFF6C63FF),
                      ),
                    );
                    _nameController.clear();
                    _emailController.clear();
                    _messageController.clear();
                  } else {
                    throw Exception('Failed to send email');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('이메일 전송에 실패했습니다. 다시 시도해주세요.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '보내기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int minLines = 1,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF6C63FF)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem(context, Icons.home_outlined, 'home'),
          const SizedBox(height: 40),
          _buildNavItem(context, Icons.person_outline, 'introduce'),
          const SizedBox(height: 40),
          _buildNavItem(context, Icons.work_outline, 'project'),
          const SizedBox(height: 40),
          _buildNavItem(
            context,
            Icons.email_outlined,
            'contact',
            isSelected: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label, {
    bool isSelected = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (label == 'home') {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (label == 'introduce' || label == 'project') {
            Navigator.pop(context);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6C63FF).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28,
                color: isSelected
                    ? const Color(0xFF6C63FF)
                    : const Color(0xFF95A5A6),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? const Color(0xFF6C63FF)
                      : const Color(0xFF95A5A6),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
