import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/animated_sparkles_widget.dart';
import './widgets/floating_icon_widget.dart';
import './widgets/football_mascot_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainAnimationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _floatingIcons = [
    {
      'iconName': 'sports_soccer',
      'color': AppTheme.interactivePurple,
      'x': 15.0,
      'y': 20.0,
    },
    {
      'iconName': 'sports_football',
      'color': AppTheme.footballOrange,
      'x': 75.0,
      'y': 15.0,
    },
    {
      'iconName': 'emoji_events',
      'color': AppTheme.successGreen,
      'x': 10.0,
      'y': 60.0,
    },
    {
      'iconName': 'sports',
      'color': AppTheme.lightPurpleContainer,
      'x': 80.0,
      'y': 65.0,
    },
    {
      'iconName': 'sports_tennis',
      'color': AppTheme.interactivePurple,
      'x': 20.0,
      'y': 85.0,
    },
    {
      'iconName': 'flag',
      'color': AppTheme.footballOrange,
      'x': 70.0,
      'y': 88.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _mainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainAnimationController,
      curve: Curves.easeInOut,
    ));

    _mainAnimationController.forward();
  }

  Future<void> _initializeApp() async {
    // Hide system UI for immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Simulate app initialization tasks
    await Future.wait([
      _checkAuthenticationStatus(),
      _loadUserPreferences(),
      _prepareCachedData(),
    ]);

    // Wait for minimum splash duration
    await Future.delayed(const Duration(milliseconds: 2500));

    // Navigate to appropriate screen
    if (mounted) {
      _navigateToNextScreen();
    }
  }

  Future<void> _checkAuthenticationStatus() async {
    // Simulate checking authentication status
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<void> _loadUserPreferences() async {
    // Simulate loading user preferences
    await Future.delayed(const Duration(milliseconds: 600));
  }

  Future<void> _prepareCachedData() async {
    // Simulate preparing cached data
    await Future.delayed(const Duration(milliseconds: 700));
  }

  void _navigateToNextScreen() {
    // Restore system UI before navigation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Navigate with smooth transition
    Navigator.pushReplacementNamed(context, '/welcome-screen');
  }

  @override
  void dispose() {
    _mainAnimationController.dispose();
    // Ensure system UI is restored
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Stack(
                  children: [
                    // Animated sparkles background
                    const AnimatedSparklesWidget(),

                    // Floating football icons
                    ..._floatingIcons.map((iconData) {
                      return FloatingIconWidget(
                        iconName: iconData['iconName'] as String,
                        containerColor: iconData['color'] as Color,
                        initialX: (iconData['x'] as double).w,
                        initialY: (iconData['y'] as double).h,
                        animationDuration: Duration(
                          milliseconds:
                              2500 + (iconData['x'] as double).toInt() * 10,
                        ),
                      );
                    }).toList(),

                    // Central football mascot
                    const FootballMascotWidget(),

                    // App branding
                    Positioned(
                      bottom: 15.h,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            'Football Connect',
                            style: AppTheme.darkTheme.textTheme.headlineMedium
                                ?.copyWith(
                              color: AppTheme.pureWhiteText,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            width: 20.w,
                            height: 0.5.h,
                            decoration: BoxDecoration(
                              color: AppTheme.interactivePurple,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Loading indicator
                    Positioned(
                      bottom: 8.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          width: 6.w,
                          height: 6.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.interactivePurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
