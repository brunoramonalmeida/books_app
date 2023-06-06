// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) => BookResponse()
  ..items = (json['items'] as List<dynamic>?)
      ?.map((e) => BookItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$BookResponseToJson(BookResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
