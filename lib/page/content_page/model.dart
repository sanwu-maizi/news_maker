import 'package:dio/dio.dart';
import 'package:news_maker/page/content_page/entity.dart';
// import 'package:news_maker/page/entity.dart';

class NewsContentModel{
  NewsContentEntity? data;

  Future<NewsContentEntity?> getData({required String link}) async{
    if (data==null) {
      try {
        var param = {
          "link":link,
        };
        Response res = await _dio.get("http://10.0.2.2:5000/news/content",queryParameters: param);
        data = NewsContentEntity.fromJson(res.data);
        return data;
      } catch (e) {
        return null;
      }
    }
    return data;
  }

  final Dio _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        sendTimeout: const Duration(seconds: 3),
      )
  );
}