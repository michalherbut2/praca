// ============================================
// 1. models/FridgeItem.dart
// ============================================
class FridgeItem {
  final String id;
  final String name;
  final double quantity;
  final String unit;
  final String category;
  final String addedBy;
  final String addedByName;
  final DateTime? expiryDate;
  final bool isOpened;
  final String? imageUrl;
  final String? notes;
  final DateTime createdAt;

  FridgeItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.addedBy,
    required this.addedByName,
    this.expiryDate,
    required this.isOpened,
    this.imageUrl,
    this.notes,
    required this.createdAt,
  });

  factory FridgeItem.fromJson(Map<String, dynamic> json) {
    return FridgeItem(
      id: json['id'],
      name: json['name'],
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'],
      category: json['category'],
      addedBy: json['addedBy'],
      addedByName: json['addedByName'],
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
      isOpened: json['isOpened'] ?? false,
      imageUrl: json['imageUrl'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  String getCategoryEmoji() {
    switch (category) {
      case 'MLECZNE': return '🥛';
      case 'WEDLINY': return '🥓';
      case 'WARZYWA': return '🥕';
      case 'OWOCE': return '🍎';
      case 'NAPOJE': return '🥤';
      default: return '📦';
    }
  }

  bool isExpiringSoon() {
    if (expiryDate == null) return false;
    final daysUntilExpiry = expiryDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 3 && daysUntilExpiry >= 0;
  }

  bool isExpired() {
    if (expiryDate == null) return false;
    return expiryDate!.isBefore(DateTime.now());
  }
}