// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class _WebViewStackState extends State<WebViewStack> {
//   var loadingPercentage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.controller
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             setState(() {
//               loadingPercentage = 0;
//             });
//           },
//           onProgress: (progress) {
//             setState(() {
//               loadingPercentage = progress;
//             });
//           },
//           onPageFinished: (url) {
//             setState(() {
//               loadingPercentage = 100;
//             });
//           },
//           onNavigationRequest: (navigation) {
//             final host = Uri.parse(navigation.url).host;
//             if (host.contains('youtube.com')) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Blocking navigation to $host',
//                   ),
//                 ),
//               );
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..setJavaScriptMode(JavaScriptMode.unrestricted);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         WebViewWidget(
//           controller: widget.controller,
//         ),
//         if (loadingPercentage < 100)
//           LinearProgressIndicator(
//             value: loadingPercentage / 100.0,
//           ),
//       ],
//     );
//   }
// }