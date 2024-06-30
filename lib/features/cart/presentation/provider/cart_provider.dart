import 'package:flutter/foundation.dart';
import 'package:flutterfoody/core/network/api_service.dart';
import 'package:flutterfoody/core/usecase/usecase.dart';
import 'package:flutterfoody/core/utils/di.dart';

import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/food_item_entity.dart';
import '../../domain/usecase/get_menu_food_item_from_api_usecase.dart';

class CartProvider extends ChangeNotifier {
  final _getFoodItemUseCase = getIt<GetMenuFoodItemUseCase>();

  List<CartEntity> foodList = [];
  List<CartEntity> cart = [];
  num vatPercentage = 0;

  void addToCart(CartEntity entity) {
    final item = entity.item;

    final index = foodList.indexOf(entity);

    final listItem =
        cart.where((element) => element.item.id == item.id).firstOrNull;

    if (listItem != null) {
      print('here');
      final updatedItem = listItem.copyWith(quantity: listItem.quantity + 1);
      cart.remove(listItem);
      cart.add(updatedItem);
      foodList.removeAt(index);
      foodList.insert(index, updatedItem);
    } else {
      print('here333');
      CartEntity cartEntity = CartEntity(
          quantity: 1,
          item: Item(
              slug: item.slug,
              price: item.price,
              image: item.image,
              name: item.name,
              discountPrice: item.discountPrice,
              description: item.description,
              id: item.id));
      cart.add(cartEntity);

      foodList.removeAt(index);
      foodList.insert(index, cartEntity);
    }
    calculateBills(vatPercentage);
    notifyListeners();
  }

  bool isAddedAlready(Item item) {
    final listItem =
        cart.where((element) => element.item.id == item.id).firstOrNull;
    if (listItem == null) {
      return false;
    }
    return true;
  }

  void removeFromCart(CartEntity entity) {
    final item = entity.item;

    final index = foodList.indexOf(entity);

    final listItem =
        cart.where((element) => element.item.id == item.id).firstOrNull;

    if (listItem != null) {
      final updatedItem = listItem.copyWith(quantity: listItem.quantity - 1);
      if (updatedItem.quantity <= 0) {
        cart.remove(listItem);
      } else {
        cart.remove(listItem);
        cart.add(updatedItem);
      }
      foodList.removeAt(index);
      foodList.insert(index, updatedItem);
    }
    calculateBills(vatPercentage);
    notifyListeners();
  }

  double total =0 ;
  void calculateBills(num percentage) {
    _calculateSubTotal();
    _calculateVat(percentage);
    total = subTotal + vat;
  }

  double subTotal = 0;

  void _calculateSubTotal() {
    subTotal = 0;
    for (var item in cart) {
      subTotal += (item.item.price - item.item.discountPrice) * item.quantity;
    }
  }

  double vat = 0;

  void _calculateVat(num percentage) {
    vat = subTotal * (percentage / 100.0);
  }

  Future<void> getFoodItem() async {
    cart.clear();
    calculateBills(0);
    final result = await _getFoodItemUseCase(NoParams());
    result.fold((l) {
      foodList = [];
    }, (r) {
      vatPercentage = r.vat ?? 0;
      foodList = r.menu
          .map((e) => CartEntity(
              quantity: 1,
              item: Item(
                image: e.image ?? '',
                description: e.description,
                discountPrice: e.discountPrice ?? 0,
                id: e.id,
                name: e.name ?? '',
                price: e.price ?? 0,
                slug: e.slug,
              )))
          .toList();
    });
  }
}
