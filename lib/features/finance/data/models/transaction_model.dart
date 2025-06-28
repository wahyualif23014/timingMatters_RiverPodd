// data/models/transaction_model.dart
import '../../domain/entities/transaction_entity.dart'; // Pastikan ini mengacu pada entitas yang benar

class TransactionModel extends TransactionEntity {
  // Properti yang sesuai dengan kebutuhan repositori dan database
  final String id;
  final String description; // Menggantikan 'title' untuk lebih umum
  final double amount;
  final DateTime date;
  final String category;
  final bool isIncome;
  final String? budgetId; // Penting untuk menghubungkan ke BudgetModel, bisa nullable

  // Konstruktor untuk TransactionModel
  TransactionModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    required this.isIncome,
    this.budgetId, // budgetId sekarang ada
  }) : super( // Memanggil konstruktor super jika TransactionEntity memiliki parameter
          id: id,
          description: description, // Pastikan TransactionEntity membutuhkan 'description'
          amount: amount,
          date: date,
          category: category,
          isIncome: isIncome,
        );

  // Factory constructor untuk membuat objek dari Map JSON (saat membaca dari DB)
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String? ?? '', // Lebih eksplisit dengan as String?
      description: json['description'] as String? ?? json['title'] as String? ?? '', // Mengakomodasi 'title' jika masih ada di DB lama
      amount: _parseDouble(json['amount']),
      date: _parseDateTime(json['date']),
      category: json['category'] as String? ?? '',
      isIncome: json['isIncome'] as bool? ?? false,
      budgetId: json['budgetId'] as String?, // Dapat berupa null
    );
  }

  // Helper untuk parsing double
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  // Helper untuk parsing DateTime dari string ISO8601
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is int) { // Firebase Realtime Database bisa menyimpan timestamp sebagai int
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Warning: Failed to parse date string "$value": $e');
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  // Method untuk mengubah objek menjadi Map JSON (saat menulis ke DB)
  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description, // Gunakan 'description'
        'amount': amount,
        'date': date.toIso8601String(), // Simpan sebagai string ISO8601
        'category': category,
        'isIncome': isIncome,
        'budgetId': budgetId, // budgetId disertakan, akan null jika tidak ada
      };

  // Copy method untuk memudahkan update (immutability)
  TransactionModel copyWith({
    String? id,
    String? description, // Ganti dari title
    double? amount,
    DateTime? date,
    String? category,
    bool? isIncome,
    String? budgetId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      isIncome: isIncome ?? this.isIncome,
      budgetId: budgetId ?? this.budgetId,
    );
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, description: $description, amount: $amount, date: $date, category: $category, isIncome: $isIncome, budgetId: $budgetId)';
  }

  // Pastikan metode ini cocok dengan properti baru
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionModel &&
        other.id == id &&
        other.description == description &&
        other.amount == amount &&
        other.date == date &&
        other.category == category &&
        other.isIncome == isIncome &&
        other.budgetId == budgetId;
  }

  // Pastikan metode ini cocok dengan properti baru
  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        category.hashCode ^
        isIncome.hashCode ^
        budgetId.hashCode;
  }
}