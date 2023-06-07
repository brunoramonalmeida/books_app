import 'package:json_annotation/json_annotation.dart';

part 'book_sale_info.g.dart';

@JsonSerializable()
class BookSaleInfo {
  String? buyLink;

  BookSaleInfo();

  factory BookSaleInfo.fromJson(Map<String, dynamic> json) =>
      _$BookSaleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookSaleInfoToJson(this);
}
