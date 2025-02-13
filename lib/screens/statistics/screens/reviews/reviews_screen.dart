import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';

class ReviewsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Алина К.',
      'photoUrl': 'https://via.placeholder.com/100',
      'rating': 5,
      'comment': 'Приложение отличное! Пользоваться очень удобно.',
    },
    {
      'name': 'Тимур Ж.',
      'photoUrl': 'https://via.placeholder.com/100',
      'rating': 4,
      'comment': 'Хорошо, но хотелось бы больше возможностей.',
    },
    {
      'name': 'Айжан Т.',
      'photoUrl': 'https://via.placeholder.com/100',
      'rating': 5,
      'comment': 'Супер! Особенно понравился быстрый интерфейс.',
    },
    {
      'name': 'Данияр Н.',
      'photoUrl': 'https://via.placeholder.com/100',
      'rating': 3,
      'comment': 'Иногда вылетает, но в целом всё ок.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomBannerOur(
            title: 'Отзывы',
            subTitle: 'Доверие клиентов — лучший показатель вашей работы.',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(review['photoUrl']),
                            radius: 30,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review['name'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: List.generate(
                                    5,
                                        (i) => Icon(
                                      Icons.star,
                                      color: i < review['rating']
                                          ? Colors.amber
                                          : Colors.grey[300],
                                      size: 18,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  review['comment'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}