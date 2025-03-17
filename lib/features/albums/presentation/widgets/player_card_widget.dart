import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';

import '../../domain/models/player.dart';

String getCountryEmoji(PlayerModel player) {
  switch (player.countryName) {
    case "Германия":
      return "🇩🇪";
    case "Шотландия":
      return "🏴󠁧󠁢󠁳󠁣󠁴󠁿";
    case "Швейцария":
      return "🇨🇭";
    case "Венгрия":
      return "🇭🇺";
    case "Испания":
      return "🇪🇸";
    case "Италия":
      return "🇮🇹";
    case "Хорватия":
      return "🇭🇷";
    case "Албания":
      return "🇦🇱";
    case "Англия":
      return "🏴󠁧󠁢󠁥󠁮󠁧󠁿";
    case "Сербия":
      return "🇷🇸";
    case "Дания":
      return "🇩🇰";
    case "Словения":
      return "🇸🇮";
    case "Франция":
      return "🇫🇷";
    case "Нидерланды":
      return "🇳🇱";
    case "Австрия":
      return "🇦🇹";
    case "Польша":
      return "🇵🇱";
    case "Бельгия":
      return "🇧🇪";
    case "Румыния":
      return "🇷🇴";
    case "Словакия":
      return "🇸🇰";
    case "Украина":
      return "🇺🇦";
    case "Португалия":
      return "🇵🇹";
    case "Турция":
      return "🇹🇷";
    case "Чехия":
      return "🇨🇿";
    case "Грузия":
      return "🇬🇪";
    default:
      return "";
  }
}

class PlayerPackCardWidget extends StatelessWidget {
  const PlayerPackCardWidget({
    required this.player,
    super.key,
  });

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final imageUrl = player.photoUrl.contains("medium") ? player.photoUrl.replaceAll("medium", "big") : player.photoUrl;

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
                child: Image(
                  image: kIsWeb ? NetworkImage(imageUrl) : NetworkImageWithRetry(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Row(
              children: [
                Text(
                  getCountryEmoji(player),
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Row(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/shirt.png")),
                  ),
                  child: SizedBox(
                    height: 32,
                    width: 32,
                    child: Center(
                      child: Text(
                        player.number.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
