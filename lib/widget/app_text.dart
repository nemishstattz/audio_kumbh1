import 'package:flutter/material.dart';


class AppText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final double? height;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;

  const AppText({
    Key? key,
    this.text,
    this.fontSize,
    this.height,
    this.color,
    this.fontWeight,
    this.fontFamily,
    this.textAlign,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color ?? Colors.white,
        fontSize: fontSize ?? 14,
        fontFamily: fontFamily ?? 'f1',
      ),
    );
  }
}
