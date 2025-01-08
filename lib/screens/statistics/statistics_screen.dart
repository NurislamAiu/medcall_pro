import 'package:flutter/material.dart';
import 'package:medcall_pro/utils/size_screen.dart';
import 'package:medcall_pro/widgets/custom_banner.dart';

import '../../utils/color_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CustomBannerOur(
            title: 'Статистика заявок',
            subTitle: 'Получайте информацию о статусе заявок в реальном времени',
            isButton: false,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Блок "Рейтинг"
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [ScreenColor.background, Colors.white70],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: const Text(
                        'Рейтинг',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      subtitle: Row(
                        children: [
                          const Text(
                            '4.5 ',
                            style: TextStyle(fontSize: 18),
                          ),
                          // Условный пример отображения звёзд
                          Icon(Icons.star, color: Colors.orange[700]),
                          Icon(Icons.star, color: Colors.orange[700]),
                          Icon(Icons.star, color: Colors.orange[700]),
                          Icon(Icons.star, color: Colors.orange[700]),
                          const Icon(Icons.star_half, color: Colors.orange),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Блок "Доходы на сегодня"
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [ScreenColor.background, Colors.white70],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    title: const Text(
                      'Доходы на сегодня',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      '14 320 ТГ', // подставьте актуальное значение
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Блок "Достижения"
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/bonus'),
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [ScreenColor.background, Colors.white70],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),padding: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          'Достижения',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined, size: 14,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
