import 'package:dio/dio.dart';
import 'dart:io';
import '../bean/DataHub.dart';
import '../bean/Item.dart';
import '../bean/Category.dart';
import '../bean/category_list.dart';
/*
 * @Created Date: 2019-02-05 14:24
 * @Author: Ckai
 * @Description: 
 */

class HttpManager {
  factory HttpManager() => _getInstance();
  static HttpManager get instance => _getInstance();
  static HttpManager _instance;
  Dio dio;
  Response response;
  DataHub dataHub;
  List<Item> list = <Item>[];
  CategoryList categoryList;

  HttpManager._internal() {
    dio = new Dio();
    dio.options.headers["User-Agent"] =
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";
    dio.options.connectTimeout = 8000;
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = new HttpManager._internal();
    }
    return _instance;
  }

  Future<DataHub> doGetData(String url) async {
    try {
      response = await dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var data = response.data;
        dataHub = DataHub.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return dataHub;
  }

  Future<CategoryList> doGetCategory(String url) async {
    try {
      response = await dio.get(url);
      if (response.statusCode == HttpStatus.ok) {
        var data = response.data;
        categoryList = CategoryList.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return categoryList;
  }
}
