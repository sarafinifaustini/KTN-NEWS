import 'dart:convert';

import 'package:ktn_news/Video/WebView.dart';
import 'package:ktn_news/model/Category1.dart';

import 'package:http/http.dart' as http;
import 'package:ktn_news/model/video.dart';

import 'APIs.dart';

class APICalls {
  static List getVids=[];
  static String? videoURL;
  static Future<List<Videos>> getVideos() async {
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
    String videoURL = "https://www.standardmedia.co.ke/farmkenya/api/ktn-home/video/$video_id";
    try {
      var result = await http.get(Uri.parse(videoURL));
      print("inside vid");

      if (result.statusCode == 200) {
        Map<String,dynamic> data = jsonDecode(result.body)['video'];
         Video video = Video.fromJson(data);
        print(data);
        print("https://www.youtube.com/embed/${data['videoURL']}");
         print("getting video");
        WebViewContainer.controller!.loadUrl("https://www.youtube.com/embed/${data['videoURL']}");
        return video;
      } else {
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
    return getVideos();
  }
}


