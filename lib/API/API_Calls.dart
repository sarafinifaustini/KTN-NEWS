import 'dart:convert';

import 'package:ktn_news/Screens/categories/News/News.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ktn_news/Video/WebView.dart';
import 'package:ktn_news/Video/YoutubePlayer.dart';
import 'package:ktn_news/model/Category1.dart';

import 'package:http/http.dart' as http;
import 'package:ktn_news/model/video.dart';

import 'APIs.dart';

class APICalls {
  static List getVids=[];
  static String? theVideoURL;
  static Future<List<Videos>> getVideos(String detail) async {
    print(news+detail);
    try {
      final response = await http.get(Uri.parse(news+detail),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        NewsPage.playingVideo = jsonResponse[0]['id'];
        NewsPage.playingTitle = jsonResponse[0]['title'];

        getVids = jsonResponse;
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {

      throw e;
    }





  }
  static Future<List<Videos>> getFeatures() async {
    try {
      final response = await http.get(Uri.parse(features),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        NewsPage.playingVideo = jsonResponse[0]['id'];
        getVids = jsonResponse;
        // print(jsonResponse);
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {

      throw e;
    }





  }

  static Future<List<Videos>> getAllVideos() async {
    print("[[[[[[[[[[[[[[[[[[[[[[");
    // print(allNews);
    try {
      final response = await http.get(Uri.parse(news),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        getVids = jsonResponse;
        // print(jsonResponse);
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {

      throw e;
    }





  }
  static Future<Video> getVideo(int video_id) async {
    print("inside the video");
    print( video_id);
    String videoURL = "https://www.standardmedia.co.ke/farmkenya/api/ktn-home/video/$video_id";
    try {
      var result = await http.get(Uri.parse(videoURL));
      print("inside vid");

      if (result.statusCode == 200) {
        Map<String,dynamic> data = jsonDecode(result.body)['video'];
        print(data);
         Video video = Video.fromJson(data);
        print(video);
        // print("https://www.youtube.com/embed/${data['videoURL']}");
         print("getting video");
         print(video.id);
         print(video.videoURL);
         APICalls.theVideoURL = "${data['videoURL']}";
         print(APICalls.theVideoURL);
         YoutubeVideo.ID =  "${data['videoURL']}";
         // YoutubeVideo.controller!.load("${data['videoURL']}");

        // WebViewContainer.controller!.loadUrl("https://www.youtube.com/embed/${data['videoURL']}");
      print("does have data----------------");
       print(video.youtubeId);
        return video;

      } else {
        print("Error fetching video>>>>>>>>>>>>>>>>>>>>>>>>>");
        throw Exception('Could not connect.');
      }
    } catch (e) {
      throw e;
    }
  }
  static Future<List<Videos>> getSports() async {
    try {
      final response = await http.get(Uri.parse(news),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        // print(jsonResponse);
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<throwing this error $e");
      throw e;
    }
  }

  static Future<List<Videos>> getKtnLeo() async {
    try {
      final response = await http.get(Uri.parse(ktnLeo),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        // print(jsonResponse);
        // print("ndani ya mbiu ya KTN");
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }

 static Future<List<Videos>> getKtnSports() async {
    try {
      final response = await http.get(Uri.parse(ktnLeo),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        // print(jsonResponse);
        // print("ndani ya mbiu ya KTN");
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }

 static Future<List<Videos>> getKtnBusiness() async {
    try {
      final response = await http.get(Uri.parse(business),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        // print(jsonResponse);
        // print("ndani ya mbiu ya KTN");
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }

 static Future<List<Videos>> getKtnMorningExpress() async {
    try {
      final response = await http.get(Uri.parse(morningExpress),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        // print(jsonResponse);
        // print("ndani ya mbiu ya KTN");
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Videos>> getMostViewed() async {
    try {
      final response = await http.get(Uri.parse(mostViewed),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        // print(jsonResponse);
        // print("ndani ya mbiu ya KTN");
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }
    static Future<List<Videos>> getWorldNews() async {
    try {
      final response = await http.get(Uri.parse(worldNews),
          headers: <String, String>{
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body)['videos'];
        // print(jsonResponse);
        // print("ndani ya mbiu ya KTN");
        return jsonResponse
            .map((data) => new Videos.fromJson(data))
            .toList();
      } else {
        throw Exception('Unexpected error occurred !');
      }
    } catch (e) {
      throw e;
    }
  }





  static Future refreshLiveStream(context) async {
    // print("in refresh");
    return getVideos;
  }
}


