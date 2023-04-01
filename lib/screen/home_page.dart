import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/news_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String url =
      "https://newsapi.org/v2/everything?q=football&sortBy=relevancy&pageSize=10&page=1&apiKey=4c9e5047288c404d890710a4ff8dab2a";

  NewsModel? newsModel;

  Future<NewsModel> fetchHomeData() async {
    var responce = await http.get(Uri.parse(url));
    var data = jsonDecode(responce.body);
    print("our responce is ${data}");
    newsModel = NewsModel.fromJson(data);
    return newsModel!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
