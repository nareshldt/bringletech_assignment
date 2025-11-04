import 'dart:convert';

import 'image_links.dart';

class VolumeInfo {
  final String title;
  final List<String> authors;
  final String? subtitle;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final List<String>? categories;
  final int? pageCount;
  final String? printType;
  final String? language;
  final ImageLinks? imageLinks;
  final String? previewLink;
  final String? infoLink;
  final String? canonicalVolumeLink;

  VolumeInfo({
    required this.title,
    required this.authors,
    this.subtitle,
    this.publisher,
    this.publishedDate,
    this.description,
    this.categories,
    this.pageCount,
    this.printType,
    this.language,
    this.imageLinks,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  factory VolumeInfo.fromMap(Map<String, dynamic> map) {
    return VolumeInfo(
      title: map['title'] ?? '',
      authors:
          (map['authors'] as List?)?.map((e) => e.toString()).toList() ?? [],
      subtitle: map['subtitle'],
      publisher: map['publisher'],
      publishedDate: map['publishedDate'],
      description: map['description'],
      categories: (map['categories'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      pageCount: map['pageCount'],
      printType: map['printType'],
      language: map['language'],
      imageLinks: map['imageLinks'] != null
          ? ImageLinks.fromMap(map['imageLinks'])
          : null,
      previewLink: map['previewLink'],
      infoLink: map['infoLink'],
      canonicalVolumeLink: map['canonicalVolumeLink'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'authors': authors,
      'subtitle': subtitle,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'categories': categories,
      'pageCount': pageCount,
      'printType': printType,
      'language': language,
      'imageLinks': imageLinks?.toMap(),
      'previewLink': previewLink,
      'infoLink': infoLink,
      'canonicalVolumeLink': canonicalVolumeLink,
    };
  }

  VolumeInfo copyWith({
    String? title,
    List<String>? authors,
    String? subtitle,
    String? publisher,
    String? publishedDate,
    String? description,
    List<String>? categories,
    int? pageCount,
    String? printType,
    String? language,
    ImageLinks? imageLinks,
    String? previewLink,
    String? infoLink,
    String? canonicalVolumeLink,
  }) {
    return VolumeInfo(
      title: title ?? this.title,
      authors: authors ?? this.authors,
      subtitle: subtitle ?? this.subtitle,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      pageCount: pageCount ?? this.pageCount,
      printType: printType ?? this.printType,
      language: language ?? this.language,
      imageLinks: imageLinks ?? this.imageLinks,
      previewLink: previewLink ?? this.previewLink,
      infoLink: infoLink ?? this.infoLink,
      canonicalVolumeLink: canonicalVolumeLink ?? this.canonicalVolumeLink,
    );
  }

  String toJson() => json.encode(toMap());

  factory VolumeInfo.fromJson(String source) =>
      VolumeInfo.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VolumeInfo &&
        other.title == title &&
        _listEquals(other.authors, authors) &&
        other.subtitle == subtitle &&
        other.publisher == publisher &&
        other.publishedDate == publishedDate &&
        other.description == description &&
        _listEquals(other.categories, categories) &&
        other.pageCount == pageCount &&
        other.printType == printType &&
        other.language == language &&
        other.imageLinks == imageLinks &&
        other.previewLink == previewLink &&
        other.infoLink == infoLink &&
        other.canonicalVolumeLink == canonicalVolumeLink;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        authors.hashCode ^
        (subtitle?.hashCode ?? 0) ^
        (publisher?.hashCode ?? 0) ^
        (publishedDate?.hashCode ?? 0) ^
        (description?.hashCode ?? 0) ^
        (categories?.hashCode ?? 0) ^
        (pageCount?.hashCode ?? 0) ^
        (printType?.hashCode ?? 0) ^
        (language?.hashCode ?? 0) ^
        (imageLinks?.hashCode ?? 0) ^
        (previewLink?.hashCode ?? 0) ^
        (infoLink?.hashCode ?? 0) ^
        (canonicalVolumeLink?.hashCode ?? 0);
  }

  @override
  String toString() {
    return 'VolumeInfo(title: $title, authors: $authors, subtitle: $subtitle, publisher: $publisher, publishedDate: $publishedDate, description: $description, categories: $categories, pageCount: $pageCount, printType: $printType, language: $language, imageLinks: $imageLinks, previewLink: $previewLink, infoLink: $infoLink, canonicalVolumeLink: $canonicalVolumeLink)';
  }
}

bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
