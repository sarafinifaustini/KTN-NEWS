import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/API/APIs.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_Business.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_Sports.dart';
import 'package:ktn_news/Screens/categories/liveStream/KTN_morning.dart';
import 'package:ktn_news/Screens/categories/liveStream/ktn_leo.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:http/http.dart' as http;
import 'package:ktn_news/Fonts/fonts.dart';

import '../../../constants.dart';

class LiveStreamPage extends StatefulWidget {
  static String? playingVideo;
  static String? liveThumb;
  @override
  _LiveStreamPageState createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {

  void initState() {
    super.initState();
    APICalls.refreshLiveStream(context);
    getVideos();
  }
List mainVideos =[];
  Future<List<Videos>> getVideos() async {
    try {
      final response = await http.get(Uri.parse(news),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        mainVideos =jsonResponse;
        LiveStreamPage.liveThumb = mainVideos[0][' thumbnail'];
        // print(jsonResponse);
        return jsonResponse.map((data) => new Videos.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () => APICalls.refreshLiveStream(context),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
           height: size.height*0.4,
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context,index)=>GestureDetector(
                      onTap: (){},
                      child: Column(
                        children: [
                          Container(
                            height: size.height *0.35,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.grey.shade800,
                                      Colors.black.withOpacity(0.0),
                                    ],
                                    end: Alignment.topCenter,
                                    begin: Alignment.bottomCenter)),
                            child:Image.network(LiveStreamPage.liveThumb!,
                              fit: BoxFit.fitWidth,
                              width: size.width,
                              height: size.height,
                              filterQuality: FilterQuality.high,
                            ),
                          ),


                          Container(
                            color: Colors.grey.shade800,
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:0),
                                    child: Text("Now Playing",style: CustomTextStyle.display3(context),),
                                  ),
                                  Text(LiveStreamPage.playingVideo!,style: CustomTextStyle.display4(context),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder<List<Videos>>(
                      future: APICalls.getVideos(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Oops! Something went wrong'),
                          );
                        }
                        if (snapshot.hasData) {
                          List<Videos>? data = snapshot.data;

                          return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Text(
                                          "More Videos",
                                          style: CustomTextStyle.display1(context),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: kDefaultPadding / 2),
                                        height: size.height * 0.28,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: data!.length,
                                          itemBuilder: (context, index) =>
                                              GestureDetector(
                                            onTap: () {
                                              print("tapped");
                                              setState(() {
                                                print( LiveStreamPage.liveThumb);
                                               LiveStreamPage.liveThumb = data[index].thumbnail;
                                               print( LiveStreamPage.liveThumb);
                                              });
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
                                                children: List.generate(data.length,
                                                    (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      // height: size.height*0.16,
                                                      width: size.width * 0.7,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: size.width,
                                                            margin: EdgeInsets.only(
                                                                right: 8),
                                                            // width: 160,
                                                            height: 160,
                                                            child: Image.network(
                                                              data[index].thumbnail!,
                                                              fit: BoxFit.contain,
                                                              width: size.width,
                                                              height: size.height,
                                                              filterQuality:
                                                                  FilterQuality.high,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  data[index].title!,
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
                                      KTNLeoPage(),
                                      KTNSportsSection(),
                                      KTNBusinessSection(),
                                      KTNMESection(),
                                    ],
                                  )
                                ],
                              ));
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
