part of '../draft_players_screen.dart';

class _SortPlayersData {
  final List<FootballPlayerCardModel> players;
  final FootballPlayerAbstractPosition targetPosition;

  _SortPlayersData(this.players, this.targetPosition);
}

class _DraftPlayersList extends StatelessWidget {
  const _DraftPlayersList();

  // Future<List<FootballPlayerCardModel>> sortPlayersAsync(
  //   List<FootballPlayerCardModel> players,
  //   FootballPlayerAbstractPosition targetPosition,
  // ) async {
  //   return compute(_sortPlayersIsolate, _SortPlayersData(players, targetPosition));
  // }

  // List<FootballPlayerCardModel> _sortPlayersIsolate(_SortPlayersData data) {
  //   return sortPlayers(data.players, data.targetPosition);
  // }

  @override
  Widget build(BuildContext context) {
    final presenter = DraftPlayersScreenPresenter.of(context);

    // return
    // BlocBuilder<SavedCardsBloc, SavedCardsState>(
    //   bloc: getIt.get(),
    //   builder: (context, savedCardsState) {
    //     final savedCardsIds = savedCardsState.savedCardsIds ?? [];

    //     return BlocBuilder<AllFootballPlayersBloc, AllFootballPlayersState>(
    //       bloc: getIt.get(),
    //       builder: (context, allFootballPlayersState) {
    //         final allPlayersCards = allFootballPlayersState.allPlayers ?? [];
    //         final savedPlayersCards = allPlayersCards.where((player) => savedCardsIds.contains(player.cardId)).toList();
    //         final playersIdsToExclude = presenter.widget.args.playersIdsToExclude;
    //         final filteredCards = savedPlayersCards.where((p) => !playersIdsToExclude.contains(p.id)).toList();
    //         // final sortedPlayers = sortPlayers(filteredCards, presenter.widget.args.position);

    //         return FutureBuilder<List<FootballPlayerCardModel>>(
    //           future: sortPlayersAsync(filteredCards, presenter.widget.args.position),
    //           builder: (context, snapshot) {
    //             if (snapshot.connectionState == ConnectionState.waiting) {
    //               return const Center(child: CircularProgressIndicator());
    //             }

    //             if (snapshot.hasError) {
    //               return const Center(child: Text('Ошибка загрузки'));
    //             }

    //             final sortedPlayers = snapshot.data ?? [];

    final draftPlayers = presenter.widget.args.draftPlayers;
    final playersIdsToExclude = presenter.widget.args.playersIdsToExclude;
    final draftPlayersAfterExclude = draftPlayers.where((p) => !playersIdsToExclude.contains(p.playerId)).toList();
    draftPlayersAfterExclude.sort((p1, p2) {
      final p1Rating =
          ratings[p1.playerId]?["overall"] ?? 0; // FootballPlayerStatsCalculator.calculateStats(p1).rating;
      final p2Rating =
          ratings[p2.playerId]?["overall"] ?? 0; // FootballPlayerStatsCalculator.calculateStats(p2).rating;
      return p2Rating.compareTo(p1Rating);
    });

    if (draftPlayersAfterExclude.isEmpty) {
      return const Center(child: Text('Нет сохраненных игроков'));
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8),
      itemCount: draftPlayersAfterExclude.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final player = draftPlayersAfterExclude[index];
        return _DraftFootballPlayerListTile(player: player);
      },
    );
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
  }
}

class _DraftFootballPlayerListTile extends StatelessWidget {
  const _DraftFootballPlayerListTile({required this.player});

