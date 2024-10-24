/*
 * Created by Deepak Gupta on 10/09/24, 9:03 pm
 * Copyright (c) 2024 . All rights reserved.
 * Last modified 10/09/24, 8:28 pm
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData.light().copyWith(
        primaryColor: primary,
        scaffoldBackgroundColor: Colors.white,

    );
  }

  static ThemeData dark() {
    return ThemeData.dark().copyWith(
        primaryColor: primary,
        scaffoldBackgroundColor: Colors.black,
    );
  }

  static TextStyle textStyle({double size = 14, Color color = Colors.grey, FontWeight weight = FontWeight.w300}) {
    return GoogleFonts.poppins(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
