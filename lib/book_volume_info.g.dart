// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_volume_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookVolumeInfo _$BookVolumeInfoFromJson(Map<String, dynamic> json) =>
    BookVolumeInfo()
      ..title = json['title'] as String?
      ..authors =
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..publishedDate = json['publishedDate'] as String?
      ..description = json['description'] as String?;

Map<String, dynamic> _$BookVolumeInfoToJson(BookVolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
    };
