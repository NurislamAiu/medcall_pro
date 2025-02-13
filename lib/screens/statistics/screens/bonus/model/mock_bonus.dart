import 'bonus_model.dart';

/// Пример локальных данных (заглушка)
final List<BonusData> mockBonuses = [
  const BonusData(
    id: 'bonus1',
    title: 'Бонус за 5 заявок на неделю',
    currentRequests: 3,
    targetRequests: 5,
    bonusAmount: 1000,
  ),
  const BonusData(
    id: 'bonus2',
    title: 'Бонус за 10 заявок на неделю',
    currentRequests: 7,
    targetRequests: 10,
    bonusAmount: 2000,
  ),
  const BonusData(
    id: 'bonus3',
    title: 'Бонус за 15 заявок на неделю',
    currentRequests: 0,
    targetRequests: 15,
    bonusAmount: 3000,
  ),
  const BonusData(
    id: 'bonus4',
    title: 'Бонус за 20 заявок на неделю',
    currentRequests: 14,
    targetRequests: 20,
    bonusAmount: 3900,
  ),
  const BonusData(
    id: 'bonus5',
    title: 'Бонус за 20 заявок (уже достигнут)',
    currentRequests: 20,
    targetRequests: 20,
    bonusAmount: 5000,
  ),
];