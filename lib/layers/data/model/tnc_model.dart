import 'package:translate_now/layers/domain/entity/tnc_entity.dart';

class TncModel extends TncEntity {
  TncModel({
    required super.value,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TncModel.fromJson(Map<String, dynamic> json) {
    return TncModel(
      value: json['value'],
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
