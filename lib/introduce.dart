import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'project.dart';
import 'contact.dart';

class IntroducePage extends StatefulWidget {
  const IntroducePage({super.key});

  @override
  State<IntroducePage> createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0; // 0: 소개, 1: 관심분야, 2: 걸어온길, 3: 기술
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleScroll(PointerScrollEvent event) {
    if (_isScrolling) return;

    if (event.scrollDelta.dy > 0) {
      // 아래로 스크롤
      if (_currentSection < 3) {
        _scrollToSection(_currentSection + 1);
      }
    } else if (event.scrollDelta.dy < 0) {
      // 위로 스크롤
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
                        // 섹션 0: 소개
                        _buildSection(
                          screenHeight,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              child: Text(
                                '언어를 기반으로\n사람과 컴퓨터를 연결하는\n연구자가 되고 싶은\n박지윤입니다',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3436),
                                  height: 1.6,
                                  letterSpacing: -0.5,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),

                        // 섹션 1: 관심 분야
                        _buildSection(
                          screenHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '주요 관심 분야',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6C63FF),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                _buildInterestItem(
                                  Icons.psychology,
                                  'AI',
                                  Colors.blue,
                                  '인공지능을 활용하여 사람에게 생기는 문제들을 해결하는데 관심을 가지고 있습니다.',
                                ),
                                const SizedBox(height: 20),
                                _buildInterestItem(
                                  Icons.abc,
                                  '자연어처리',
                                  Colors.green,
                                  '어떻게 하면 컴퓨터가 인간의 언어를 이해하고 처리할 수 있을지 연구합니다.',
                                ),
                                const SizedBox(height: 20),
                                _buildInterestItem(
                                  Icons.menu_book,
                                  '교육',
                                  Colors.orange,
                                  '인공지능을 활용한 학습자 지원과 시스템 개발에 관심이 많습니다.',
                                ),
                                const SizedBox(height: 20),
                                _buildInterestItem(
                                  Icons.translate,
                                  '언어',
                                  Colors.purple,
                                  '언어 중에서도 한국어를 컴퓨터가 어떻게 잘 이해할 수 있을지에 대해 관심이 많습니다.',
                                ),
                                const SizedBox(height: 20),
                                _buildInterestItem(
                                  Icons.people,
                                  'HCI',
                                  Colors.red,
                                  '사람과 컴퓨터의 원활한 상호작용에 대해 관심이 많습니다.',
                                ),
                                const SizedBox(height: 40),
                                Text(
                                  '언어와 교육은 누구나 사용하는 것입니다.\n이처럼 누구나 배우고 사용하는 언어와 교육을\nAI에 접목하여 사람과 컴퓨터의 상호작용을 원활하게 하는 연구에 관심이 많습니다.',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF2D3436),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 섹션 2: 걸어온 길
                        _buildSection(
                          screenHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Row(
                              children: [
                                // 왼쪽에 이미지 슬라이더
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildImageSlider(),
                                      const SizedBox(height: 20),
                                      const Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF2D3436),
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 60),

                                // 오른쪽에 걸어온 길
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '걸어온 길',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6C63FF),
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      _buildTimelineItem(
                                        '서울대학교 학습과학연구소 연구원',
                                        '2025~',
                                      ),
                                      _buildTimelineItem(
                                        '연세대학교 일반대학원 언어정보학협동과정 정보학석사',
                                        '2022~2025',
                                      ),
                                      _buildTimelineItem(
                                        '인천대학교 국어교육과 문학사',
                                        '2020~2022',
                                      ),
                                      _buildTimelineItem(
                                        '상명대학교 한국언어문화학과',
                                        '2017~2019',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 섹션 3: 기술
                        _buildSection(
                          screenHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '기술',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6C63FF),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                _buildSkillItem('Flutter', 3.0),
                                const SizedBox(height: 20),
                                _buildSkillItem('Python', 3.5),
                                const SizedBox(height: 20),
                                const Text(''),
                              ],
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
    return SizedBox(
      height: height,
      child: Center(child: child),
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
          _buildNavItem(
            context,
            Icons.person_outline,
            'introduce',
            isSelected: true,
          ),
          const SizedBox(height: 40),
          _buildNavItem(context, Icons.work_outline, 'project'),
          const SizedBox(height: 40),
          _buildNavItem(context, Icons.email_outlined, 'contact'),
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
            Navigator.pop(context);
          } else if (label == 'project') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectPage()),
            );
          } else if (label == 'contact') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactPage()),
            );
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

  Widget _buildInterestItem(
    IconData icon,
    String text,
    Color color,
    String description,
  ) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 28, color: color),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                ],
              ),
              if (isHovered)
                Positioned(
                  left: 200, // 오른쪽으로 이동
                  top: 0, // 같은 높이에 배치
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimelineItem(String title, String period) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Color(0xFF6C63FF),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  period,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF95A5A6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(String skill, double rating) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            skill,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D3436),
            ),
          ),
        ),
        const SizedBox(width: 20),
        ...List.generate(5, (index) {
          if (index < rating.floor()) {
            return const Icon(Icons.star, size: 24, color: Color(0xFFFFA500));
          } else if (index < rating && rating % 1 != 0) {
            return const Icon(
              Icons.star_half,
              size: 24,
              color: Color(0xFFFFA500),
            );
          } else {
            return const Icon(
              Icons.star_border,
              size: 24,
              color: Color(0xFFBDC3C7),
            );
          }
        }),
      ],
    );
  }

  Widget _buildImageSlider() {
    return const _ImageSlider();
  }
}

class _ImageSlider extends StatefulWidget {
  const _ImageSlider();

  @override
  State<_ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<_ImageSlider> {
  int _currentImageIndex = 0;
  final List<String> _images = [
    'images/incheonuniv.jpg',
    'images/yonseiuniv.jpg',
  ];

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _images.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + _images.length) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              _images[_currentImageIndex],
              height: 400,
              width: double.infinity,
              fit: BoxFit.contain, // cover에서 contain으로 변경
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(Icons.image, size: 80, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          // 왼쪽 버튼
          Positioned(
            left: 16,
            child: IconButton(
              onPressed: _previousImage,
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // 오른쪽 버튼
          Positioned(
            right: 16,
            child: IconButton(
              onPressed: _nextImage,
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // 인디케이터
          Positioned(
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
