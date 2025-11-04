import 'dart:convert';

import './list_price.dart';

class SaleInfo {
  final String? country;
  final String? saleability;
  final bool? isEbook;
  final ListPrice? listPrice;
  final ListPrice? retailPrice;
  final String? buyLink;

  SaleInfo({
    this.country,
    this.saleability,
    this.isEbook,
    this.listPrice,
    this.retailPrice,
    this.buyLink,
  });

  factory SaleInfo.fromMap(Map<String, dynamic> map) {
    return SaleInfo(
      country: map['country'],
      saleability: map['saleability'],
      isEbook: map['isEbook'],
      listPrice: map['listPrice'] != null
          ? ListPrice.fromMap(map['listPrice'])
          : null,
      retailPrice: map['retailPrice'] != null
          ? ListPrice.fromMap(map['retailPrice'])
          : null,
      buyLink: map['buyLink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'saleability': saleability,
      'isEbook': isEbook,
      'listPrice': listPrice?.toMap(),
      'retailPrice': retailPrice?.toMap(),
      'buyLink': buyLink,
    };
  }

  SaleInfo copyWith({
    String? country,
    String? saleability,
    bool? isEbook,
    ListPrice? listPrice,
    ListPrice? retailPrice,
    String? buyLink,
  }) {
    return SaleInfo(
      country: country ?? this.country,
      saleability: saleability ?? this.saleability,
      isEbook: isEbook ?? this.isEbook,
      listPrice: listPrice ?? this.listPrice,
      retailPrice: retailPrice ?? this.retailPrice,
      buyLink: buyLink ?? this.buyLink,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleInfo.fromJson(String source) =>
      SaleInfo.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SaleInfo &&
        other.country == country &&
        other.saleability == saleability &&
        other.isEbook == isEbook &&
        other.listPrice == listPrice &&
        other.retailPrice == retailPrice &&
        other.buyLink == buyLink;
  }

  @override
  int get hashCode {
    return (country?.hashCode ?? 0) ^
        (saleability?.hashCode ?? 0) ^
        (isEbook?.hashCode ?? 0) ^
        (listPrice?.hashCode ?? 0) ^
        (retailPrice?.hashCode ?? 0) ^
        (buyLink?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'SaleInfo(country: $country, saleability: $saleability, isEbook: $isEbook, listPrice: $listPrice, retailPrice: $retailPrice, buyLink: $buyLink)';
  }
}
