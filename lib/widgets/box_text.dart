import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;

  const BoxText.headingOne(this.text, {TextAlign align = TextAlign.start})
      : style = AppTheme.display1,
        alignment = align;
  const BoxText.headingTwo(this.text, {TextAlign align = TextAlign.start})
      : style = AppTheme.display1,
        alignment = align;
  const BoxText.headingThree(this.text, {TextAlign align = TextAlign.start})
      : style = AppTheme.headline,
        alignment = align;
  const BoxText.headline(this.text, {TextAlign align = TextAlign.start})
      : style = AppTheme.title,
        alignment = align;
  const BoxText.subheading(this.text, {TextAlign align = TextAlign.start})
      : style = AppTheme.subtitle,
        alignment = align;
  const BoxText.caption(this.text, {TextAlign align = TextAlign.start})
      : style = AppTheme.caption,
        alignment = align;

  BoxText.body(this.text,
      {Color color = const Color(0xff868686),
      TextAlign align = TextAlign.start})
      : style = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ).copyWith(color: color),
        alignment = align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}
