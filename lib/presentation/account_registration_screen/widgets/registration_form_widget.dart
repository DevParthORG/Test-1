import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RegistrationFormWidget extends StatefulWidget {
  final Function(
          String fullName, String email, String username, String password)
      onFormSubmit;
  final bool isLoading;

  const RegistrationFormWidget({
    Key? key,
    required this.onFormSubmit,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isFormValid = false;
  String _passwordStrength = '';
  bool _isUsernameAvailable = true;
  bool _isCheckingUsername = false;

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _fullNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _isValidEmail(_emailController.text.trim()) &&
        _usernameController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordStrength != 'Weak' &&
        _isUsernameAvailable;

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _onPasswordChanged() {
    final password = _passwordController.text;
    String strength = '';

    if (password.isEmpty) {
      strength = '';
    } else if (password.length < 6) {
      strength = 'Weak';
    } else if (password.length < 8 ||
        !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      strength = 'Medium';
    } else {
      strength = 'Strong';
    }

    if (_passwordStrength != strength) {
      setState(() {
        _passwordStrength = strength;
      });
    }
    _validateForm();
  }

  void _onUsernameChanged() {
    final username = _usernameController.text.trim();
    if (username.length >= 3) {
      _checkUsernameAvailability(username);
    } else {
      setState(() {
        _isUsernameAvailable = true;
        _isCheckingUsername = false;
      });
    }
    _validateForm();
  }

  void _checkUsernameAvailability(String username) async {
    setState(() {
      _isCheckingUsername = true;
    });

    // Simulate API call with debounce
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock username availability check
    final unavailableUsernames = [
      'admin',
      'user',
      'test',
      'football',
      'soccer',
      'goal'
    ];
    final isAvailable = !unavailableUsernames.contains(username.toLowerCase());

    if (mounted && _usernameController.text.trim() == username) {
      setState(() {
        _isUsernameAvailable = isAvailable;
        _isCheckingUsername = false;
      });
      _validateForm();
    }
  }

  Color _getPasswordStrengthColor() {
    switch (_passwordStrength) {
      case 'Weak':
        return AppTheme.errorRed;
      case 'Medium':
        return AppTheme.warningAmber;
      case 'Strong':
        return AppTheme.successGreen;
      default:
        return AppTheme.neutralGray;
    }
  }

  void _submitForm() {
    if (_isFormValid && !widget.isLoading) {
      widget.onFormSubmit(
        _fullNameController.text.trim(),
        _emailController.text.trim(),
        _usernameController.text.trim(),
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name Field
          _buildInputField(
            controller: _fullNameController,
            label: 'Full Name',
            hintText: 'Enter your full name',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(height: 3.h),

          // Email Field
          _buildInputField(
            controller: _emailController,
            label: 'Email Address',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            suffixIcon: _emailController.text.isNotEmpty
                ? _isValidEmail(_emailController.text.trim())
                    ? CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.successGreen,
                        size: 20,
                      )
                    : CustomIconWidget(
                        iconName: 'error',
                        color: AppTheme.errorRed,
                        size: 20,
                      )
                : null,
          ),
          SizedBox(height: 3.h),

          // Username Field
          _buildInputField(
            controller: _usernameController,
            label: 'Username',
            hintText: 'Choose a username',
            keyboardType: TextInputType.text,
            suffixIcon: _usernameController.text.length >= 3
                ? _isCheckingUsername
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.interactivePurple),
                        ),
                      )
                    : _isUsernameAvailable
                        ? CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.successGreen,
                            size: 20,
                          )
                        : CustomIconWidget(
                            iconName: 'cancel',
                            color: AppTheme.errorRed,
                            size: 20,
                          )
                : null,
          ),
          if (_usernameController.text.length >= 3 &&
              !_isUsernameAvailable &&
              !_isCheckingUsername)
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                'Username is already taken',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ),
          SizedBox(height: 3.h),

          // Password Field
          _buildInputField(
            controller: _passwordController,
            label: 'Password',
            hintText: 'Create a strong password',
            obscureText: !_isPasswordVisible,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: CustomIconWidget(
                iconName: _isPasswordVisible ? 'visibility_off' : 'visibility',
                color: AppTheme.neutralGray,
                size: 20,
              ),
            ),
          ),

          // Password Strength Indicator
          if (_passwordController.text.isNotEmpty) ...[
            SizedBox(height: 1.h),
            Row(
              children: [
                Text(
                  'Password strength: ',
                  style: AppTheme.darkTheme.textTheme.bodySmall,
                ),
                Text(
                  _passwordStrength,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: _getPasswordStrengthColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            LinearProgressIndicator(
              value: _passwordStrength == 'Weak'
                  ? 0.33
                  : _passwordStrength == 'Medium'
                      ? 0.66
                      : _passwordStrength == 'Strong'
                          ? 1.0
                          : 0.0,
              backgroundColor: AppTheme.neutralGray.withValues(alpha: 0.3),
              valueColor:
                  AlwaysStoppedAnimation<Color>(_getPasswordStrengthColor()),
            ),
          ],

          SizedBox(height: 4.h),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: _isFormValid && !widget.isLoading ? _submitForm : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid
                    ? AppTheme.interactivePurple
                    : AppTheme.neutralGray,
                foregroundColor: AppTheme.pureWhiteText,
                disabledBackgroundColor:
                    AppTheme.neutralGray.withValues(alpha: 0.5),
                disabledForegroundColor:
                    AppTheme.pureWhiteText.withValues(alpha: 0.5),
                elevation: _isFormValid ? 2.0 : 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.pureWhiteText),
                      ),
                    )
                  : Text(
                      'Create Account',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.pureWhiteText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.pureWhiteText,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
            color: AppTheme.pureWhiteText,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.neutralGray.withValues(alpha: 0.7),
            ),
            fillColor: AppTheme.surfaceGray,
            filled: true,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: suffixIcon,
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                  color: AppTheme.pureWhiteText.withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                  color: AppTheme.pureWhiteText.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                  color: AppTheme.interactivePurple, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  const BorderSide(color: AppTheme.errorRed, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  const BorderSide(color: AppTheme.errorRed, width: 2.0),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          ),
        ),
      ],
    );
  }
}
