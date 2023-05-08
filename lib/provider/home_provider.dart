import 'package:flutter/material.dart';

import '../http/custom_http.dart';
import '../model/news_model.dart';



class NewsProvider with ChangeNotifier{

  NewsModel? newsModel;
  Future<NewsModel> getHomeData(int pageNo,String sortBy)async{
    newsModel=await CustomeHttpRequest.fetchHomeData( pageNo,sortBy);
    return newsModel!;
  }


}