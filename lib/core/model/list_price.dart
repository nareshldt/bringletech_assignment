import 'dart:convert';

class ListPrice {
  final double? amount;
  final String? currencyCode;

  ListPrice({this.amount, this.currencyCode});

  factory ListPrice.fromMap(Map<String, dynamic> map) {
    return ListPrice(
      amount: (map['amount'] as num?)?.toDouble(),
      currencyCode: map['currencyCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'amount': amount, 'currencyCode': currencyCode};
  }

  ListPrice copyWith({double? amount, String? currencyCode}) {
    return ListPrice(
      amount: amount ?? this.amount,
      currencyCode: currencyCode ?? this.currencyCode,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPrice.fromJson(String source) =>
      ListPrice.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ListPrice &&
        other.amount == amount &&
        other.currencyCode == currencyCode;
  }

  @override
  int get hashCode {
    return (amount?.hashCode ?? 0) ^ (currencyCode?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'ListPrice(amount: $amount, currencyCode: $currencyCode)';
  }
}
