class FoodItemEntity {
  final List<FoodMenu> menu;
  final num vat;
  final String note;

  const FoodItemEntity(
      {required this.menu, required this.vat, required this.note});

}

class FoodMenu {
  final num? id;
  final String name;
  final String? slug;
  final String image;
  final String? description;
  final num price;
  final num? discountPrice;

  const FoodMenu(
      {required this.id,
      required this.name,
      required this.slug,
      required this.image,
      required this.description,
      required this.price,
      required this.discountPrice});

  FoodMenu copyWith({
    num? id,
    String? name,
    String? slug,
    String? image,
    String? description,
    num? price,
    num? discountPrice,
  }) {
    return FoodMenu(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPrice: discountPrice ?? this.discountPrice);
  }

}
