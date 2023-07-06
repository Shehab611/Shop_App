// ignore_for_file: file_names

import 'package:dio/dio.dart';

//
class DioHelper {
  static Dio? dio;
  static init({required String url}) {
    //https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ecd4a12103ae4defb595760a29895765
    dio = Dio(BaseOptions(
        baseUrl: url,
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> getdata(
      {required String url,
       Map<String, dynamic>? query,
      String lang = 'en',
      String? auth}) async {
      dio!.options.headers = {'lang': lang, 'Authorization': auth??'','Content-Type': 'application/json'};
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postdata(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? auth}) async {
    dio!.options.headers = {'lang': lang, 'Authorization': auth??'','Content-Type': 'application/json'};
    return await dio!.post(url, queryParameters: query, data: data);
  }
}

