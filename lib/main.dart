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
  bool cookiesSet = false;

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
              'http://192.168.0.108:4200/mligot/mlsurvey/65e01aeffa030d00078645b6'),
          headers: {
            'Cookies': 'bearer=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ2dHdSbVh5cFlGajBEcG5VWXF0Szl1TU0wOVEzRlFIcyJ9.ogmX81_cVBmmEkrAaM1CCwfEdBnClE2U8tDWT30eDzw;user=eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJwMTRYR1lrdHAxUnNScEZZeXZGTnZuekUxVDBMT3hVSHBoNnhHSzUxdGhvIn0.eyJqdGkiOiJmZjlkZmQxZS1mMDJjLTRjNTAtOTcwMi1lYjkxYTEzMGY5YmUiLCJleHAiOjE3MTEwOTk5NzksIm5iZiI6MCwiaWF0IjoxNzExMDEzNTc5LCJpc3MiOiJodHRwczovL3BvcnRhbC5rYXJtYXlvZ2kubmljLmluL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJzdWIiOiJmOmJhYWRhOGIxLWU2MmUtNDRjNC1hMTRkLTY3MDJlYTkwZjQ5Njo2Nzc4Y2MyYi04MDc1LTQ5YTQtOWU3ZC1kZWFmYTRkMGQ5ZWYiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJhZG1pbi1jbGkiLCJhdXRoX3RpbWUiOjAsInNlc3Npb25fc3RhdGUiOiJjYWY0YTE2Ny02YjcyLTQ5Y2QtYjJlMC0xNzA3YjQyMmQ2ZTkiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbImh0dHA6Ly9sb2NhbGhvc3Q6NDIwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwic2NvcGUiOiIiLCJuYW1lIjoibml0aW4ga3VtYXIgdGVzdCIsInByZWZlcnJlZF91c2VybmFtZSI6InByb2RtZG9hZG1pbl82eDRsIiwiZ2l2ZW5fbmFtZSI6Im5pdGluIGt1bWFyIHRlc3QiLCJmYW1pbHlfbmFtZSI6IiIsImVtYWlsIjoicHIqKioqKioqKioqKipAeW9wbWFpbC5jb20ifQ.BBO6no8dDwEJN14etfXDiRf8LL9VoC3mVsKUzjdfqNPLd-HHsTo_VEsDyvYE90I3-IQXPT2sotP8jHXirYYU2OcteEs5JA1mnGvjpFPA4ctCul3N4RnzrsNXiSN-fHfq4GsW8USdb3NaekoOJnqe333a4oOjJRqupLk14ruzn1XUGbER1OPa1jdHaDu7I13gZ_hHineRLF_Tg6GeN90V_NIQkjw1wyB5fOgiBbV_hAK0B4CVeDJk5yqRmxfDZrU70ymuhW47xm7JzdbjneWCA8C2MESaNar0YwQN1tqwJDwg3O9YgjRxOw3ggpK2eml1cchuimRRckTclewGVih2Ig' // Dummy value for cookies for now
          },
        ),
        onLoadStop: (controller, url) async {
          if (!cookiesSet) {
            await _setCookies();
          }
        },

        onWebViewCreated: (InAppWebViewController webViewController) async {
          _controller = webViewController;
        },

        onConsoleMessage: (controller, consoleMessage) {
          print('Console message: ${consoleMessage.message}');
        },
      ),
    );
  }

  Future<void> _setCookies() async {
    await _controller.evaluateJavascript(source: '''
      window.addEventListener('message', handleMessage);
      localStorage.setItem('bearer','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ2dHdSbVh5cFlGajBEcG5VWXF0Szl1TU0wOVEzRlFIcyJ9.ogmX81_cVBmmEkrAaM1CCwfEdBnClE2U8tDWT30eDzw');
      localStorage.setItem('user','eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJwMTRYR1lrdHAxUnNScEZZeXZGTnZuekUxVDBMT3hVSHBoNnhHSzUxdGhvIn0.eyJqdGkiOiJmZjlkZmQxZS1mMDJjLTRjNTAtOTcwMi1lYjkxYTEzMGY5YmUiLCJleHAiOjE3MTEwOTk5NzksIm5iZiI6MCwiaWF0IjoxNzExMDEzNTc5LCJpc3MiOiJodHRwczovL3BvcnRhbC5rYXJtYXlvZ2kubmljLmluL2F1dGgvcmVhbG1zL3N1bmJpcmQiLCJzdWIiOiJmOmJhYWRhOGIxLWU2MmUtNDRjNC1hMTRkLTY3MDJlYTkwZjQ5Njo2Nzc4Y2MyYi04MDc1LTQ5YTQtOWU3ZC1kZWFmYTRkMGQ5ZWYiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJhZG1pbi1jbGkiLCJhdXRoX3RpbWUiOjAsInNlc3Npb25fc3RhdGUiOiJjYWY0YTE2Ny02YjcyLTQ5Y2QtYjJlMC0xNzA3YjQyMmQ2ZTkiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbImh0dHA6Ly9sb2NhbGhvc3Q6NDIwMCJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwic2NvcGUiOiIiLCJuYW1lIjoibml0aW4ga3VtYXIgdGVzdCIsInByZWZlcnJlZF91c2VybmFtZSI6InByb2RtZG9hZG1pbl82eDRsIiwiZ2l2ZW5fbmFtZSI6Im5pdGluIGt1bWFyIHRlc3QiLCJmYW1pbHlfbmFtZSI6IiIsImVtYWlsIjoicHIqKioqKioqKioqKipAeW9wbWFpbC5jb20ifQ.BBO6no8dDwEJN14etfXDiRf8LL9VoC3mVsKUzjdfqNPLd-HHsTo_VEsDyvYE90I3-IQXPT2sotP8jHXirYYU2OcteEs5JA1mnGvjpFPA4ctCul3N4RnzrsNXiSN-fHfq4GsW8USdb3NaekoOJnqe333a4oOjJRqupLk14ruzn1XUGbER1OPa1jdHaDu7I13gZ_hHineRLF_Tg6GeN90V_NIQkjw1wyB5fOgiBbV_hAK0B4CVeDJk5yqRmxfDZrU70ymuhW47xm7JzdbjneWCA8C2MESaNar0YwQN1tqwJDwg3O9YgjRxOw3ggpK2eml1cchuimRRckTclewGVih2Ig');
      function handleMessage(res) {
        let responseData = JSON.parse(res.data);
        console.log('We got the response from the browser', JSON.stringify(responseData));
      }
    ''');
    setState(() {
      cookiesSet = true;
    });
  }
}
