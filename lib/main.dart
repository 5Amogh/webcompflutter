import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWebView(),
    );
  }
}

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late InAppWebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karmayogi Survey'),
        backgroundColor: Colors.indigo,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              'http://192.168.0.108:4200/mligot/mlsurvey/65eeb928fa030d0007864e96'),
          headers: {
            'Cookie': 'bearer=<auth>; user=<user_token>',
          },
        ),
        onWebViewCreated: (InAppWebViewController webViewController) {
          _controller = webViewController;
        },
        onLoadStop: (InAppWebViewController controller, Uri? url) {
          controller.evaluateJavascript(source: '''
            window.addEventListener('message', handleMessage);

            function handleMessage(res) {
              let responseData = JSON.parse(res.data);
              console.log('We got the response from the browser', JSON.stringify(responseData));
            }
          ''');
        },
      ),
    );
  }
}
