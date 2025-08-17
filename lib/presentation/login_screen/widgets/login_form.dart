import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './custom_text_field.dart';
import 'custom_text_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? emailError;
  final String? passwordError;
  final Function(String) onEmailChanged;
  final Function(String) onPasswordChanged;
  final VoidCallback onForgotPassword;

  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    this.emailError,
    this.passwordError,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onForgotPassword,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          hintText: 'Email or Username',
          iconName: 'email',
          keyboardType: TextInputType.emailAddress,
          controller: widget.emailController,
          errorText: widget.emailError,
          onChanged: widget.onEmailChanged,
        ),
        SizedBox(height: 2.h),
        CustomTextField(
          hintText: 'Password',
          iconName: 'lock',
          isPassword: true,
          controller: widget.passwordController,
          errorText: widget.passwordError,
          onChanged: widget.onPasswordChanged,
        ),
        SizedBox(height: 1.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: widget.onForgotPassword,
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.inter(
                color: AppTheme.interactivePurple,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}