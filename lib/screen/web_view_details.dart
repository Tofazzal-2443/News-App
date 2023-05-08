import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/news_model.dart';



class WebViewDetails extends StatefulWidget {
  WebViewDetails({Key? key,this.articles}) : super(key: key);

  Articles ? articles;

  @override
  State<WebViewDetails> createState() => _WebViewDetailsState();
}

class _WebViewDetailsState extends State<WebViewDetails> {
  late WebViewController controller=WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))

    ..loadRequest(Uri.parse(widget.articles!.url.toString())) ;


  double progress=0.0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.articles!.source!.name}"),
      ),
      body:Container(
        width: double.infinity,
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              color: progress==1.0?Colors.transparent :Colors.blue,
            ),
            Expanded(child: WebViewWidget(

              controller: controller,

            ))
          ],
        ),
      ),
    );
  }
}
