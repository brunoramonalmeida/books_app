import 'package:books_app/book_volume_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_item.g.dart';

@JsonSerializable()
class BookItem {
  String? id;
  BookVolumeInfo? volumeInfo;
  bool? isFavorite = false;

  BookItem();

  factory BookItem.fromJson(Map<String, dynamic> json) =>
      _$BookItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookItemToJson(this);
}
