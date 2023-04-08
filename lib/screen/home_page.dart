import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String homeRoute = '/homePge';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daly News"),
        actions: [
          Icon(Icons.search),
          Icon(Icons.settings),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, inndex) {
                  return Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrangeAccent,
                    ),
                    child: Text("News Type"),
                  );
                }),
          ),
          ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        Image.network(
                          "image link",
                          height: 70,
                          width: double.infinity,
                        ),
                        Text(
                          "Title ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "sub Title ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
