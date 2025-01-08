import 'package:flutter/material.dart';
import '../utils/color_screen.dart';
import '../utils/size_screen.dart';

class CustomBannerOur extends StatelessWidget {
  const CustomBannerOur({
    super.key,
    required this.title,
    required this.subTitle,
    this.isButton = true,
  });

  final String title;
  final String subTitle;
  final bool isButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenSize(context).height * 0.30,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ScreenColor.color6,
            ScreenColor.color6.withOpacity(0.2)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: ScreenColor.color6.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ScreenColor.white,
                ),
              ),
              if (isButton)
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
            ],
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ScreenColor.white,
            ),
          ),
        ],
      ),
    );
  }
}