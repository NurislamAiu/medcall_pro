import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
      child: Stack(
        children: [
          /// Фото пользователя
          Positioned(
            bottom: 0,
            right: 10,
            child: Stack(
              children: [
                Container(
                  width: ScreenSize(context).height * 0.3,
                  height: ScreenSize(context).height * 0.3,
                  decoration: BoxDecoration(
                    image: data!['photoUrl'] != null
                        ? DecorationImage(
                            image: NetworkImage(data!['photoUrl']),
                            fit: BoxFit.contain,
                          )
                        : null,
                  ),
                  child: data!['photoUrl'] == null
                      ? const Icon(Icons.person,
                          size: 50, color: ScreenColor.color6)
                      : null,
                ),
                Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(
                      Iconsax.setting,
                    ))
              ],
            ),
          ),

          /// Текстовая информация
          Positioned(
            bottom: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Рейтинг
                  if (data!['rating'] != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
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
            ),
          ),
        ],
      ),
    );
  }
}
