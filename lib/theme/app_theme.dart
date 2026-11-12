import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// every color in the app, dark green text and buttons, lime pills, cream background, orange dates and log out
class AppColors {
  // titles, text and the big buttons
  static const darkGreen = Color(0xFF183C31);
  // difficulty pills and the bottom nav bubble
  static const lime = Color(0xFFDDECB5);
  // background behind every screen
  static const cream = Color(0xFFF7F5EF);
  // date lines and the log out link
  static const orange = Color(0xFFB8481B);
  // smaller text like locations and "8 going"
  static const grey = Color(0xFF66665E);
  // thin lines and box borders
  static const border = Color(0xFFDDDCD2);
  // text boxes, meeting spot card and bookmark button
  static const white = Colors.white;
}

// the look of every screen lives here, fonts, buttons, fields, chips and the bottom nav
class AppTheme {
  // smallest size any button can be so it's easy to tap on a phone
  static const double minTouch = 44;

  static ThemeData light() {
    final base = ThemeData(useMaterial3: true);

    // text sizes for every screen, set first so inter loads the real bold files for the big headings
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

    // turns all the text in the app into inter, dark green by default
    final text = GoogleFonts.interTextTheme(
      sized,
    ).apply(bodyColor: AppColors.darkGreen, displayColor: AppColors.darkGreen);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.cream,

      // colors flutter's built in widgets use, like the spinner and the plus button
      colorScheme: const ColorScheme.light(
        primary: AppColors.darkGreen,
        onPrimary: AppColors.white,
        secondary: AppColors.lime,
        onSecondary: AppColors.darkGreen,
        surface: AppColors.white,
        onSurface: AppColors.darkGreen,
        outline: AppColors.border,
      ),

      // makes the smaller text grey, like "Find your next crew." and "8 going"
      textTheme: text.copyWith(
        bodyMedium: text.bodyMedium?.copyWith(color: AppColors.grey),
        bodySmall: text.bodySmall?.copyWith(color: AppColors.grey),
      ),

      // styling for the top bar with the back arrow on the hike details screen
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

      // styling for the big green pill buttons, log in on the login screen and join hike on the details screen
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

      // styling for text links like forgot password, sign up and view hike
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

      // keeps icon buttons like the bookmark and back arrow big enough to tap
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(minTouch, minTouch),
        ),
      ),

      // styling for the white text boxes, email and password on login and the search bar
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

      // styling for the all hikes, easy, moderate and hard chips on the all hikes screen
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cream,
        selectedColor: AppColors.darkGreen,
        showCheckmark: false,
        shape: const StadiumBorder(side: BorderSide(color: AppColors.border)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),

      // thin lines, like the one above "8 going" on each card and between the details stats
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),

      // styling for the bottom nav, lime bubble behind the tab you're on
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
