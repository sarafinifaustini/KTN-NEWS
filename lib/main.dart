import 'package:flutter/material.dart';
import 'package:ktn_news/Screens/LandingPage.dart';
import 'package:provider/provider.dart';
import 'Theme/theme.dart';
import 'Video/MainVideo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
      MultiProvider(
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
              }));
}