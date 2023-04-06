import 'package:dio/dio.dart';
import 'package:news_maker/page/entity.dart';

class NewsTypeModel{
  NewsTypeEntity? data;

  Future<NewsTypeEntity?> getData() async{
    if (data==null) {
      try {
        Response res = await _dio.get("http://10.0.2.2:5000/news/type");
        data = NewsTypeEntity.fromJson(res.data);
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