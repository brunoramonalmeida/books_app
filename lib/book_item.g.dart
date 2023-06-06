// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookItem _$BookItemFromJson(Map<String, dynamic> json) => BookItem()
  ..id = json['id'] as String?
  ..volumeInfo = json['volumeInfo'] == null
      ? null
      : BookVolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$BookItemToJson(BookItem instance) => <String, dynamic>{
      'id': instance.id,
      'volumeInfo': instance.volumeInfo,
    };
