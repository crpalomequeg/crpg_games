import 'package:meta/meta.dart';
import 'dart:convert';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class GameModel {
  GameModel({
    required this.id,
    required this.category,
    required this.cover,
    required this.createdAt,
    required this.firstReleaseDate,
    required this.screenshots,
    required this.genres,
    required this.name,
    required this.platforms,
    required this.slug,
    required this.status,
    required this.summary,
    required this.checksum,
  });

  int id;
  int category;
  int cover;
  int createdAt;
  int firstReleaseDate;
  List<Screenshot> screenshots;
  List<int> genres;
  String name;
  List<int> platforms;
  String slug;
  int status;
  String summary;
  String checksum;

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
    id: json["id"],
    category: json["category"],
    cover: json["cover"] ?? 0,
    createdAt: json["created_at"],
    firstReleaseDate: json["first_release_date"] ?? 0,
    screenshots: json["screenshots"] != null ? List<Screenshot>.from(json["screenshots"].map((x) => Screenshot.fromJson(x))) : [],
    genres: json["genres"] != null ? List<int>.from(json["genres"].map((x) => x)) : [],
    name: json["name"],
    platforms: json["platforms"] != null ? List<int>.from(json["platforms"].map((x) => x)) : [],
    slug: json["slug"],
    status: json["status"] ?? 0,
    summary: json["summary"] ?? "",
    checksum: json["checksum"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "cover": cover,
    "created_at": createdAt,
    "first_release_date": firstReleaseDate,
    "screenshots": List<dynamic>.from(screenshots.map((x) => x.toJson())),
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "name": name,
    "platforms": List<dynamic>.from(platforms.map((x) => x)),
    "slug": slug,
    "status": status,
    "summary": summary,
    "checksum": checksum,
  };
}



class Screenshot {
  Screenshot({
    required this.id,
    required this.game,
    required this.height,
    required this.imageId,
    required this.url,
    required this.width,
    required this.checksum,
  });

  int id;
  int game;
  int height;
  String imageId;
  String url;
  int width;
  String checksum;

  factory Screenshot.fromJson(Map<String, dynamic> json) => Screenshot(
    id: json["id"],
    game: json["game"],
    height: json["height"],
    imageId: json["image_id"],
    url: json["url"],
    width: json["width"],
    checksum: json["checksum"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "game": game,
    "height": height,
    "image_id": imageId,
    "url": url,
    "width": width,
    "checksum": checksum,
  };
}
