import 'package:flutterfoody/core/usecase/usecase.dart';
import 'package:flutterfoody/features/cart/domain/repository/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/data_state.dart';
import '../entities/food_item_entity.dart';

class GetMenuFoodItemUseCase extends UseCase<FoodItemEntity, NoParams> {
  final CartRepository repository;

  GetMenuFoodItemUseCase(this.repository);

  @override
  Future<Either<Failure, FoodItemEntity>> call(NoParams params) async {
    final response = await repository.getFoodMenu();

    return response.fold(
        (l) => Left(l),
        (r) {
          return Right(FoodItemEntity(
              note: r.note ?? '',
              vat: r.vat ?? 0,
              menu: r.menu
                  ?.map((e) => FoodMenu(
                image: e.image ?? '',
                description: e.description,
                discountPrice: e.discountPrice,
                id: e.id,
                name: e.name ?? '',
                price: e.price ?? 0,
                slug: e.slug,
              ))
                  .toList() ??
                  <FoodMenu>[]));
        });
  }
}
