class Menu {
  final String? name;
  final String? desc;
  final String? category;
  final List<String>? image;
  final String? itemOf;
  final double? price;
  Menu({
    this.name,
    this.desc,
    this.category = '',
    this.image,
    this.itemOf = '',
    this.price,
  });
}
