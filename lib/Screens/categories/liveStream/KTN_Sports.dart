import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/API/APIs.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:http/http.dart' as http;
import 'package:ktn_news/Fonts/fonts.dart';

import '../../../constants.dart';

class KTNSportsSection extends StatefulWidget {
  @override
  _KTNSportsSectionState createState() => _KTNSportsSectionState();
}


class _KTNSportsSectionState extends State<KTNSportsSection> {

  void initState() {
    super.initState();
    APICalls.refreshLiveStream(context);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<Videos>>(
        future: APICalls.getKtnSports(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Oops! Something went wrong'),
            );
          }
          if (snapshot.hasData) {
            List<Videos>? data = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "KTN Sports",style: CustomTextStyle.display1(context),

                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  height: size.height*0.28,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder:(context, index) => GestureDetector(
                      onTap: () {
                        print("tapped");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => VideoDetailPage(
                        //             videoUrl:
                        //             "assets/videos/video_1.mp4")));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: List.generate(data.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // height: size.height*0.16,
                                width: size.width*0.7,
                                child: Column(
                                  children: [
                                    Container(
                                      width:size.width,
                                      margin: EdgeInsets.only(right: 8),
                                      // width: 160,
                                      height: 160,
                                      child: Image.network(data[index].thumbnail!,
                                        fit:BoxFit.contain,
                                        width: size.width,
                                        height: size.height,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(data[index].title!,
                                            // style: CustomTextStyle.display1(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget latestStories() {
    Size size = MediaQuery.of(context).size;
    Videos videos;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: GestureDetector(
        onTap: () {
          print("tapped");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => VideoDetailPage(
          //             videoUrl:
          //             "assets/videos/video_1.mp4")));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: List.generate(10, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.cover)),
                    ),
                    Text("videos[0].title"),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
