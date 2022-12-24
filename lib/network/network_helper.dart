import 'package:dio/dio.dart';

class NetworkHelper {
  static final NetworkHelper instance = NetworkHelper._init();

  NetworkHelper._init();

  Dio dio = Dio();

  Future<Response> get({
    required String? path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    Response? res;
    try {
      res = await dio.get(
        path ?? '',
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioError catch (error) {
      print(
          'DIO ERRORRR: ${error.error} - ${error.stackTrace} ${error.message}');
    } catch (error) {
      print('ANOTHER ERRORR $error');
    }

    return res!;
  }
}

// service locator
