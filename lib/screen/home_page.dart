import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/screen/search_screen.dart';
import 'package:provider/provider.dart';
import '../model/news_model.dart';
import '../provider/home_provider.dart';
import 'news_details.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sortBy = "publishedAt";
  int pageNo = 1;

  @override
  Widget build(BuildContext context) {
    var newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("All News", style: TextStyle(fontSize: 30),),
        actions: [IconButton(onPressed: () {Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SearchPage()));}, icon: Icon(Icons.search))],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: ListView(
          children: [
            // Container(
            //   height: 70,
            //   color: Colors.green,
            //   child: ListView.builder(
            //       itemCount: ,
            //       itemBuilder: ),
            // ),

            Align(
              alignment: Alignment.centerRight,
              child: DropdownButton(
                style: TextStyle(color: Colors.blue, fontSize: 20),
                value: sortBy,
                items: [
                  DropdownMenuItem(
                    child: Text("Relevancy"),
                    value: "relevancy",
                  ),
                  DropdownMenuItem(
                    child: Text("Popularity"),
                    value: "popularity",
                  ),
                  DropdownMenuItem(
                    child: Text("PublishedAt"),
                    value: "publishedAt",
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    sortBy = value!;
                  });
                },
              ),
            ),
            FutureBuilder<NewsModel>(
              future: newsProvider.getHomeData(pageNo, sortBy),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Something is wrong");
                } else if (snapshot.data == null) {
                  return Text("snapshot data are null");
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewsDetails(
                              articles: snapshot.data!.articles![index],
                            )));
                      },
                      child: Container(
                        color: Colors.white,
                        height: 130,
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 130,
                              width: 60,
                              color: Colors.blue,
                            ),
                            Positioned(
                              right: 0,
                              child: Container(
                                height: 130,
                                width: 50,
                                color: Colors.blue,
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        "${snapshot.data!.articles![index].urlToImage}",
                                        placeholder: (context, url) =>
                                            Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Image.network(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
                                      ),
                                      //Image(image: NetworkImage("${snapshot.data!.articles![index].urlToImage}",))
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${snapshot.data!.articles![index].title}",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                              "${Jiffy.parse("${snapshot.data!.articles![index].publishedAt}").format(pattern: 'dd/mm/yy on hh:mm')}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ElevatedButton(
                      onPressed: () {
                        if (pageNo == 1) {
                          return null;
                        } else {
                          setState(() {
                            pageNo -= 1;
                          });
                        }
                      },
                      child: Text("Prev")),
                  SizedBox(width: 5,),
                  Flexible(
                    flex: 2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              setState(() {
                                pageNo = index + 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: pageNo == index + 1
                                      ? Colors.blue
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(10)
                              ),

                              margin: EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ));
                      },
                    ),
                  ),
                  SizedBox(width: 5,),
                  ElevatedButton(
                      onPressed: () {
                        if (pageNo < 10) {
                          setState(() {
                            pageNo += 1;
                          });
                        }
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
