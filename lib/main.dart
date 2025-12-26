import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'introduce.dart';
import 'project.dart';
import 'contact.dart';

void main() {
  runApp(const JiyoonPortfolioApp());
}

class JiyoonPortfolioApp extends StatelessWidget {
  const JiyoonPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // 디자인 기준 해상도
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Jiyoon Portfolio',
          theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
          home: const PortfolioHomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
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
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.deepPurpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  _displayedText,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D3436),
                    height: 1.6,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
          ),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        _buildSidebar(),
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
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _displayedText,
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D3436),
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
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 'home'),
          _buildNavItem(Icons.person_outline, 'introduce'),
          _buildNavItem(Icons.work_outline, 'project'),
          _buildNavItem(Icons.email_outlined, 'contact'),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(2.w, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavItem(Icons.home_outlined, 'home'),
          SizedBox(height: 40.h),
          _buildNavItem(Icons.person_outline, 'introduce'),
          SizedBox(height: 40.h),
          _buildNavItem(Icons.work_outline, 'project'),
          SizedBox(height: 40.h),
          _buildNavItem(Icons.email_outlined, 'contact'),
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
          } else if (label == 'contact') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            ).then((_) {
              // 페이지에서 돌아왔을 때 home으로 리셋
              setState(() {
                _selectedMenu = 'home';
              });
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF6C63FF).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 28.sp,
                color: isSelected
                    ? const Color(0xFF6C63FF)
                    : const Color(0xFF95A5A6),
              ),
              SizedBox(height: 6.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
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
