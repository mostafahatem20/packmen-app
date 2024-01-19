import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packmen_app/core/app_export.dart';

class CustomTextField extends StatelessWidget {
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? contentPadding;
  final double? width, height;
  final Color? color;
  final Color? backgroundColor;
  final bool enabled;
  final InputBorder? decoration;
  final TextStyle? hintTextStyle;
  final void Function(String txt)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
    super.key,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.labelText,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.contentPadding,
    this.width,
    this.height,
    this.color = AppTheme.themeColor,
    this.backgroundColor,
    this.onChange,
    this.decoration,
    this.enabled = true,
    this.inputFormatters,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: width,
      height: height,
      child: TextFormField(
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          enabled: enabled,
          obscureText: obscureText,
          cursorColor: color,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              focusColor: color,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelText: labelText,
              hintStyle: hintTextStyle ?? AppTheme.body1,
              enabledBorder: decoration ?? AppDecoration.textFieldDecoration,
              focusedBorder: decoration ?? AppDecoration.textFieldDecoration,
              border: decoration ?? AppDecoration.textFieldDecoration,
              contentPadding: contentPadding),
          controller: controller,
          onChanged: onChange,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction),
    );
  }
}
