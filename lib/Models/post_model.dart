import 'dart:convert';

PostModel welcomeFromJson(String str) => PostModel.fromJson(json.decode(str));

String welcomeToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    required this.by,
    required this.descendants,
    required this.id,
    required this.kids,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
    required this.url,
  });

  String by;
  int descendants;
  int id;
  List<int> kids;
  int score;
  int time;
  String title;
  String type;
  String url;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        by: json["by"],
        descendants: json["descendants"],
        id: json["id"],
        kids: List<int>.from(json["kids"].map((x) => x)),
        score: json["score"],
        time: json["time"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "by": by,
        "descendants": descendants,
        "id": id,
        "kids": List<dynamic>.from(kids.map((x) => x)),
        "score": score,
        "time": time,
        "title": title,
        "type": type,
        "url": url,
      };
}
