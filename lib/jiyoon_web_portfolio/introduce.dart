import 'package:flutter/material.dart';

class IntroduceSection extends StatelessWidget {
  const IntroduceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFD1C4E9), // 연한 보라
            Color(0xFFBBDEFB), // 연한 파랑
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '저는 AI와 에듀테크에 관심이 많습니다.\n'
                '초중등교육을 넘어 고등교육에도 도움이 되는 AI 기반 교육 도구를 만들고 싶습니다.\n\n'
                '주요 관심 분야는 AI, 자연어처리, 교육공학입니다.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              // 각 분야별 아이콘을 오른쪽에 배치
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Icon(Icons.psychology, size: 32, color: Colors.blue),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Icon(Icons.abc, size: 32, color: Colors.green),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Icon(
                      Icons.menu_book,
                      size: 32,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                '걸어온 길',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              // 학력 내용 예시
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '서울대학교 학습과학연구소 행정직원 (2025~)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '연세대학교 일반대학원 언어정보학협동과정 정보학석사 (2022~2025)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '인천대학교 국어교육과 문학사 (2020~2022)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '상명대학교 한국언어문화학과 (2017~2019)',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                '기술',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Text('• Flutter', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Color.fromARGB(255, 214, 162, 4),
                      ), // 난이도(별)
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Color.fromARGB(255, 214, 162, 4),
                      ),
                      Icon(
                        Icons.star_half,
                        size: 16,
                        color: Color.fromARGB(255, 214, 162, 4),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('• Python', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 8),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Color.fromARGB(255, 214, 162, 4),
                      ), // 난이도(별)
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Color.fromARGB(255, 214, 162, 4),
                      ),
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Color.fromARGB(255, 214, 162, 4),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
