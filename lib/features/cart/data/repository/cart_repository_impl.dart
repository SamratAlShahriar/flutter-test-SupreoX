import 'package:flutterfoody/core/error/data_state.dart';
import 'package:flutterfoody/features/cart/data/model/food_item_api_response_model.dart';
import 'package:flutterfoody/features/cart/domain/repository/cart_repository.dart';
import 'package:fpdart/src/either.dart';

class CartRepositoryImpl extends CartRepository {
  CartRepositoryImpl(super.apiService);

  @override
  Future<Either<Failure, FoodItemApiResponseModel>> getFoodMenu() async {
    return await apiService.getFoodMenu();
  }
}
