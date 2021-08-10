import 'dart:convert';

import 'package:ktn_news/model/Category1.dart';

import 'package:http/http.dart' as http;

import 'APIs.dart';

class APICalls {
  static List getVids=[];
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





  static Future refreshLiveStream(context) async {
    // print("in refresh");
    return getVideos();
  }
}

