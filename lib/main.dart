import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceria/Controller/cart_controller.dart';
import 'package:groceria/View/cart_page.dart';
import 'package:groceria/View/detail_page.dart';
import 'package:groceria/View/home_page.dart';
import 'package:groceria/View/onboarding_page.dart';
import 'package:groceria/View/splash_page.dart';
import 'package:groceria/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(CartController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groceria',
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashPage()),
        GetPage(name: '/onboarding', page: () => OnboardingPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/cart', page: () => CartPage()),
        GetPage(name: '/detail', page: () => DetailPage()),
      ],
    );
  }
}
