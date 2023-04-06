import 'package:dio/dio.dart';
import 'package:news_maker/page/list_page/entity.dart';
// import 'package:news_maker/page/entity.dart';

class NewsListModel{
  NewsListEntity? entity;

  Future<NewsListEntity?> getData({required String type,int page=1}) async{
    //if (entity==null) {
      try {
        var param = {
          "type":type,
          "page":page
        };
        Response res = await _dio.get("http://10.0.2.2:5000/news/list",queryParameters: param);
        entity = NewsListEntity.fromJson(res.data);
        return entity;
      } catch (e) {
        return null;
      }
    //}
    //return entity;
  }


  final Dio _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 3),
        sendTimeout: const Duration(seconds: 3),
      )
  );
}