import 'package:flutter/material.dart';
import 'package:news_app/http/custom_http.dart';
import 'package:news_app/model/news_model.dart';

class HomeProvider with ChangeNotifier{

  NewsModel? newsModel;
  Future<NewsModel> getHomeData(int pageNo,String sortBy)async{
    newsModel=await CustomeHttpRequest.fetchHomeData( pageNo,sortBy);
    return newsModel!;
  }


}