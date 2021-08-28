import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ktn_news/Screens/LandingPage.dart';
import 'package:ktn_news/Screens/LifeCycleManager.dart';
import 'package:ktn_news/Video/YoutubePlayer.dart';
import 'package:provider/provider.dart';
import 'Screens/categories/News/PlayingVideo.dart';
import 'Theme/theme.dart';
import 'Video/MainVideo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
      AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MultiProvider(
            providers: [
              // ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
              ChangeNotifierProvider(create: (context) => ThemeProvider()),
              // ChangeNotifierProvider(create: (context) => EmailSignInProvider()),
            ],
            child: Builder(
                builder: (context) {
                  // final themeProvider = Provider.of<ThemeProvider>(context);

                  return MaterialApp(
                    title: 'KTN NEWS',
                    debugShowCheckedModeBanner: false,
                    theme: MyThemes.lightTheme,
                    darkTheme: MyThemes.darkTheme,
                    home: LandingPage(),
                  );
                })),
    );
  }
}
