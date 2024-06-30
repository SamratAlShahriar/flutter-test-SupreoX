import 'package:dio/dio.dart';

import '../utils/app_constants.dart';

class ApiService {
  final _option = BaseOptions(
    baseUrl: AppConstants.appBaseUrlWithHttps,
  );

  Dio get dio => Dio(_option);
}
