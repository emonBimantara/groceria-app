import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:groceria/Utils/onboard_content.dart';
import 'package:groceria/View/home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0;

  void _next() {
    if (_currentIndex < contents.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Get.offAll(() => HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A4B3C),
      body: Column(
        children: [
          SizedBox(height: 50),

          Expanded(
            child: AnimatedSwitcher(  
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                contents[_currentIndex].image,
                key: ValueKey(contents[_currentIndex].image),
                width: double.infinity,
              ),
            ),
          ),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(65),
                topRight: Radius.circular(65),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 30,
                right: 30,
                bottom: 10,
              ),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      contents[_currentIndex].title,
                      key: ValueKey(contents[_currentIndex].title),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 10),

                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: Text(
                      contents[_currentIndex].description,
                      key: ValueKey(contents[_currentIndex].description),
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 20),

                  GestureDetector(
                    onTap: _next,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF1A4B3C),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
