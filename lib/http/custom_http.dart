import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';


class CustomeHttpRequest {
  static Future<NewsModel> fetchHomeData(int pageNo,String sortBy) async {
    String url =
        "https://newsapi.org/v2/everything?q=football&sortBy=$sortBy&pageSize=10&page=${pageNo}&apiKey=4c9e5047288c404d890710a4ff8dab2a";

    NewsModel? newsModel;
    var responce = await http.get(Uri.parse(url));
    var data = jsonDecode(responce.body);
    newsModel = NewsModel.fromJson(data);
    return newsModel!;
  }
  static fetchSearchData(String query) async {
    String url =
        "https://newsapi.org/v2/everything?q=${query}&pageSize=20&apiKey=4c9e5047288c404d890710a4ff8dab2a";

    NewsModel? newsModel;
    var responce = await http.get(Uri.parse(url));
    var data = jsonDecode(responce.body);
    newsModel = NewsModel.fromJson(data);
    return newsModel!;
  }
}
