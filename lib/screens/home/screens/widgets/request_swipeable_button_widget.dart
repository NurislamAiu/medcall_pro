import 'package:flutter/material.dart';
import 'package:medcall_pro/utils/color_screen.dart';

class SwipeableButton extends StatefulWidget {
  final VoidCallback onSwipeComplete; // Callback при завершении свайпа
  final String buttonState; // Текущее состояние кнопки

  SwipeableButton({required this.onSwipeComplete, required this.buttonState});

  @override
  _SwipeableButtonState createState() => _SwipeableButtonState();
}

class _SwipeableButtonState extends State<SwipeableButton> {
  double _dragPosition = 0; // Текущая позиция свайпа
  late double _maxDragDistance; // Максимальная длина свайпа

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maxDragDistance = MediaQuery.of(context).size.width - 100; // Рассчёт длины
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Фон кнопки
        Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _getGradientForState(),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: _getColorForState().withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            _getTextForState(),
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Круглая кнопка для свайпа
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
          left: _dragPosition,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragPosition += details.delta.dx;
                _dragPosition = _dragPosition.clamp(0.0, _maxDragDistance);
              });
            },
            onHorizontalDragEnd: (details) {
              if (_dragPosition >= _maxDragDistance * 0.8) {
                // Если свайп завершён
                widget.onSwipeComplete();
                setState(() => _dragPosition = 0); // Сброс позиции
              } else {
                // Если свайп не завершён, возвращаем кнопку
                setState(() => _dragPosition = 0);
              }
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_forward, color: _getColorForState(), size: 28),
            ),
          ),
        ),
      ],
    );
  }

  /// Возвращает текст для текущего состояния кнопки
  String _getTextForState() {
    switch (widget.buttonState) {
      case 'выезжаю':
        return 'Сдвиньте, чтобы выехать';
      case 'на месте':
        return 'Сдвиньте, чтобы на месте';
      case 'завершить':
        return 'Сдвиньте, чтобы завершить';
      default:
        return 'Сдвиньте, чтобы продолжить';
    }
  }

  /// Возвращает цвет для текущего состояния кнопки
  Color _getColorForState() {
    switch (widget.buttonState) {
      case 'выезжаю':
        return ScreenColor.color6;
      case 'на месте':
        return Colors.orangeAccent;
      case 'завершить':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Возвращает градиент для текущего состояния кнопки
  List<Color> _getGradientForState() {
    switch (widget.buttonState) {
      case 'выезжаю':
        return [Colors.blue.shade300, ScreenColor.color6];
      case 'на месте':
        return [Colors.orange.shade300, Colors.orangeAccent];
      case 'завершить':
        return [Colors.green.shade300, Colors.green];
      default:
        return [Colors.grey.shade400, Colors.grey.shade600];
    }
  }
}