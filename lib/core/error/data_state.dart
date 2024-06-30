sealed class Failure {
  String message;

  Failure([this.message = '']);
}

class ServerFailure extends Failure {
  ServerFailure([super.message = 'Server Failure']);
}

class SessionStorageFailure extends Failure{
  SessionStorageFailure([super.message = 'Session Storage Database Failure']);
}



class CacheFailure extends Failure {
  CacheFailure([super.message = 'Cache Failure']);
}
class UnknownFailure extends Failure {
  UnknownFailure([super.message = 'Unknown Failure']);
}