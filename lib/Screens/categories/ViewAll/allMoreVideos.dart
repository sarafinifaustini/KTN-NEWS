import 'package:flutter/material.dart';
import 'package:ktn_news/API/API_Calls.dart';
import 'package:ktn_news/Screens/LifeCycleManager.dart';
import 'package:ktn_news/Screens/categories/News/News.dart';
import 'package:ktn_news/Video/MainVideo.dart';
import 'package:ktn_news/Video/WebView.dart';
import 'package:ktn_news/model/Category1.dart';
import 'package:ktn_news/model/video.dart';

class AllMoreVideos extends StatefulWidget {
  static String theTitle ="The Eagle has landed";
  @override
  _AllMoreVideosState createState() => _AllMoreVideosState();
}

class _AllMoreVideosState extends State<AllMoreVideos> {
  Video? video;

  refreshAction() {
    setState(() {
      APICalls.getVideo(NewsPage.playingVideo!);
      print("here");

      // _response = http.read(dadJokeApi, headers: httpHeaders);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<List<Videos>>(
          future: APICalls.getAllVideos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Oops! Something went wrong'),
              );
            }
            if (snapshot.hasData) {
              List<Videos>? data = snapshot.data;
              return DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: SliverSafeArea(
                              top: false,
                              sliver: SliverAppBar(

                                  ///Properties of app bar
                                  backgroundColor: Colors.white,
                                  floating: true,
                                  pinned: true,
                                  // expandedHeight: 200.0,
                                  title: Text("More Videos"),
                                  bottom: TabBar(
                                      indicatorColor:
                                          Theme.of(context).backgroundColor,
                                      tabs: [
                                        Tab(
                                          text: "KTN Prime",
                                        ),
                                        Tab(text: "Popular Shows")
                                      ])))),
                    ];
                  },
                  body:

                  CustomScrollView(
                    slivers:[
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        NewsPage.playingVideo = null;
                                        NewsPage.playingVideo = data![index].id;
                                        AllMoreVideos.theTitle = data[index].title!;
                                        print(data[index].title);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) {
                                                  return MainVideo();
                                                }));
                                      },
                                      child: Container(
                                        width: size.width,
                                        margin: EdgeInsets.only(right: 8),
                                        // width: 160,
                                        height: 80,
                                        child: Image.network(
                                          data![index].thumbnail!,
                                          fit: BoxFit.contain,
                                          width: size.width,
                                          height: size.height,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.end,
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
                          },
                          childCount: data!.length,
                        ),
                      ),
                    ]),
                  ),
                );
            }
            return Text("");
          }),
    );
  }
}
