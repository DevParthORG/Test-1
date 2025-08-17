import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/football_logo_widget.dart';
import './widgets/registration_form_widget.dart';
import './widgets/terms_agreement_widget.dart';

class AccountRegistrationScreen extends StatefulWidget {
  const AccountRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<AccountRegistrationScreen> createState() =>
      _AccountRegistrationScreenState();
}

class _AccountRegistrationScreenState extends State<AccountRegistrationScreen> {
  bool _isLoading = false;
  bool _isTermsAgreed = false;
  final ScrollController _scrollController = ScrollController();

  // Mock user data for demonstration
  final List<Map<String, dynamic>> existingUsers = [
    {
      "email": "john.doe@example.com",
      "username": "johndoe",
      "fullName": "John Doe",
    },
    {
      "email": "sarah.wilson@example.com",
      "username": "sarahw",
      "fullName": "Sarah Wilson",
    },
    {
      "email": "mike.johnson@example.com",
      "username": "mikej",
      "fullName": "Mike Johnson",
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleRegistration(
      String fullName, String email, String username, String password) async {
    if (!_isTermsAgreed) {
      _showErrorMessage(
          'Please agree to the Terms of Service and Privacy Policy');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Check for existing email
    final emailExists = (existingUsers as List).any(
        (dynamic user) => (user as Map<String, dynamic>)["email"] == email);

    if (emailExists) {
      setState(() {
        _isLoading = false;
      });
      _showErrorMessage('An account with this email already exists');
      return;
    }

    // Check for existing username
    final usernameExists = (existingUsers as List).any((dynamic user) =>
        (user as Map<String, dynamic>)["username"] == username);

    if (usernameExists) {
      setState(() {
        _isLoading = false;
      });
      _showErrorMessage('This username is already taken');
      return;
    }

    // Simulate network error (10% chance)
    if (DateTime.now().millisecond % 10 == 0) {
      setState(() {
        _isLoading = false;
      });
      _showErrorMessage(
          'Network error. Please check your connection and try again.');
      return;
    }

    // Success
    setState(() {
      _isLoading = false;
    });

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Account created successfully! Welcome to Football Connect, $fullName!',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.pureWhiteText,
          ),
        ),
        backgroundColor: AppTheme.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    // Navigate to user profile screen after delay
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/user-profile-screen');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.pureWhiteText,
          ),
        ),
        backgroundColor: AppTheme.errorRed,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 4.h),

                  // Back Button
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceGray.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomIconWidget(
                            iconName: 'arrow_back_ios',
                            color: AppTheme.pureWhiteText,
                            size: 5.w,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  // Football Connect Logo
                  const FootballLogoWidget(),

                  SizedBox(height: 4.h),

                  // Create Account Header
                  Text(
                    'Create Account',
                    style: AppTheme.darkTheme.textTheme.headlineLarge?.copyWith(
                      color: AppTheme.pureWhiteText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  Text(
                    'Join thousands of football fans worldwide',
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.pureWhiteText.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 4.h),

                  // Registration Form
                  RegistrationFormWidget(
                    onFormSubmit: _handleRegistration,
                    isLoading: _isLoading,
                  ),

                  SizedBox(height: 3.h),

                  // Terms Agreement
                  TermsAgreementWidget(
                    onAgreementChanged: (isAgreed) {
                      setState(() {
                        _isTermsAgreed = isAgreed;
                      });
                    },
                    isAgreed: _isTermsAgreed,
                  ),

                  SizedBox(height: 4.h),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.pureWhiteText.withValues(alpha: 0.7),
                        ),
                      ),
                      GestureDetector(
                        onTap: _navigateToLogin,
                        child: Text(
                          'Sign In',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.interactivePurple,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.interactivePurple,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
