class PointsTransaction {
  final String id;
  final String userId;
  final int amount;
  final String reason;
  final String awardedBy;
  final DateTime awardedAt;

  PointsTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.reason,
    required this.awardedBy,
    required this.awardedAt,
  });

  factory PointsTransaction.fromJson(Map<String, dynamic> json) {
    return PointsTransaction(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'],
      reason: json['reason'],
      awardedBy: json['awardedBy'],
      awardedAt: DateTime.parse(json['awardedAt']),
    );
  }
}