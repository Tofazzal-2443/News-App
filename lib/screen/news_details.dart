import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../model/news_model.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails({Key? key, this.articles}) : super(key: key);
  Articles? articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${articles!.author}"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${articles!.title}",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${Jiffy.parse("${articles!.publishedAt}").format(pattern: 'dd/mm/yy on hh:mm')}"),
                    Text("less than a minute"),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CachedNetworkImage(
                  imageUrl: "${articles!.urlToImage}",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOmYqa4Vpnd-FA25EGmYMiDSWOl9QV8UN1du_duZC9mQ&s"),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text("${articles!.description}", style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Content",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Text("${articles!.content}", style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
