import 'package:flutter/material.dart';
import 'dart:async';
import 'introduce.dart';
import 'project.dart';

void main() {
  runApp(const JiyoonPortfolioApp());
}

class JiyoonPortfolioApp extends StatelessWidget {
  const JiyoonPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jiyoon Portfolio',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PortfolioHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  String _displayedText = '';
  final String _fullText = '언어를\n이해하고\n기술을\n사람에게 가까이 가져오는\n연구자';
  int _currentIndex = 0;
  Timer? _timer;
  String _selectedMenu = 'home';

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentIndex < _fullText.length) {
        setState(() {
          _displayedText += _fullText[_currentIndex];
          _currentIndex++;
        });
      } else {
        timer.cancel();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _displayedText = '';
            _currentIndex = 0;
          });
          _startTypingAnimation();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 왼쪽 사이드바
          Container(
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
                _buildNavItem(Icons.home_outlined, 'home'),
                const SizedBox(height: 40),
                _buildNavItem(Icons.person_outline, 'introduce'),
                const SizedBox(height: 40),
                _buildNavItem(Icons.work_outline, 'project'),
                const SizedBox(height: 40),
                _buildNavItem(Icons.email_outlined, 'contact'),
              ],
            ),
          ),
          // 오른쪽 메인 영역
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.deepPurpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _displayedText,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D3436),
                        height: 1.6,
                        letterSpacing: -0.5,
                      ),
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

  Widget _buildNavItem(IconData icon, String label) {
    final isSelected = _selectedMenu == label;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedMenu = label;
          });

          // 페이지 이동 추가
          if (label == 'introduce') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const IntroducePage()),
            ).then((_) {
              // 페이지에서 돌아왔을 때 home으로 리셋
              setState(() {
                _selectedMenu = 'home';
              });
            });
          } else if (label == 'project') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectPage()),
            ).then((_) {
              // 페이지에서 돌아왔을 때 home으로 리셋
              setState(() {
                _selectedMenu = 'home';
              });
            });
          }
          // contact 페이지도 나중에 추가 가능
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
