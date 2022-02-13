import 'dart:convert';

import 'package:crpg_games/models/game_model.dart';
import 'package:crpg_games/models/genre_model.dart';
import 'package:crpg_games/models/platform_model.dart';
import 'package:crpg_games/utils/constants.dart';
import 'package:http/http.dart' as http;

class APIServices {

  Future<List<GameModel>> getGameList(int genre) async {
    List<GameModel> games = [];
    String path = "$pathProduction/games";
    String iniQuery = "fields category, cover, created_at, first_release_date, genres, name, platforms, slug, status, summary, checksum, screenshots.*; where first_release_date != null & genres != null & screenshots != null & first_release_date > 1538129354 & status > 0 & status < 6 & platforms != null ";
    if (genre != 0) {
      iniQuery += " & genres = (${genre.toString()})";
    }
    Uri _uri = Uri.parse(path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Client-ID": clientId,
        "Authorization": "Bearer 8nywmj4eauncf7dcvmr9lpe3fdvpih",
      },
      body: "$iniQuery; limit 20;",
    );
    if (response.statusCode == 200) {
      List<dynamic> myList = json.decode(response.body);
      myList.forEach((element) {
        games.add(GameModel.fromJson(element));
      });
      return games;
    }
    return games;
  }

  Future<List<GenreModel>> getGenreList() async {
    List<GenreModel> genres = [];
    String path = "$pathProduction/genres";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Client-ID": clientId,
        "Authorization": "Bearer 8nywmj4eauncf7dcvmr9lpe3fdvpih",
      },
      body: "fields *;",
    );
    if (response.statusCode == 200) {
      List<dynamic> myList = json.decode(response.body);
      genres.add(GenreModel(id: 0,name: "All"));
      myList.forEach((element) {
        genres.add(GenreModel.fromJson(element));
      });
      return genres;
    }
    return genres;
  }

  Future<List<PlatformModel>> getPlatformList(String platformsId) async {
    List<PlatformModel> platforms = [];
    String path = "$pathProduction/platforms";
    String iniQuery = "fields id, name, platform_logo.*; ";
    if (platformsId != "") {
      iniQuery += " where id = ($platformsId); ";
    }
    print("$iniQuery limit 20;");
    Uri _uri = Uri.parse(path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Client-ID": clientId,
        "Authorization": "Bearer 8nywmj4eauncf7dcvmr9lpe3fdvpih",
      },
      body: "$iniQuery limit 20;",
    );
    if (response.statusCode == 200) {
      List<dynamic> myList = json.decode(response.body);
      myList.forEach((element) {
        platforms.add(PlatformModel.fromJson(element));
      });
      // print(platforms);
      return platforms;
    }
    return platforms;
  }


}