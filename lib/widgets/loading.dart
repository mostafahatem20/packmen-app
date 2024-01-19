import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';

class Loading extends StatelessWidget {
  final double? size;
  final double? strokeWidth;
  final Color color;

  const Loading({
    Key? key,
    this.size,
    this.color = AppTheme.themeColor,
    this.strokeWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth!,
      ),
    );
  }
}
