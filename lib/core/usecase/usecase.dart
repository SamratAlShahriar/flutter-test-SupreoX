import 'package:fpdart/fpdart.dart';

import '../error/data_state.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseWithOutFuture<Type, Params> {
  Either<Failure, Type> call(Params params);
}

final class NoParams {}