import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final num quantity;
  final Item item;

  const CartEntity({required this.quantity, required this.item});

  CartEntity copyWith({
    num? quantity,
    Item? item,
  }) {
    return CartEntity(
        quantity: quantity ?? this.quantity, item: item ?? this.item);
  }

  @override
  List<Object?> get props => [quantity, item];
}

class Item extends Equatable {
  final num? id;
  final String name;
  final String? slug;
  final String image;
  final String? description;
  final num price;
  final num discountPrice;

  num get currentPrice => price - discountPrice;

  const Item(
      {required this.id,
      required this.name,
      required this.slug,
      required this.image,
      required this.description,
      required this.price,
      required this.discountPrice});

  Item copyWith({
    num? id,
    String? name,
    String? slug,
    String? image,
    String? description,
    num? price,
    num? discountPrice,
  }) {
    return Item(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPrice: discountPrice ?? this.discountPrice);
  }

  @override
  List<Object?> get props =>
      [id, name, slug, image, description, price, discountPrice];
}
