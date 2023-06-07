import 'package:books_app/book_sale_info.dart';
import 'package:books_app/book_volume_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_item.g.dart';

@JsonSerializable()
class BookItem {
  String? id;
  BookVolumeInfo? volumeInfo;
  BookSaleInfo? saleInfo;
  bool? isFavorite = false;

  BookItem();

  factory BookItem.fromJson(Map<String, dynamic> json) =>
      _$BookItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookItemToJson(this);
}
