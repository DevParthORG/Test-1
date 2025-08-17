import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/floating_icon_widget.dart';
import './widgets/football_mascot_widget.dart';
import './widgets/sparkle_painter.dart';
import './widgets/terms_checkbox_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _sparkleController;
  late List<SparkleParticle> _sparkleParticles;
  bool _isTermsAccepted = false;

  final List<Map<String, dynamic>> _floatingIcons = [
    {
      'iconName': 'sports_football',
      'backgroundColor': AppTheme.interactivePurple,
      'startOffset': const Offset(-20, -30),
      'endOffset': const Offset(20, 30),
    },
    {
      'iconName': 'sports_soccer',
      'backgroundColor': AppTheme.footballOrange,
      'startOffset': const Offset(25, -20),
      'endOffset': const Offset(-25, 20),
    },
    {
      'iconName': 'sports',
      'backgroundColor': AppTheme.successGreen,
      'startOffset': const Offset(-30, 25),
      'endOffset': const Offset(30, -25),
    },
    {
      'iconName': 'emoji_events',
      'backgroundColor': AppTheme.lightPurpleContainer,
      'startOffset': const Offset(20, 30),
      'endOffset': const Offset(-20, -30),
    },
    {
      'iconName': 'sports_handball',
      'backgroundColor': AppTheme.warningAmber,
      'startOffset': const Offset(-25, -25),
      'endOffset': const Offset(25, 25),
    },
    {
      'iconName': 'flag',
      'backgroundColor': AppTheme.interactivePurple,
      'startOffset': const Offset(30, -15),
      'endOffset': const Offset(-30, 15),
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateSparkleParticles();
  }

  void _initializeAnimations() {
    _sparkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _sparkleController.repeat();
  }

  void _generateSparkleParticles() {
    final random = math.Random();
    _sparkleParticles = List.generate(15, (index) {
      return SparkleParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        phase: random.nextDouble() * 2 * math.pi,
        rotation: random.nextDouble() * 2 * math.pi,
      );
    });
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() {
    if (_isTermsAccepted) {
      HapticFeedback.lightImpact();
      Navigator.pushNamed(context, '/account-registration-screen');
    }
  }

  void _handleAlreadyHaveAccount() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/login-screen');
  }

  void _handleTermsChanged(bool? value) {
    setState(() {
      _isTermsAccepted = value ?? false;
    });
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Sparkle animation background
            Positioned.fill(
              child: CustomPaint(
                painter: SparklePainter(
                  animation: _sparkleController,
                  particles: _sparkleParticles,
                ),
              ),
            ),

            // Floating icons positioned around the screen
            ..._buildFloatingIcons(),

            // Main content
            Positioned.fill(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 100.h - MediaQuery.of(context).padding.top,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),

                        // Central football mascot
                        const FootballMascotWidget(),

                        SizedBox(height: 6.h),

                        // Welcome text
                        Text(
                          'Welcome to Football Connect',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.pureWhiteText,
                            height: 1.2,
                          ),
                        ),

                        SizedBox(height: 3.h),

                        // Subtitle text
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            'Join the ultimate football community. Create your profile or import your existing data to get started.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color:
                                  AppTheme.pureWhiteText.withValues(alpha: 0.8),
                              height: 1.4,
                            ),
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Terms checkbox
                        TermsCheckboxWidget(
                          isChecked: _isTermsAccepted,
                          onChanged: _handleTermsChanged,
                        ),

                        SizedBox(height: 4.h),

                        // Action buttons
                        ActionButtonsWidget(
                          isTermsAccepted: _isTermsAccepted,
                          onCreateAccount: _handleCreateAccount,
                          onAlreadyHaveAccount: _handleAlreadyHaveAccount,
                        ),

                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFloatingIcons() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return _floatingIcons.asMap().entries.map((entry) {
      final index = entry.key;
      final iconData = entry.value;

      // Position icons around the screen edges
      double left = 0;
      double top = 0;

      switch (index) {
        case 0: // Top left
          left = 5.w;
          top = 15.h;
          break;
        case 1: // Top right
          left = screenWidth - 20.w;
          top = 12.h;
          break;
        case 2: // Middle left
          left = 2.w;
          top = 35.h;
          break;
        case 3: // Middle right
          left = screenWidth - 18.w;
          top = 40.h;
          break;
        case 4: // Bottom left
          left = 8.w;
          top = screenHeight - 25.h;
          break;
        case 5: // Bottom right
          left = screenWidth - 22.w;
          top = screenHeight - 20.h;
          break;
      }

      return Positioned(
        left: left,
        top: top,
        child: FloatingIconWidget(
          iconName: iconData['iconName'] as String,
          backgroundColor: iconData['backgroundColor'] as Color,
          size: 15.w,
          animationDuration: Duration(seconds: 3 + (index % 2)),
          startOffset: iconData['startOffset'] as Offset,
          endOffset: iconData['endOffset'] as Offset,
        ),
      );
    }).toList();
  }
}