import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late WebViewController _controller;
  WebViewCookie bearerCookie = const WebViewCookie(
    name: 'bearer',
    value:
    '<bearer toke>',
    domain: 'http://192.168.0.108:4200',
  );
  WebViewCookie userCookie = const WebViewCookie(
    name: 'user',
    value:
    '<X-Authenticated-user-token',
    domain: 'http://192.168.0.108:4200',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karmayogi Survey'),
        backgroundColor: Colors.indigo,
      ),
      body: WebView(
        initialUrl: 'http://192.168.0.108:4200/mligot/mlsurvey/65f18fdad2bc56000784a3b8',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        initialCookies: [bearerCookie, userCookie],
        onPageFinished: (String url) {
          _controller.runJavascript('''
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
