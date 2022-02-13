import 'package:crpg_games/ui/general/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemGameListWidget extends StatelessWidget {

  String name;
  String image;
  String summary;
  String first_release_date;
  String status;
  Function onTap;

  ItemGameListWidget({
    required this.name,
    required this.image,
    required this.summary,
    required this.first_release_date,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 340,
        margin: EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: COLOR_PRIMARY.withOpacity(0.06),
              blurRadius: 12,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        image,
                      ),
                    ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),

              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10.0),
                // color: Colors.redAccent,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: COLOR_PRIMARY,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    DateTime.fromMillisecondsSinceEpoch(int.parse(first_release_date) * 1000).toString().substring(0,10),
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    status,
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            summary,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}