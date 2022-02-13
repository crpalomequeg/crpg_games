
import 'package:crpg_games/models/game_model.dart';
import 'package:crpg_games/models/genre_model.dart';
import 'package:crpg_games/pages/game_detail_page.dart';
import 'package:crpg_games/ui/widgets/item_filter_genre_widget.dart';
import 'package:crpg_games/ui/widgets/item_game_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:crpg_games/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List games = [];
  List gamesAux = [];
  final APIServices _apiServices = APIServices();

  ScrollController _scrollController = ScrollController();

  List genres = [];
  String genre = "";

  int indexGenre = 0;

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    _apiServices.getGameList(0).then((value) {});
  }

  filterGames(int idGenre) {
    games = gamesAux;
    if (indexGenre != 0) {
      games =
          games.where((element) => element.genres == idGenre).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff18162E),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Games",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                  future: _apiServices.getGenreList(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<GenreModel> listGenre = snap.data;
                      return SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: listGenre.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemFilterGenreWidget(
                              title: listGenre[index].name,
                              selected: indexGenre == index ? true : false,
                              onSelected: () {
                                indexGenre = index;
                                filterGames(listGenre[index].id);
                                // categoryTitle = categories[index].description;
                                setState(() {});
                              },
                            );
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                FutureBuilder(
                  future: _apiServices.getGameList(indexGenre),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<GameModel> listGame = snap.data;
                      return ListView.builder(
                        // itemCount: movies.length,
                        itemCount: listGame.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ItemGameListWidget(
                            name: listGame[index].name,
                            // image: "https://images.igdb.com/igdb/image/upload/t_720p/nf6v8ax7nhzvr98qpoop.jpg",
                            image: "https:${listGame[index].screenshots[0].url.toString().replaceAll("t_thumb", "t_720p") }",
                            summary: listGame[index].summary,
                            first_release_date: listGame[index].firstReleaseDate.toString(),
                            status:
                            listGame[index].status.toString(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => GameDetailPage(
                                  //   id: listMovie[index].id,
                                  // ),
                                  builder: (context) => GameDetailPage(game: listGame[index]),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
