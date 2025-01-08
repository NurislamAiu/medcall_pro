import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/color_screen.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? colorBackground;
  final Color colorBorder;
  final Color? colorText;
  final String? icon;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.colorBackground = ScreenColor.color6,
    this.colorBorder = ScreenColor.color6,
    this.colorText = Colors.white,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(width: 1, color: colorBorder),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(colorBackground),
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.grey.withOpacity(0.2); // Эффект нажатия (полупрозрачный красный)
          }
          return null;
        }),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              SvgPicture.asset(
                icon!,
                height: 32,
              )
            else
              const SizedBox.shrink(),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}