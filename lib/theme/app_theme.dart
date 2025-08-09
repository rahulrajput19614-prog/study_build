import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Colors
  static const Color primaryLight = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF3B82F6);

  static const Color secondaryLight = Color(0xFF7C3AED);
  static const Color secondaryDark = Color(0xFF8B5CF6);

  static const Color successLight = Color(0xFF059669);
  static const Color successDark = Color(0xFF10B981);

  static const Color warningLight = Color(0xFFD97706);
  static const Color warningDark = Color(0xFFF59E0B);

  static const Color errorLight = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFFEF4444);

  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color surfaceDark = Color(0xFF0F172A);

  static const Color surfaceVariantLight = Color(0xFFF1F5F9);
  static const Color surfaceVariantDark = Color(0xFF1E293B);

  static const Color outlineLight = Color(0xFFE2E8F0);
  static const Color outlineDark = Color(0xFF334155);

  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);

  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF020617);

  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowDark = Color(0x1A000000);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: Colors.white,
      primaryContainer: primaryLight.withAlpha(25), // 0.1 * 255 ≈ 25
      onPrimaryContainer: primaryLight,
      secondary: secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: secondaryLight.withAlpha(25),
      onSecondaryContainer: secondaryLight,
      tertiary: successLight,
      onTertiary: Colors.white,
      tertiaryContainer: successLight.withAlpha(25),
      onTertiaryContainer: successLight,
      error: errorLight,
      onError: Colors.white,
      surface: surfaceLight,
      onSurface: textPrimaryLight,
      onSurfaceVariant: textSecondaryLight,
      outline: outlineLight,
      outlineVariant: outlineLight.withAlpha(127), // 0.5 * 255 ≈ 127
      shadow: shadowLight,
      scrim: Colors.black.withAlpha(127),
      inverseSurface: surfaceDark,
      onInverseSurface: textPrimaryDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: outlineLight,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: textPrimaryLight,
      elevation: 1.0,
      shadowColor: shadowLight,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: textPrimaryLight,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: textPrimaryLight, size: 24),
      actionsIconTheme: IconThemeData(color: textPrimaryLight, size: 24),
    ),
    cardTheme: CardTheme(
      color: cardLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryLight,
      unselectedItemColor: textSecondaryLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryLight,
        elevation: 2.0,
        shadowColor: shadowLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: BorderSide(color: primaryLight, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceVariantLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: outlineLight)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: outlineLight)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: primaryLight, width: 2.0)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: errorLight)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: errorLight, width: 2.0)),
      labelStyle: GoogleFonts.inter(color: textSecondaryLight, fontSize: 14, fontWeight: FontWeight.w400),
      hintStyle: GoogleFonts.inter(color: textSecondaryLight.withAlpha(179), fontSize: 14, fontWeight: FontWeight.w400),
      errorStyle: GoogleFonts.inter(color: errorLight, fontSize: 12, fontWeight: FontWeight.w400),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryLight;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryLight.withAlpha(127);
        }
        return outlineLight;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      side: BorderSide(color: outlineLight, width: 2.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryLight;
        }
        return outlineLight;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryLight,
      linearTrackColor: primaryLight.withAlpha(51),
      circularTrackColor: primaryLight.withAlpha(51),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryLight,
      thumbColor: primaryLight,
      overlayColor: primaryLight.withAlpha(51),
      inactiveTrackColor: outlineLight,
      trackHeight: 4.0,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: primaryLight,
      unselectedLabelColor: textSecondaryLight,
      indicatorColor: primaryLight,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.1),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(color: textPrimaryLight.withAlpha(230), borderRadius: BorderRadius.circular(8.0)),
      textStyle: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimaryLight,
      contentTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
      actionTextColor: primaryLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4.0,
    ),
    dialogTheme: DialogThemeData(backgroundColor: surfaceLight),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: Colors.white,
      primaryContainer: primaryDark.withAlpha(51),
      onPrimaryContainer: primaryDark,
      secondary: secondaryDark,
      onSecondary: Colors.white,
      secondaryContainer: secondaryDark.withAlpha(51),
      onSecondaryContainer: secondaryDark,
      tertiary: successDark,
      onTertiary: Colors.white,
      tertiaryContainer: successDark.withAlpha(51),
      onTertiaryContainer: successDark,
      error: errorDark,
      onError: Colors.white,
      surface: surfaceDark,
      onSurface: textPrimaryDark,
      onSurfaceVariant: textSecondaryDark,
      outline: outlineDark,
      outlineVariant: outlineDark.withAlpha(127),
      shadow: shadowDark,
      scrim: Colors.black.withAlpha(179),
      inverseSurface: surfaceLight,
      onInverseSurface: textPrimaryLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: outlineDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: textPrimaryDark,
      elevation: 1.0,
      shadowColor: shadowDark,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500, color: textPrimaryDark, letterSpacing: 0.15),
      iconTheme: IconThemeData(color: textPrimaryDark, size: 24),
      actionsIconTheme: IconThemeData(color: textPrimaryDark, size: 24),
    ),
    cardTheme: CardTheme(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryDark,
      unselectedItemColor: textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryDark,
        elevation: 2.0,
        shadowColor: shadowDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: BorderSide(color: primaryDark, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceVariantDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: outlineDark)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: outlineDark)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: primaryDark, width: 2.0)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: errorDark)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(color: errorDark, width: 2.0)),
      labelStyle: GoogleFonts.inter(color: textSecondaryDark, fontSize: 14, fontWeight: FontWeight.w400),
      hintStyle: GoogleFonts.inter(color: textSecondaryDark.withAlpha(179), fontSize: 14, fontWeight: FontWeight.w400),
      errorStyle: GoogleFonts.inter(color: errorDark, fontSize: 12, fontWeight: FontWeight.w400),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryDark;
        }
        return textSecondaryDark;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryDark.withAlpha(127);
        }
        return outlineDark;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
      side: BorderSide(color: outlineDark, width: 2.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryDark;
        }
        return outlineDark;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: primaryDark.withAlpha(51),
      circularTrackColor: primaryDark.withAlpha(51),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryDark,
      thumbColor: primaryDark,
      overlayColor: primaryDark.withAlpha(51),
      inactiveTrackColor: outlineDark,
      trackHeight: 4.0,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: primaryDark,
      unselectedLabelColor: textSecondaryDark,
      indicatorColor: primaryDark,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.1),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(color: textPrimaryDark.withAlpha(230), borderRadius: BorderRadius.circular(8.0)),
      textStyle: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimaryDark,
      contentTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
      actionTextColor: primaryDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4.0,
    ),
    dialogTheme: DialogThemeData(backgroundColor: surfaceDark),
  );

  static TextTheme _buildTextTheme({required bool isLight}) {
    return GoogleFonts.interTextTheme(
      isLight ? Typography.blackMountainView : Typography.whiteMountainView,
    );
  }
}
