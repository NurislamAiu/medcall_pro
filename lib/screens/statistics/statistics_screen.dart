import 'package:flutter/material.dart';

import '../../widgets/custom_banner.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5FA),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBannerOur(
              title: 'Статистика заявок',
              subTitle: 'Получайте информацию о статусе заявок в реальном времени',
              isButton: false,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Column(
                  children: [
                    _buildNeumorphicCard(
                      title: 'Рейтинг',
                      subtitle: Row(
                        children: [
                          const Text(
                            '4.5 ',
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(Icons.star, color: Colors.orange[700]),
                          Icon(Icons.star, color: Colors.orange[700]),
                          Icon(Icons.star, color: Colors.orange[700]),
                          Icon(Icons.star, color: Colors.orange[700]),
                          const Icon(Icons.star_half, color: Colors.orange),
                        ],
                      ),
                      icon: Icons.arrow_forward_ios_outlined,
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    _buildNeumorphicCard(
                      title: 'Доходы на сегодня',
                      subtitle: const Text(
                        '14 320 ТГ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      icon: Icons.arrow_forward_ios_outlined,
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    _buildNeumorphicCard(
                      title: 'Достижения',
                      subtitle: const Text('Просмотрите свои достижения'),
                      icon: Icons.arrow_forward_ios_outlined,
                      onTap: () => Navigator.pushNamed(context, '/bonus'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }


  Widget _buildNeumorphicCard({
    required String title,
    required Widget subtitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-4, -4),
                blurRadius: 10,
              ),
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(4, 4),
                blurRadius: 10,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    subtitle,
                  ],
                ),
              ),
              Icon(
                icon,
                color: Colors.grey[700],
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}