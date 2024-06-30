import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class ExceptionHandler {
  static dynamic detectException(dynamic e) {
    if (e is SocketException) {
      return const SocketException('No Internet Connection');
    }
    if (e is TimeoutException) {
      return TimeoutException('Request Timeout');
    }

    if (e is HttpException) {
      return const HttpException('Http Exception');
    }

    if (e is FormatException) {
      return const FormatException('Bad Response Format');
    }

    return WrapperException();
  }

  static WrapperException getDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return WrapperException("Connection timed out");

      case DioExceptionType.badCertificate:
        return WrapperException("Bad SSL certificates");

      case DioExceptionType.badResponse:
        switch (error.response!.statusCode) {
          case 400:
            return WrapperException("Bad request");
          case 401:
            return WrapperException("Permission denied");
          case 500:
            return WrapperException("Server internal error");
        }
        return WrapperException("Server bad response");

      case DioExceptionType.cancel:
        return WrapperException("Server canceled it");

      case DioExceptionType.connectionError:
        return WrapperException("Connection Error");

      case DioExceptionType.unknown:
        return WrapperException("Unknown error");
    }
  }
}

class BaseException implements Exception{
  final String? msg;

  BaseException([this.msg]);

  @override
  String toString() {
    return msg ?? 'Unknown Error';
  }
}

class WrapperException implements Exception {
  final String msg;

  WrapperException([this.msg = 'Unknown Error']);

  @override
  String toString() => msg;
}

class UnknownError implements Exception {
  final String _msg;

  const UnknownError({String msg = "Unknown Error"}) : _msg = msg;

  @override
  String toString() => _msg;
}