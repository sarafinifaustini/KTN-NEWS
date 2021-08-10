
class Videos {
  int? id;
  int? categoryid;
  String? title;
  String? videoURL;
  String? publishdate;
  String? keywords;
  String? thumbnail;

  Videos(
      {this.id,
        this.categoryid,
        this.title,
        this.videoURL,
        this.publishdate,
        this.keywords,
        this.thumbnail});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryid = json['categoryid'];
    title = json['title'];
    videoURL = json['videoURL'];
    publishdate = json['publishdate'];
    keywords = json['keywords'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryid'] = this.categoryid;
    data['title'] = this.title;
    data['videoURL'] = this.videoURL;
    data['publishdate'] = this.publishdate;
    data['keywords'] = this.keywords;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
