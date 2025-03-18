import 'package:flutter/material.dart';

import '../../domain/models/player.dart';

class SavedPlayerCard extends StatelessWidget {
  const SavedPlayerCard({
    required this.player,
    super.key,
  });

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // final imageUrl = player.photoUrl.contains("medium") ? player.photoUrl.replaceAll("medium", "big") : player.photoUrl;

    return Container(
      height: 300,
      width: 200,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 30,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Image.asset(
                  "assets/raster/player_faces/${player.id}.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: CircleAvatar(
              radius: 15,
              foregroundImage: AssetImage('assets/raster/team_flags/${player.countryId}.png'),
            ),
          ),
          // Positioned(
          //   top: 5,
          //   right: 5,
          //   child: Row(
          //     children: [
          //       DecoratedBox(
          //         decoration: const BoxDecoration(
          //           image: DecorationImage(image: AssetImage("assets/shirt.png")),
          //         ),
          //         child: SizedBox(
          //           height: 32,
          //           width: 32,
          //           child: Center(
          //             child: Text(
          //               player.number.toString(),
          //               style: const TextStyle(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Center(
                        child: Text(
                          player.position,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: BorderDirectional(top: BorderSide()),
                  ),
                  child: SizedBox(
                    width: mq.size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        player.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
