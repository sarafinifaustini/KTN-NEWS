// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ktn_news/GA/dialogManager.dart';
import 'package:ktn_news/Screens/LandingPage.dart';
import 'package:ktn_news/Screens/LifeCycleManager.dart';
import 'package:ktn_news/SplashScreen.dart';
import 'package:ktn_news/Video/MainWebView.dart';
import 'package:provider/provider.dart';
import 'GA/Google_analytics.dart';
import 'GA/locator.dart';
import 'generateRoute.dart' as router;
// import 'package:get/get.dart';
import 'Services/Navigation.dart';
import 'Services/dialog.dart';
import 'Theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  setupLocator();
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
                    builder: (context, child) => Navigator(
                      key: locator<DialogService>().dialogNavigationKey,
                      onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => DialogManager(child: child)),
                    ),
                    navigatorKey: locator<NavigationService>().navigationKey,
                    // navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],
                    debugShowCheckedModeBanner: false,
                    title: "KTN_NEWS",
                    // themeMode: themeProvider.themeMode,
                    theme: MyThemes.lightTheme,
                    darkTheme: MyThemes.darkTheme,
                    localeResolutionCallback:
                        (Locale locale, Iterable<Locale> supportedLocales) {
                      //print("change language");
                      return locale;
                    },
                    // home:App(),
                    home:Splash(),
                     onGenerateRoute: router.generateRoute,
                    // initialRoute: HomeViewRoute,
                  );

                })),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'liveStreamVideo/Page/basics_page.dart';
// import 'liveStreamVideo/Page/orientation_page.dart';
//
// final urlLandscapeVideo =
//     'https://www.youtube.com/embed/live_stream?channel=UCKVsdeoHExltrWMuK0hOWmg&rel=0&autoplay=1';
// final urlPortraitVideo =
//     'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
// final urlYoutubeVideo = 'https://www.youtube.com/watch?v=wuh6YqcQgmM';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//     debugShowCheckedModeBanner: false,
//     title: 'Video Player',
//     theme: ThemeData(
//       primaryColor: Colors.blueAccent,
//       scaffoldBackgroundColor: Colors.black,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       colorScheme: ColorScheme.dark(),
//     ),
//     home: MainPage(),
//   );
// }
//
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   int index = 0;
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     // bottomNavigationBar: buildBottomBar(),
//     body: OrientationPage(),
//   );
//
//   Widget buildBottomBar() {
//     final style = TextStyle(color: Colors.white);
//
//     return BottomNavigationBar(
//       backgroundColor: Theme.of(context).primaryColor,
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.white70,
//       currentIndex: index,
//       items: [
//         BottomNavigationBarItem(
//           icon: Text('VideoPlayer', style: style),
//           title: Text('Basics'),
//         ),
//         BottomNavigationBarItem(
//           icon: Text('VideoPlayer', style: style),
//           title: Text('Orientation'),
//         ),
//       ],
//       onTap: (int index) => setState(() => this.index = index),
//     );
//   }
//
//   Widget buildPages() {
//     switch (index) {
//       case 0:
//         return BasicsPage();
//       case 1:
//         return OrientationPage();
//       default:
//         return Container();
//     }
//   }
// }