import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('연락처'),
        backgroundColor: const Color.fromARGB(0, 168, 168, 168),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0C3FC), // 연보라
              Color(0xFF8EC5FC), // 연파랑
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const Text(
                  //   '연락처',
                  //   style: TextStyle(
                  //     fontSize: 36,
                  //     fontWeight: FontWeight.w700,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // const SizedBox(height: 32),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.redAccent),
                    title: SelectableText(
                      '서울특별시 관악구 관악로 1 서울대학교 10-1동 401호\n(우)08826',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.deepPurple),
                    title: SelectableText('user.email'),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.link, color: Colors.blue),
                    title: SelectableText.rich(
                      TextSpan(
                        text: 'https://github.com/jiyoon-park97',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(
                              Uri.parse('https://github.com/jiyoon-park97'),
                            );
                          },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.green),
                    title: Text('user.phone'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
