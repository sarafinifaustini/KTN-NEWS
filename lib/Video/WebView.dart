// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:ktn_news/Screens/LandingPage.dart';
// import 'package:ktn_news/Screens/categories/News/News.dart';
// import 'package:ktn_news/Screens/categories/liveStream/LiveStream.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';
//
// class WebViewContainer extends StatefulWidget {
//   final String url;
// static  WebViewController? controller;
//    WebViewContainer(this.url);
//
//   @override
//   createState() => _WebViewContainerState();
// }
//
// class _WebViewContainerState extends State<WebViewContainer>
//     with WidgetsBindingObserver {
//   final controller = ScrollController();
//
//   final _key = UniqueKey();
//   bool isScreenVisible = true;
//   int timeout = 5;
//   var screenHeight;
//   var cHeight;
//   theUrl() async{
//     String url = widget.url;
//     try {
//       http.Response response = await http.get(Uri.parse(url)).
//       timeout(Duration(seconds: timeout));
//       if (response.statusCode == 200) {
//         url = widget.url;
//         // do something
//       } else {
//       }
//     } on TimeoutException catch (e) {
//       print('Timeout Error: $e');
//     } on SocketException catch (e) {
//       print('Socket Error: $e');
//     } on Error catch (e) {
//       print('General Error: $e');
//     }
//     return url;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("inside web view");
//     print(widget.url);
//     return isScreenVisible
//         ? AspectRatio(
//           aspectRatio: 1,
//           child: Theme(
//             data: new ThemeData(textTheme: TextTheme(
//               bodyText1: GoogleFonts.inter(
//                 color: Colors.grey.shade900,
//                 fontSize: 5,
//             ),
//             ),
//             ),
//             child: WebView(
//               key: _key,
//               javascriptMode: JavascriptMode
//                   .unrestricted,
//               initialUrl:widget.url,
//               onWebViewCreated: (controller) {
//               WebViewContainer.controller = controller;
//               },
//             ),
//           ),
//         )
//       : Container(
//         color: Colors.transparent,
//     );
//   }
//
//     @override
//     void initState() {
//     super.initState();
//     // controller.addListener((onScroll));
//     WidgetsBinding.instance!.addObserver(this);
//
//     }
//   // onScroll() {
//   //   if (controller.position.atEdge) {
//   //     if (controller.position.pixels == 0) {
//   //       //if at the top
//   //       print("at the top");
//   //
//   //     }
//   //     //else if at bottom
//   //   } else {
//   //     print("not at top");
//   //     setState(() {
//   //
//   //     });
//   //   }
//   // }
//   @override
//   void dispose() {
//     // controller.removeListener(onScroll);
//     if(isScreenVisible = false) {
//       WidgetsBinding.instance!.removeObserver(this);
//     }
//       super.dispose();
//
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       if(this.mounted){
//       setState(() {
//         isScreenVisible = true;
//         print("screen is visible");
//       });
//       }
//       // WebViewContainer.controller?.reload();
//     } else {
//       setState(() {
//         isScreenVisible = false;
//         print("screen is not visible");
//       });
//     }
//   }
//
// }
