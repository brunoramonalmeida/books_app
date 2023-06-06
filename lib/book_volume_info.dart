import 'package:json_annotation/json_annotation.dart';

part 'book_volume_info.g.dart';

@JsonSerializable()
class BookVolumeInfo {
  String? title;
  List<String>? authors;
  String? publishedDate;
  String? description;

  BookVolumeInfo();

  factory BookVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$BookVolumeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BookVolumeInfoToJson(this);
}
