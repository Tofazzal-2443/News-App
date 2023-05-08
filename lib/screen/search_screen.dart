import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../http/custom_http.dart';
import '../model/news_model.dart';
import 'news_details.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController ?searchController ;

  @override
  void initState() {
    // TODO: implement initState
    searchController=TextEditingController();
    focusNode=FocusNode();
    super.initState();
  }
  FocusNode ?focusNode;


  NewsModel ?newsModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(width: double.infinity,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(

            child: Column(
              children: [

                TextField(
                  focusNode: focusNode,
                  controller: searchController,
                  decoration: InputDecoration(
                    suffix: IconButton(
                      onPressed: (){
                        FocusScope.of(context).unfocus();

                        searchController!.clear();
                        newsModel!.articles!.clear();
                        setState(() {

                        });
                      },
                      icon: Icon(Icons.close),
                    ),
                    prefixIcon:Icon(Icons.search) ,

                  ),

                  onEditingComplete: ()async{
                    newsModel=await CustomeHttpRequest.fetchSearchData(searchController!.text.toString());
                    setState(() {

                    });
                  },
                ),
                SizedBox(height: 30,),
                MasonryGridView.count(
                  crossAxisCount: 4,
                  itemCount: searchKeyword.length,
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemBuilder: (context, index) {
                    return  InkWell(
                      onTap: ()async{
                        searchController!.clear();
                        searchController!.text=searchKeyword[index];
                        newsModel=await CustomeHttpRequest.fetchSearchData(searchController!.text.toString());
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                        child: Text("${searchKeyword[index]}"),
                      ),
                    );
                  },
                ),


                newsModel?.articles ==null? SizedBox(height: 10,): ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModel!.articles!.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetails(
                          articles: newsModel!.articles![index],
                        )));
                      },
                      child: Container(
                        color: Colors.white,
                        height: 130,
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 60,width: 60,
                              color: Colors.blueGrey,
                            ),
                            Positioned(
                              right: 0,bottom: 0,
                              child: Container(
                                height: 50,width: 50,
                                color: Colors.blueGrey,
                              ),),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(14),
                              margin: EdgeInsets.all(14),
                              child: Row(

                                children: [
                                  Expanded(
                                    flex:3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child:CachedNetworkImage(
                                        imageUrl: "${newsModel!.articles![index].urlToImage}",
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
                                      ),
                                      //Image(image: NetworkImage("${snapshot.data!.articles![index].urlToImage}",))
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  Expanded(
                                      flex: 10,
                                      child:Column(
                                        children: [
                                          Text(
                                            "${newsModel!.articles![index].title}",maxLines: 2,),

                                          Text(
                                              "${newsModel!.articles![index].publishedAt}")
                                        ],
                                      )
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


List<String> searchKeyword=[
  "football","cricket","bitcoin","IPL","flutter","CNG","world","finance"
];
