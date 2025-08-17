import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/account_registration_screen/account_registration_screen.dart';
import '../presentation/welcome_screen/welcome_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splash = '/splash-screen';
  static const String userProfile = '/user-profile-screen';
  static const String login = '/login-screen';
  static const String accountRegistration = '/account-registration-screen';
  static const String welcome = '/welcome-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    userProfile: (context) => const UserProfileScreen(),
    login: (context) => const LoginScreen(),
    accountRegistration: (context) => const AccountRegistrationScreen(),
    welcome: (context) => const WelcomeScreen(),
    // TODO: Add your other routes here
  };
}
