import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutterfoody/core/error/data_state.dart';
import 'package:flutterfoody/features/cart/data/model/food_item_api_response_model.dart';
import 'package:flutterfoody/core/network/api_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exception_handler.dart';

abstract class ICartApiService {
  final ApiService apiService;

  ICartApiService(this.apiService);

  Future<Either<Failure, FoodItemApiResponseModel>> getFoodMenu();
}

class CartApiService extends ICartApiService {
  CartApiService(super.apiService);

  final _foodMenuEndPoint = '/api/';

  @override
  Future<Either<Failure, FoodItemApiResponseModel>> getFoodMenu() async {
    try {
      final response = await apiService.dio.get(_foodMenuEndPoint);
        log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final responseMap = response.data;
        if (responseMap != null) {
          final model = FoodItemApiResponseModel.fromJson(responseMap);
          return Right(model);
        }
      }

      return Left(ServerFailure('Server Error!'));
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure(ExceptionHandler.getDioError(e).msg));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