  final FootballPlayerCardModel player;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const playerPhotoAspectRatio = 4 / 3; // height / width
    final playerPhotoWidth = size.width * 0.3;
    final playerPhotoHeight = playerPhotoWidth * playerPhotoAspectRatio;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TouchableScale(
          isActive: player.position != null,
          onPressed: () {
            final stats = ratings[player.playerId]; // FootballPlayerStatsCalculator.calculateStats(player);
            if (stats == null) {
              return;
            }
            final playerGameModel = FootballPlayerGameModel(
              id: player.playerId,
              card: player,
              stats: FootballPlayerStats.fromJson(stats),
            );
            context.pop(playerGameModel);
          },
          child: DraftFootballPlayerCardWidget(player: player, height: playerPhotoHeight + 60, width: playerPhotoWidth),
        ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     SizedBox(
        //       width: playerPhotoWidth,
        //       height: playerPhotoHeight,
        //       child: DecoratedBox(
        //         decoration: BoxDecoration(
        //           borderRadius: const BorderRadius.all(Radius.circular(16)),
        //           border: Border.all(color: Colors.white10),
        //           image: DecorationImage(image: AssetImage(player.imageAssetPath), fit: BoxFit.cover),
        //         ),
        //       ),
        //     ),
        //     if (player.position != null) ...[
        //       const SizedBox(height: 8),
        //       Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           DecoratedBox(
        //             decoration: BoxDecoration(
        //               color: player.position?.role?.color ?? Colors.purple,
        //               borderRadius: const BorderRadius.all(Radius.circular(8)),
        //             ),
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 8),
        //               child: Center(
        //                 child: Text(player.position!.originalName, style: const TextStyle(color: Colors.white)),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ],
        // ),
        // const SizedBox(height: 8),

        // Expanded(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: [
        //       TeamLogoWidget(
        //         teamId: player.teamId,
        //         size: 32,
        //       ),
        // if (playerCard.currentClub != null) ...[
        //   const SizedBox(height: 8),
        //   Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Flexible(child: Text("club:", maxLines: 1)),
        //       const SizedBox(width: 8),
        //       RoundedContainer(text: playerCard.currentClub!),
        //     ],
        //   ),
        // ],
        //       if (player.foot != null) ...[
        //         const SizedBox(height: 8),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             const Flexible(child: Text("foot:", maxLines: 1)),
        //             const SizedBox(width: 8),
        //             FootRoundedContainer(text: player.foot!),
        //           ],
        //         ),
        //       ],
        //       if (player.height != null) ...[
        //         const SizedBox(height: 8),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             const Flexible(child: Text("height:", maxLines: 1)),
        //             const SizedBox(width: 8),
        //             RoundedContainer(text: "${player.height} cm"),
        //           ],
        //         ),
        //       ],
        //       if (player.maxMarketValue != null) ...[
        //         const SizedBox(height: 8),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             const Flexible(child: Text("prime:", maxLines: 1)),
        //             const SizedBox(width: 8),
        //             RoundedContainer(text: beautifyTransferValue(player.maxMarketValue!)),
        //           ],
        //         ),
        //       ],
        //       if (player.currentMarketValue != null) ...[
        //         const SizedBox(height: 8),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             const Flexible(child: Text("current:", maxLines: 1)),
        //             const SizedBox(width: 8),
        //             RoundedContainer(text: beautifyTransferValue(player.currentMarketValue!)),
        //           ],
        //         ),
        //       ],
        //     ],
        //   ),
        // ),
        const SizedBox(height: 8),
        // const Spacer(),
        TouchableScale(
          isActive: player.position != null,
          onPressed: () {
            BottomSheetController.showBottomSheet(context, (context) => FootballPlayerScreen(player: player));
          },
          child: SizedBox(
            width: playerPhotoWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white10),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.info_outline, size: 20, color: Colors.white60),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<FootballPlayerCardModel> sortPlayers(
  List<FootballPlayerCardModel> players,
  FootballPlayerAbstractPosition targetPosition, {
  double positionWeight = 0.9,
  double currentValueWeight = 0.06,
  double maxValueWeight = 0.04,
}) {
  if (players.isEmpty) {
    return players;
  }

  // Нормализуем веса один раз
  final totalWeight = positionWeight + currentValueWeight + maxValueWeight;
  final normalizedPositionWeight = positionWeight / totalWeight;
  final normalizedCurrentValueWeight = currentValueWeight / totalWeight;
  final normalizedMaxValueWeight = maxValueWeight / totalWeight;

  // Кэшируем вычисления весов позиций
  final positionWeightsCache = <FootballPlayerAbstractPosition, double>{};
  for (final player in players) {
    final position = FootballPlayerAbstractPosition.fromString(player.position);
    if (position != null) {
      positionWeightsCache[position] ??= PositionWeights.getWeight(targetPosition, position);
    }
  }

  // Находим максимальные значения один раз
  int maxCurrentValue = 0;
  int maxMaxValue = 0;

  for (final player in players) {
    if ((player.marketValue ?? 0) > maxCurrentValue) {
      maxCurrentValue = player.marketValue ?? 0;
    }
    if ((player.maxMarketValue ?? 0) > maxMaxValue) {
      maxMaxValue = player.maxMarketValue ?? 0;
    }
  }

  // Предварительно вычисляем score для каждого игрока
  final playersWithScore = players.map((player) {
    final positionWeightValue = positionWeightsCache[player.position] ?? 0;

    final normCurrent = maxCurrentValue > 0 ? (player.marketValue ?? 0) / maxCurrentValue : 0;
    final normMax = maxMaxValue > 0 ? (player.maxMarketValue ?? 0) / maxMaxValue : 0;

    final score =
        positionWeightValue * normalizedPositionWeight +
        normCurrent * normalizedCurrentValueWeight +
        normMax * normalizedMaxValueWeight;

    return (player: player, score: score);
  }).toList();

  // Сортируем по score
  playersWithScore.sort((a, b) => b.score.compareTo(a.score));

  return playersWithScore.map((e) => e.player).toList();
}
