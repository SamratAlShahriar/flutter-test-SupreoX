import 'package:flutterfoody/features/cart/data/service/cart_api_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../../data/model/food_item_api_response_model.dart';

abstract class CartRepository {
  final CartApiService apiService;

  CartRepository(this.apiService);

  Future<Either<Failure, FoodItemApiResponseModel>> getFoodMenu();
}
