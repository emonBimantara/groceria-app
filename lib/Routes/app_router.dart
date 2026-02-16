import 'package:flutter/material.dart';
import 'package:groceria/Routes/app_routes.dart';
import 'package:groceria/View/cart_page.dart';
import 'package:groceria/View/detail_page.dart';
import 'package:groceria/View/home_page.dart';
import 'package:groceria/View/onboarding_page.dart';
import 'package:groceria/View/splash_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    switch (settings.name){
      case AppRoutes.splashPage:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case AppRoutes.onboardingPage:
        return MaterialPageRoute(builder: (_) => OnboardingPage());
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.cartPage:
        return MaterialPageRoute(builder: (_) => CartPage());
      case AppRoutes.detailPage:
        return MaterialPageRoute(builder: (_) => DetailPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }
}