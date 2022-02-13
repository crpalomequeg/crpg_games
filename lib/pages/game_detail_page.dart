import 'package:crpg_games/models/game_model.dart';
import 'package:crpg_games/models/platform_model.dart';
import 'package:crpg_games/services/api_services.dart';
import 'package:crpg_games/ui/general/colors.dart';
import 'package:flutter/material.dart';

class GameDetailPage extends StatelessWidget {

  GameModel game;

  GameDetailPage({required this.game});

  APIServices _apiServices = APIServices();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        // physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: COLOR_PRIMARY,
            elevation: 0,
            expandedHeight: 200.0,
            floating: false,
            snap: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  game.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https:${game.screenshots[0].url.toString().replaceAll("t_thumb", "t_720p") }",
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x0018162E),
                            COLOR_PRIMARY,
                          ],
                        )),
                  ),
                ],
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: COLOR_PRIMARY,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      "Released At: ${DateTime.fromMillisecondsSinceEpoch(game.firstReleaseDate * 1000).toString().substring(0,10)}",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      "Created At: ${DateTime.fromMillisecondsSinceEpoch(game.createdAt * 1000).toString().substring(0,10)}",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      "Rate: ${game.status.toString()}",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
                  child: Text(
                    game.summary,
                    style:
                    TextStyle(color: COLOR_PRIMARY, fontSize: 14.0),
                  ),
                ),

                Divider(
                  color: Colors.black.withOpacity(0.07),
                  thickness: 2.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),

                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Plataforms",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: COLOR_PRIMARY,
                    ),
                  ),
                ),

                FutureBuilder(
                  future: _apiServices.getPlatformList(game.platforms.join(',')),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<PlatformModel> platformList = snap.data;
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: platformList
                              .map<Widget>(
                                (e) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(60.0),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          //  "http://image.tmdb.org/t/p/w500${e.platformLogo.url}")
                                          "https:${e.platformLogo.url}")


                                    ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Text(
                                    e.name,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                              .toList(),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),

                Divider(
                  color: Colors.black.withOpacity(0.07),
                  thickness: 2.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),

                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Screenshots",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: COLOR_PRIMARY,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: game.screenshots.map((e) =>
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: NetworkImage("https:${e.url.toString().replaceAll("t_thumb", "t_720p") }"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12.0),


                          ),
                          width: 150,
                          height: 100,
                        )).toList(),
                  ),
                ),


                // ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //   shrinkWrap: true,
                //   physics: const BouncingScrollPhysics(),
                //   itemCount: game.screenshots.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return Text("hola");
                //   },
                // ),

                const SizedBox(
                  height: 50.0,
                ),

              ],
            ),
          ),
        ],
      ),



    );
  }
}
