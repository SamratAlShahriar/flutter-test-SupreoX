class FoodItemApiResponseModel {
  FoodItemApiResponseModel({
    this.menu,
    this.vat,
    this.note,
  });

  FoodItemApiResponseModel.fromJson(dynamic json) {
    if (json['menu'] != null) {
      menu = [];
      json['menu'].forEach((v) {
        menu?.add(Menu.fromJson(v));
      });
    }
    vat = json['vat'];
    note = json['note'];
  }

  List<Menu>? menu;
  num? vat;
  String? note;

  FoodItemApiResponseModel copyWith({
    List<Menu>? menu,
    num? vat,
    String? note,
  }) =>
      FoodItemApiResponseModel(
        menu: menu ?? this.menu,
        vat: vat ?? this.vat,
        note: note ?? this.note,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (menu != null) {
      map['menu'] = menu?.map((v) => v.toJson()).toList();
    }
    map['vat'] = vat;
    map['note'] = note;
    return map;
  }
}

class Menu {
  Menu({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.description,
    this.price,
    this.discountPrice,
  });

  Menu.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    discountPrice = json['discount_price'];
  }

  num? id;
  String? name;
  String? slug;
  String? image;
  String? description;
  num? price;
  num? discountPrice;

  Menu copyWith({
    num? id,
    String? name,
    String? slug,
    String? image,
    String? description,
    num? price,
    num? discountPrice,
  }) =>
      Menu(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        image: image ?? this.image,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPrice: discountPrice ?? this.discountPrice,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['description'] = description;
    map['price'] = price;
    map['discount_price'] = discountPrice;
    return map;
  }
}
