import 'package:flutter/material.dart';
import 'package:signup/customWidget/appText.dart';

class CustomButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String buttonText;
  final Color? backgroundColor;
  final Color? textColor;
  final double? size;
  final FontWeight? fontWeight;
  final Function()? onPressed;
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      required this.buttonText,
      this.backgroundColor,
      this.textColor,
      this.size,
      this.fontWeight,
      this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          foregroundColor: widget.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onPressed,
        child: AppText(
          text: widget.buttonText,
          size: widget.size,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
