import 'package:flutter/material.dart';
import '../../../utils/color_screen.dart';
import '../../../utils/size_screen.dart';

class ProfileBanner extends StatelessWidget {
  final Map<String, dynamic>? data;

  const ProfileBanner({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenSize(context).height * 0.35,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ScreenColor.color6,
            ScreenColor.color6.withOpacity(0.2),
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,  // Prevents unnecessary stretching
          children: [
            CircleAvatar(
              radius: ScreenSize(context).height * 0.07,
              backgroundColor: ScreenColor.color1.withOpacity(0.2),
              backgroundImage: data!['profileImage'] != null
                  ? NetworkImage(data!['profileImage']) as ImageProvider
                  : null,
              child: data!['profileImage'] == null
                  ? Icon(
                Icons.person,
                size: 50,
                color: ScreenColor.color1,
              )
                  : null,
            ),
            SizedBox(height: ScreenSize(context).height * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// Рейтинг
                if (data!['rating'] != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: ScreenColor.color1.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 16),
                        Text(
                          data!['rating']?.toString() ?? "N/A",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                /// Имя пользователя
                Text(
                  data!['name'] ?? "Unknown User",
                  style: TextStyle(
                    color: ScreenColor.color1,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                /// Специализация
                Text(
                  data!['specialist'] ?? "Unknown User",
                  style: TextStyle(
                    color: ScreenColor.color1,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
