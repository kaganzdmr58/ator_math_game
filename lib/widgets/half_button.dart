import 'package:flutter/material.dart';

class HalfButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? paddingWidth;
  final double? height;
  final double? paddingHeight;
  final double? fontSize;
  final Color? borderColor;
  final int state;
  final int? result;
  const HalfButton({
    super.key,
    this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.width,
    this.paddingWidth,
    this.paddingHeight,
    this.height,
    this.fontSize,
    this.borderColor,
    this.state = 0,
    this.result,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (state != 2 && onPressed != null) {
          onPressed!();
        }
      },
      child: Container(
        width:
            (width ?? MediaQuery.of(context).size.width / 2) -
            (paddingWidth ?? 0),
        height: ((height ?? 50) - (paddingHeight ?? 0)),
        decoration: BoxDecoration(
          color:
              ((state == 1) && (result.toString() == text))
                  ? Colors.green
                  : color ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor ?? Colors.black12, width: 1),
        ),
        child: Center(
          child: Text(
            (text ?? '').toUpperCase(),
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: fontSize ?? 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
