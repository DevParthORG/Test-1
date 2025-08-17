import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/login_form.dart';
import './widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;
  bool _isFormValid = false;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'admin@footballconnect.com': 'admin123',
    'user@footballconnect.com': 'user123',
    'demo@footballconnect.com': 'demo123',
  };

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _emailError == null &&
          _passwordError == null;
    });
  }

  void _validateEmail(String email) {
    setState(() {
      if (email.isEmpty) {
        _emailError = 'Email is required';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        _emailError = 'Please enter a valid email address';
      } else {
        _emailError = null;
      }
    });
  }

  void _validatePassword(String password) {
    setState(() {
      if (password.isEmpty) {
        _passwordError = 'Password is required';
      } else if (password.length < 6) {
        _passwordError = 'Password must be at least 6 characters';
      } else {
        _passwordError = null;
      }
    });
  }

  Future<void> _handleLogin() async {
    if (!_isFormValid) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      // Navigate to user profile screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/user-profile-screen');
      }
    } else {
      // Show error message
      setState(() {
        _emailError = 'Invalid credentials. Please try again.';
        _passwordError = 'Invalid credentials. Please try again.';
      });

      // Show error toast
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid email or password. Try: admin@footballconnect.com / admin123',
            style: TextStyle(color: AppTheme.pureWhiteText),
          ),
          backgroundColor: AppTheme.errorRed,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _handleSocialLogin(String provider) {
    // Simulate social login
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$provider login will be implemented soon',
          style: TextStyle(color: AppTheme.pureWhiteText),
        ),
        backgroundColor: AppTheme.interactivePurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceGray,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Forgot Password',
            style: TextStyle(
              color: AppTheme.pureWhiteText,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Password reset functionality will be implemented soon. Please use the mock credentials provided.',
            style: TextStyle(
              color: AppTheme.neutralGray,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(
                  color: AppTheme.interactivePurple,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 4.h),

              // App Logo
              Container(
                width: 25.w,
                height: 25.w,
                decoration: BoxDecoration(
                  color: AppTheme.interactivePurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomIconWidget(
                  iconName: 'sports_soccer',
                  color: AppTheme.pureWhiteText,
                  size: 12.w,
                ),
              ),

              SizedBox(height: 3.h),

              // Welcome Text
              Text(
                'Welcome Back!',
                style: TextStyle(
                  color: AppTheme.pureWhiteText,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 1.h),

              Text(
                'Sign in to continue to Football Connect',
                style: TextStyle(
                  color: AppTheme.neutralGray,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 4.h),

              // Login Form
              LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                emailError: _emailError,
                passwordError: _passwordError,
                onEmailChanged: _validateEmail,
                onPasswordChanged: _validatePassword,
                onForgotPassword: _handleForgotPassword,
              ),

              SizedBox(height: 3.h),

              // Login Button
              Container(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: _isFormValid && !_isLoading ? _handleLogin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid && !_isLoading
                        ? AppTheme.interactivePurple
                        : AppTheme.neutralGray,
                    foregroundColor: AppTheme.pureWhiteText,
                    elevation: _isFormValid && !_isLoading ? 2.0 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 5.w,
                          height: 5.w,
                          child: CircularProgressIndicator(
                            color: AppTheme.pureWhiteText,
                            strokeWidth: 2.0,
                          ),
                        )
                      : Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              SizedBox(height: 3.h),

              // Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppTheme.dividerColor.withValues(alpha: 0.3),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        color: AppTheme.neutralGray,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppTheme.dividerColor.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Social Login Buttons
              SocialLoginButton(
                iconName: 'g_translate',
                label: 'Continue with Google',
                backgroundColor: const Color(0xFFDB4437),
                onPressed: () => _handleSocialLogin('Google'),
              ),

              SocialLoginButton(
                iconName: 'apple',
                label: 'Continue with Apple',
                backgroundColor: const Color(0xFF000000),
                onPressed: () => _handleSocialLogin('Apple'),
              ),

              SocialLoginButton(
                iconName: 'facebook',
                label: 'Continue with Facebook',
                backgroundColor: const Color(0xFF1877F2),
                onPressed: () => _handleSocialLogin('Facebook'),
              ),

              SizedBox(height: 4.h),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New user? ',
                    style: TextStyle(
                      color: AppTheme.neutralGray,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, '/account-registration-screen');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppTheme.interactivePurple,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}