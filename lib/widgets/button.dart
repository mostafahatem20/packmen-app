import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/widgets/loading.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final double? borderRadius;
  final double? width;
  final bool? loading;
  final REdgeInsets? padding;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final double? prefixIconPadding;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final Color backgroundColor;
  final bool disabled;
  const CustomButton(
      {super.key,
      this.onPressed,
      this.text,
      this.borderRadius,
      this.width,
      this.loading,
      this.padding,
      this.textStyle,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconPadding,
      this.backgroundColor = AppTheme.themeColor,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(padding),
              backgroundColor: MaterialStateProperty.all<Color>(
                  disabled ? Colors.grey : backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 0)))),
          onPressed: (loading != null && loading == true) || disabled
              ? null
              : onPressed,
          child: loading != null && loading == true
              ? Loading(
                  size: 16.sp,
                  color: Colors.white,
                  strokeWidth: 3.sp,
                )
              : Row(
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    if (prefixIcon != null)
                      Padding(
                        padding: REdgeInsets.symmetric(
                            horizontal: prefixIconPadding ?? 30),
                        child: prefixIcon,
                      ),
                    Flexible(
                      child: Text(
                        text!.tr,
                        style: textStyle ?? AppTheme.body1,
                      ),
                    ),
                    if (suffixIcon != null)
                      Padding(
                        padding: REdgeInsets.only(left: 10),
                        child: suffixIcon,
                      ),
                  ],
                )),
    );
  }
}
