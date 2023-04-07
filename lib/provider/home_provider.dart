import 'package:flutter/material.dart';
import 'package:news_app/http/custom_http.dart';
import 'package:news_app/model/news_model.dart';

class HomeProvider extends ChangeNotifier{

  NewsModel? newsModel;
  getHomeData()async{
    newsModel=await CustomHttpRequest.fetchHomeData();
    return newsModel!;
  }

}