class FinancialRecordModel {
  final String id;
  final String userId;
  final double amount;
  final String type; // 'income', 'payment', 'withdrawal'
  final String description;
  final DateTime date;
  final String status; // 'pending', 'completed', 'failed'

  FinancialRecordModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
    this.status = 'completed',
  });

  factory FinancialRecordModel.fromJson(Map<String, dynamic> json) {
    return FinancialRecordModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: json['type'] ?? 'income',
      description: json['description'] ?? '',
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      status: json['status'] ?? 'completed',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'type': type,
      'description': description,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}
