import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';

class AppDecoration {
  static OutlineInputBorder get textFieldDecoration => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.5),
      borderSide: const BorderSide(color: AppTheme.themeColor, width: 2));
}
