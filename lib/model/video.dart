class Video {
  int? id;
  int? categoryid;
  String? title;
  String? videoURL;
  DateTime? publishdate;
  String? thumbnail;

  Video(
      {this.id,
        this.categoryid,
        this.title,
        this.publishdate,

        this.thumbnail,
        videoURL}) {
    this.videoURL = "https://www.youtube.com/embed/$videoURL";
  }

  Video.fromJson(Map<String, dynamic> Json) {
    id = Json['id'];
    categoryid = Json['categoryid'];
    title = Json['title'];
    videoURL = "https://www.youtube.com/embed/${Json['videoURL']}";
    thumbnail=Json['thumbnail'];
    publishdate = DateTime.parse(Json['publishdate']);

  }

}
