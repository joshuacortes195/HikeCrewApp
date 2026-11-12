import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// all the colors the app uses, in one spot
class AppColors {
  static const darkGreen = Color(0xFF183C31);
  static const lime = Color(0xFFDDECB5);
  static const cream = Color(0xFFF7F5EF);
  static const orange = Color(0xFFB8481B);
  static const grey = Color(0xFF66665E);
  static const border = Color(0xFFDDDCD2);
  static const white = Colors.white;
}

// the whole look of the app lives here
class AppTheme {
  // smallest size anything tappable can be
  static const double minTouch = 44;

  static ThemeData light() {
    final base = ThemeData(useMaterial3: true);

    // sizes and weights first, so inter loads the right bold files
    final sized = base.textTheme.copyWith(
      headlineLarge: const TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
        height: 1.1,
      ),
      headlineMedium: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        height: 1.15,
      ),
      titleLarge: const TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      titleMedium: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      bodyLarge: const TextStyle(fontSize: 16),
      bodyMedium: const TextStyle(fontSize: 15, height: 1.4),
      bodySmall: const TextStyle(fontSize: 13),
      labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );

    // inter everywhere, dark green by default
    final text = GoogleFonts.interTextTheme(
      sized,
    ).apply(bodyColor: AppColors.darkGreen, displayColor: AppColors.darkGreen);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.cream,

      // main colors material widgets pull from
      colorScheme: const ColorScheme.light(
        primary: AppColors.darkGreen,
        onPrimary: AppColors.white,
        secondary: AppColors.lime,
        onSecondary: AppColors.darkGreen,
        surface: AppColors.white,
        onSurface: AppColors.darkGreen,
        outline: AppColors.border,
      ),

      // styling for text, secondary text goes grey
      textTheme: text.copyWith(
        bodyMedium: text.bodyMedium?.copyWith(color: AppColors.grey),
        bodySmall: text.bodySmall?.copyWith(color: AppColors.grey),
      ),

      // styling for the top bar on pushed screens
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.darkGreen,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.darkGreen,
        ),
      ),

      // styling for the big pill buttons like log in and join hike
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.darkGreen,
          foregroundColor: AppColors.white,
          minimumSize: const Size.fromHeight(56),
          shape: const StadiumBorder(),
          textStyle: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // styling for small text links like forgot password
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.darkGreen,
          minimumSize: const Size(minTouch, minTouch),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // keeps icon buttons big enough to tap
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(minTouch, minTouch),
        ),
      ),

      // styling for text fields, white with a soft border
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: GoogleFonts.inter(color: AppColors.grey, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkGreen, width: 1.5),
        ),
      ),

      // styling for the pill shaped filter chips
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cream,
        selectedColor: AppColors.darkGreen,
        showCheckmark: false,
        shape: const StadiumBorder(side: BorderSide(color: AppColors.border)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // styling for the bottom nav
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.cream,
        indicatorColor: AppColors.lime,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.inter(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppColors.darkGreen : AppColors.grey,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppColors.darkGreen : AppColors.grey,
          );
        }),
      ),
    );
  }
}
