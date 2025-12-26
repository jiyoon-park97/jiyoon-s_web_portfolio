import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleScroll(PointerScrollEvent event) {
    if (_isScrolling) return;

    if (event.scrollDelta.dy > 0) {
      // 아래로 스크롤
      if (_currentSection < 4) {
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
                        // 섹션 0: 프로젝트 소개
                        _buildSection(
                          screenHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '프로젝트',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3436),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '진행했던 프로젝트들을 소개합니다.',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF636E72),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 섹션 1: 프로젝트 1
                        _buildSection(
                          screenHeight,
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 왼쪽: 프로젝트 이미지
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        'images/workitalki.png', // 이미지 경로
                                        height: 400,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                height: 400,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 80,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 60),
                                  // 오른쪽: 프로젝트 설명
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min, // 이 부분 추가
                                      children: [
                                        const Text(
                                          '고용노동복지챗봇 제작 프로젝트',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF6C63FF),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          '2024.04 - 2025.01',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF95A5A6),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        const Text(
                                          '사회복지대학원 학생들과 협업하여 고용노동복지챗봇을 제작하였습니다.\n이 챗봇은 단비AI를 활용하여 시나리오형 챗봇을 구현하였습니다.\n이 챗봇은 사용자에게 적절한 고용 노동 복지를 제공하는데에 목적을 두고 있습니다.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF2D3436),
                                            height: 1.6,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        // 논문 링크 추가
                                        InkWell(
                                          onTap: () async {
                                            final Uri url = Uri.parse(
                                              'https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE12045709',
                                            ); // 실제 논문 링크로 변경
                                            if (await canLaunchUrl(url)) {
                                              await launchUrl(
                                                url,
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.article,
                                                size: 20,
                                                color: Color(0xFF6C63FF),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                '학술지 논문 보기',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF6C63FF),
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            _buildTag('workflow'),
                                            _buildTag('Chatbot'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 섹션 2: 프로젝트 2
                        _buildSection(
                          screenHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, // 추가
                              children: [
                                // 왼쪽: 프로젝트 설명
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center, // 추가
                                    children: [
                                      const Text(
                                        'LLM 기반 고용 노동 복지 챗봇 개발',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6C63FF),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        '2024.12-2025.06',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF95A5A6),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        '앞서서 제작한 고용노동복지챗봇은 시나리오 기반이었다면, 이번에는 LLM을 활용하여 고용노동복지 챗봇을 개발하였습니다.\nLLM의 할루시네이션을 방지하기 위해 앞선 프로젝트에서 쓴 논문을 RAG 하여 할루시네이션을 줄였습니다.\n이를 통해 사용자 맞춤형 챗봇 서비스를 제공할 수 있습니다.',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF2D3436),
                                          height: 1.6,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          _buildTag('NLP'),
                                          _buildTag('LLM'),
                                          _buildTag('Chatbot'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 60),
                                // 오른쪽: 프로젝트 이미지
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      'images/workitalki_chatbot.jpg', // 이미지 경로
                                      height: 700,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              height: 700,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(
                                                  0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 80,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 섹션 3: 프로젝트 3
                        _buildSection(
                          screenHeight,
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 왼쪽: 프로젝트 이미지
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        'images/thesis.jpg',
                                        height: 400,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                height: 400,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 80,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 60),
                                  // 오른쪽: 프로젝트 설명
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          '생성형 AI의 의사-환자 대화 이해 능력 평가를 위한 \n개체명 인식 벤치마크 데이터 구축 및 평가 연구 ',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF6C63FF),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          '2024.01 - 2024.12',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF95A5A6),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        const Text(
                                          '석사 학위 논문으로, 의사-환자 대화라는 전문적인 상황에서 \n생성형 AI가 얼마나 개체명 인식을 잘 해내는지 평가하는 연구를 진행하였습니다.',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF2D3436),
                                            height: 1.6,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        // 학위 논문 링크 추가
                                        InkWell(
                                          onTap: () async {
                                            final Uri url = Uri.parse(
                                              'https://www.riss.kr/search/detail/DetailView.do?p_mat_type=be54d9b8bc7cdb09&control_no=61d882e4274a7dcdffe0bdc3ef48d419&keyword=%EB%B0%95%EC%A7%80%EC%9C%A4%20%EC%9D%98%EC%82%AC-%ED%99%98%EC%9E%90',
                                            ); // 실제 논문 링크로 변경
                                            if (await canLaunchUrl(url)) {
                                              await launchUrl(
                                                url,
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.article,
                                                size: 20,
                                                color: Color(0xFF6C63FF),
                                              ),
                                              const SizedBox(width: 8),
                                              const Text(
                                                '학위 논문 보기',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF6C63FF),
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            _buildTag('LLM'),
                                            _buildTag('Conversation'),
                                            _buildTag('NLP'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // 섹션 4: 프로젝트 4
                        _buildSection(
                          screenHeight,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // 왼쪽: 프로젝트 설명
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'GPT-사람, 사람-사람 토론 비교 연구',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF6C63FF),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        '2025.08 - 2025.12',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF95A5A6),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        '사람과 사람, 사람과 GPT가 토론할 때의 차이점을 분석하는 연구입니다.',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF2D3436),
                                          height: 1.6,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          _buildTag('LLM'),
                                          _buildTag('HCI'),
                                          _buildTag('conversation'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 60),
                                // 오른쪽: 프로젝트 이미지
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      'images/gpt_conversation.png',
                                      height: 400,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              height: 400,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withOpacity(
                                                  0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.image,
                                                  size: 80,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
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
      child: child, // Center 제거
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF6C63FF),
          fontWeight: FontWeight.w500,
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
          _buildNavItem(
            context,
            Icons.work_outline,
            'project',
            isSelected: true,
          ),
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
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (label == 'introduce') {
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
