import 'package:flutter/services.dart';
import 'package:flutterfoody/core/network/api_service.dart';
import 'package:flutterfoody/features/cart/data/repository/cart_repository_impl.dart';
import 'package:flutterfoody/features/cart/data/service/cart_api_service.dart';
import 'package:get_it/get_it.dart';

import '../../features/cart/domain/usecase/get_menu_food_item_from_api_usecase.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  await _deviceOrientation();

  await registeredRepositoryAndServices();
}

Future<void> _deviceOrientation() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

T _registeredIfNot<T extends Object>(T t) {
  final isRegistered = getIt.isRegistered<T>(instance: t);
  if (!isRegistered) {
    t = getIt.registerSingleton<T>(t);
  }
  return t;
}

Future<void> registeredRepositoryAndServices() async {
  //base api - start
  final baseApiService = _registeredIfNot<ApiService>(ApiService());
  //base api - end

  //api service (dio) - start
  final cartApiService =
      _registeredIfNot<CartApiService>(CartApiService(baseApiService));
  //api service (dio) - end

  ///repositories

  final cartRepository =
      _registeredIfNot<CartRepositoryImpl>(CartRepositoryImpl(cartApiService));

  ///use cases
  _registeredIfNot<GetMenuFoodItemUseCase>(
      GetMenuFoodItemUseCase(cartRepository));
}
