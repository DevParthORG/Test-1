import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the application.
/// Implements Midnight Sports theme with Contemporary Sports Social design style.
class AppTheme {
  AppTheme._();

  // Midnight Sports Color Palette
  static const Color primaryBackground =
      Color(0xFF1A1A1A); // Deep foundation optimized for OLED displays
  static const Color interactivePurple =
      Color(0xFF8B5CF6); // Clear accent for buttons and active states
  static const Color pureWhiteText =
      Color(0xFFFFFFFF); // Maximum contrast for readability
  static const Color footballOrange =
      Color(0xFFFF8C42); // Energetic accent for football-specific elements
  static const Color successGreen =
      Color(0xFF10B981); // Confirmation states and positive actions
  static const Color lightPurpleContainer =
      Color(0xFFA78BFA); // Subtle background for secondary interactive elements
  static const Color neutralGray =
      Color(0xFF6B7280); // Secondary text and inactive states
  static const Color errorRed =
      Color(0xFFEF4444); // Standard error communication
  static const Color warningAmber =
      Color(0xFFF59E0B); // Attention states and important notifications
  static const Color surfaceGray =
      Color(0xFF374151); // Card backgrounds and elevated surfaces

  // Additional theme colors for comprehensive theming
  static const Color dividerColor = Color(0xFF4B5563);
  static const Color shadowColor = Color(0x1A000000);
  static const Color overlayColor = Color(0x80000000);

  /// Light theme (optimized for dark-first design but providing light alternative)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: interactivePurple,
      onPrimary: pureWhiteText,
      primaryContainer: lightPurpleContainer,
      onPrimaryContainer: primaryBackground,
      secondary: footballOrange,
      onSecondary: pureWhiteText,
      secondaryContainer: footballOrange.withValues(alpha: 0.2),
      onSecondaryContainer: primaryBackground,
      tertiary: successGreen,
      onTertiary: pureWhiteText,
      tertiaryContainer: successGreen.withValues(alpha: 0.2),
      onTertiaryContainer: primaryBackground,
      error: errorRed,
      onError: pureWhiteText,
      surface: pureWhiteText,
      onSurface: primaryBackground,
      onSurfaceVariant: neutralGray,
      outline: dividerColor,
      outlineVariant: dividerColor.withValues(alpha: 0.5),
      shadow: shadowColor,
      scrim: overlayColor,
      inverseSurface: primaryBackground,
      onInverseSurface: pureWhiteText,
      inversePrimary: lightPurpleContainer,
    ),
    scaffoldBackgroundColor: pureWhiteText,
    cardColor: surfaceGray.withValues(alpha: 0.1),
    dividerColor: dividerColor.withValues(alpha: 0.3),
    appBarTheme: AppBarTheme(
      backgroundColor: pureWhiteText,
      foregroundColor: primaryBackground,
      elevation: 2.0,
      shadowColor: shadowColor,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryBackground,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceGray.withValues(alpha: 0.1),
      elevation: 2.0,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: pureWhiteText,
      selectedItemColor: interactivePurple,
      unselectedItemColor: neutralGray,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: interactivePurple,
      foregroundColor: pureWhiteText,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: pureWhiteText,
        backgroundColor: interactivePurple,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: interactivePurple,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: interactivePurple, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: interactivePurple,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceGray.withValues(alpha: 0.1),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerColor.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerColor.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: interactivePurple, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutralGray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: neutralGray.withValues(alpha: 0.7),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple;
        }
        return neutralGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple.withValues(alpha: 0.3);
        }
        return neutralGray.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(pureWhiteText),
      side: const BorderSide(color: neutralGray, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple;
        }
        return neutralGray;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: interactivePurple,
      linearTrackColor: Color(0xFFE5E7EB),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: interactivePurple,
      thumbColor: interactivePurple,
      overlayColor: interactivePurple.withValues(alpha: 0.2),
      inactiveTrackColor: neutralGray.withValues(alpha: 0.3),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: interactivePurple,
      unselectedLabelColor: neutralGray,
      indicatorColor: interactivePurple,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: primaryBackground.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: pureWhiteText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryBackground,
      contentTextStyle: GoogleFonts.inter(
        color: pureWhiteText,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: interactivePurple,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ), dialogTheme: DialogThemeData(backgroundColor: pureWhiteText),
  );

  /// Dark theme (primary theme optimized for sports social media)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: interactivePurple,
      onPrimary: pureWhiteText,
      primaryContainer: lightPurpleContainer,
      onPrimaryContainer: primaryBackground,
      secondary: footballOrange,
      onSecondary: pureWhiteText,
      secondaryContainer: footballOrange.withValues(alpha: 0.2),
      onSecondaryContainer: pureWhiteText,
      tertiary: successGreen,
      onTertiary: pureWhiteText,
      tertiaryContainer: successGreen.withValues(alpha: 0.2),
      onTertiaryContainer: pureWhiteText,
      error: errorRed,
      onError: pureWhiteText,
      surface: surfaceGray,
      onSurface: pureWhiteText,
      onSurfaceVariant: neutralGray,
      outline: dividerColor,
      outlineVariant: dividerColor.withValues(alpha: 0.5),
      shadow: shadowColor,
      scrim: overlayColor,
      inverseSurface: pureWhiteText,
      onInverseSurface: primaryBackground,
      inversePrimary: interactivePurple,
    ),
    scaffoldBackgroundColor: primaryBackground,
    cardColor: surfaceGray,
    dividerColor: dividerColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBackground,
      foregroundColor: pureWhiteText,
      elevation: 2.0,
      shadowColor: shadowColor,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: pureWhiteText,
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceGray,
      elevation: 2.0,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceGray,
      selectedItemColor: interactivePurple,
      unselectedItemColor: neutralGray,
      elevation: 4.0,
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: interactivePurple,
      foregroundColor: pureWhiteText,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: pureWhiteText,
        backgroundColor: interactivePurple,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: interactivePurple,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: interactivePurple, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: interactivePurple,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceGray,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerColor.withValues(alpha: 0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerColor.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: interactivePurple, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: neutralGray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: neutralGray.withValues(alpha: 0.7),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple;
        }
        return neutralGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple.withValues(alpha: 0.3);
        }
        return neutralGray.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(pureWhiteText),
      side: const BorderSide(color: neutralGray, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return interactivePurple;
        }
        return neutralGray;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: interactivePurple,
      linearTrackColor: surfaceGray,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: interactivePurple,
      thumbColor: interactivePurple,
      overlayColor: interactivePurple.withValues(alpha: 0.2),
      inactiveTrackColor: neutralGray.withValues(alpha: 0.3),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: interactivePurple,
      unselectedLabelColor: neutralGray,
      indicatorColor: interactivePurple,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceGray.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: pureWhiteText,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceGray,
      contentTextStyle: GoogleFonts.inter(
        color: pureWhiteText,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: interactivePurple,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ), dialogTheme: DialogThemeData(backgroundColor: surfaceGray),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color primaryTextColor = isLight ? primaryBackground : pureWhiteText;
    final Color secondaryTextColor = neutralGray;
    final Color disabledTextColor = neutralGray.withValues(alpha: 0.6);

    return TextTheme(
      // Display styles - Inter Bold for maximum impact
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles - Inter SemiBold for strong hierarchy
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles - Inter Medium for clear section headers
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles - Inter Regular for optimal readability
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles - Inter Medium for UI elements
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: disabledTextColor,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }
}
