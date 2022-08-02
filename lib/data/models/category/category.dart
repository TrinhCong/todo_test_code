import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  String id;
  @JsonKey(name: "name_vn")
  String? nameVn;
  @JsonKey(name: "name_en")
  String? nameEn;
  String? description;

  Category({
    this.id = "",
    this.nameVn = "",
    this.nameEn = "",
    this.description = "",
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
