import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/news_model.dart';

class CustomHttpRequest{
  static fetchHomeData(){
    String url =
        "https://newsapi.org/v2/everything?q=football&sortBy=relevancy&pageSize=10&page=1&apiKey=4c9e5047288c404d890710a4ff8dab2a";
    NewsModel? newsModel;
    Future<NewsModel> fetchHomeData() async {
      var responce = await http.get(Uri.parse(url));
      var data = jsonDecode(responce.body);
      newsModel = NewsModel.fromJson(data);
      return newsModel!;
    }
  }

}