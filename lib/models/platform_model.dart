// To parse this JSON data, do
//
//     final platformModel = platformModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlatformModel platformModelFromJson(String str) => PlatformModel.fromJson(json.decode(str));

String platformModelToJson(PlatformModel data) => json.encode(data.toJson());

class PlatformModel {
  PlatformModel({
    required this.id,
    required this.name,
    required this.platformLogo,
  });

  int id;
  String name;
  PlatformLogo platformLogo;

  factory PlatformModel.fromJson(Map<String, dynamic> json) => PlatformModel(
    id: json["id"],
    name: json["name"],
    platformLogo: PlatformLogo.fromJson(json["platform_logo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "platform_logo": platformLogo.toJson(),
  };
}

class PlatformLogo {
  PlatformLogo({
    required this.id,
    required this.url,
  });

  int id;
  String url;

  factory PlatformLogo.fromJson(Map<String, dynamic> json) => PlatformLogo(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
