import 'dart:convert';

import './volume_info.dart';
import 'sale_info.dart';

class Book {
  final String id;
  final String? kind;
  final String? etag;
  final String? selfLink;
  final VolumeInfo volumeInfo;
  final SaleInfo? saleInfo;

  Book({
    required this.id,
    this.kind,
    this.etag,
    this.selfLink,
    required this.volumeInfo,
    this.saleInfo,
  });

  Book copyWith({
    String? id,
    String? kind,
    String? etag,
    String? selfLink,
    VolumeInfo? volumeInfo,
    SaleInfo? saleInfo,
  }) {
    return Book(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      etag: etag ?? this.etag,
      selfLink: selfLink ?? this.selfLink,
      volumeInfo: volumeInfo ?? this.volumeInfo,
      saleInfo: saleInfo ?? this.saleInfo,
    );
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? '',
      kind: map['kind'],
      etag: map['etag'],
      selfLink: map['selfLink'],
      volumeInfo: VolumeInfo.fromMap(map['volumeInfo'] ?? {}),
      saleInfo: map['saleInfo'] != null
          ? SaleInfo.fromMap(map['saleInfo'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kind': kind,
      'etag': etag,
      'selfLink': selfLink,
      'volumeInfo': volumeInfo.toMap(),
      'saleInfo': saleInfo?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Book &&
        other.id == id &&
        other.kind == kind &&
        other.etag == etag &&
        other.selfLink == selfLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        (kind?.hashCode ?? 0) ^
        (etag?.hashCode ?? 0) ^
        (selfLink?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'Book(id: $id, kind: $kind, etag: $etag, selfLink: $selfLink, volumeInfo: $volumeInfo, saleInfo: $saleInfo)';
  }
}
