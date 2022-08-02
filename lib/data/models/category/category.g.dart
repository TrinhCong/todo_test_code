// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String? ?? "",
      nameVn: json['name_vn'] as String? ?? "",
      nameEn: json['name_en'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name_vn': instance.nameVn,
      'name_en': instance.nameEn,
      'description': instance.description,
    };
