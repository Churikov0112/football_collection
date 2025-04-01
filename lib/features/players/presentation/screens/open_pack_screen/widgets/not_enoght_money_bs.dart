import 'package:flutter/material.dart';
import 'package:football_collection/features/players/domain/models/pack.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

class NotEnoghtMoneyBottomSheet extends StatelessWidget {
  const NotEnoghtMoneyBottomSheet({
    required this.pack,
    super.key,
  });

  final PackModel pack;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text("You have not enought 🏆 to buy pack"),
          const SizedBox(height: 20),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.push(RoutePaths.miniGames);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: Border.all(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Icon(Icons.games),
                        const SizedBox(height: 16),
                        Text("Play Mini-games"),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: Border.all(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16),
                        Icon(Icons.play_arrow),
                        const SizedBox(height: 16),
                        Text("Watch Ad => 100 🏆"),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mq.padding.bottom + 20)
        ],
      ),
    );
  }
}
