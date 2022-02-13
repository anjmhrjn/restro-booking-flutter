import 'package:json_annotation/json_annotation.dart';
import 'package:restro_booking/model/category_model.dart';
import 'package:restro_booking/model/user_model.dart';

part 'item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemModel {
  @JsonKey(name: '_id')
  final String id;
  final String? name;
  final List<String>? categories;
  final String? price;
  final String? images;
  final String? description;
  final String? itemOf;
  final List<CategoryModel>? category_info;
  final User? user_info;

  ItemModel({
    this.id = '',
    this.name,
    this.categories,
    this.price,
    this.images,
    this.description,
    this.itemOf,
    this.category_info,
    this.user_info,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
