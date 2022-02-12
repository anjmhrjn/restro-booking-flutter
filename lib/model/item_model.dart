import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  @JsonKey(name: '_id')
  final String id;
  final String? name;
  final List<String>? categories;
  final String? price;
  final String? images;
  final String? description;
  final String? itemOf;

  ItemModel({
    this.id = '',
    this.name,
    this.categories,
    this.price,
    this.images,
    this.description,
    this.itemOf,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
