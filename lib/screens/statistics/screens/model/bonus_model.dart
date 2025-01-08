class BonusData {
  final String id;
  final String title;
  final int currentRequests;
  final int targetRequests;
  final double bonusAmount;

  const BonusData({
    required this.id,
    required this.title,
    required this.currentRequests,
    required this.targetRequests,
    required this.bonusAmount,
  });
}