part of '../draft_screen.dart';

// const _fieldImageAspectRatio = 1124 / 749;

class PositionConnection {
  final FootballPlayerPositionOnField from;
  final FootballPlayerPositionOnField to;
  final double chemistry;

  PositionConnection({required this.from, required this.to, required this.chemistry});
}

class _Scheme extends StatelessWidget {
  const _Scheme();

  // List<PositionConnection> _getPositionConnections({
  //   required FootballScheme yourScheme,
  //   required List<FootballPlayerPositionOnField> positions,
  //   required List<(FootballPlayerPositionOnField, FootballPlayerGameModel?)> startingSquad,
  // }) {
  //   final connections = <PositionConnection>[];

  //   for (int i = 0; i < positions.length; i++) {
  //     for (int j = i + 1; j < positions.length; j++) {
  //       final fromPof = positions[i];
  //       final toPof = positions[j];

  //       if (FootballSchemeConnections.shouldConnect(fromPof, toPof, yourScheme)) {
  //         final fromPlayer = startingSquad.firstWhereOrNull((p) => p.$1.id == fromPof.id)?.$2;
  //         final toPlayer = startingSquad.firstWhereOrNull((p) => p.$1.id == toPof.id)?.$2;

  //         if (fromPlayer != null && toPlayer != null) {
  //           final chemistry = _calculateChemistry(fromPlayer, toPlayer);
  //           connections.add(
  //             PositionConnection(
  //               from: fromPof,
  //               to: toPof,
  //               chemistry: chemistry,
  //             ),
  //           );
  //         }
  //       }
  //     }
  //   }

  //   return connections;
  // }

  // double _calculateChemistry(FootballPlayerGameModel player1, FootballPlayerGameModel player2) {
  //   final allCompetitions = getIt.get<AllFootballCompetitionsBloc>().state.allCompetitions;
  //   final String? player1CompetitionId = allCompetitions
  //       ?.firstWhereOrNull((c) => c.teamsIds.contains(player1.card.teamId))
  //       ?.id;
  //   final String? player2CompetitionId = allCompetitions
  //       ?.firstWhereOrNull((c) => c.teamsIds.contains(player2.card.teamId))
  //       ?.id;

  //   double chemistry = 0.0;

  //   if (player1.card.nationality?.any((country) => player2.card.tmData?.nationality?.contains(country) ?? false) ==
  //           true ||
  //       player2.card.nationality?.any((country) => player1.card.tmData?.nationality?.contains(country) ?? false) == true
  //   // player1.card.nationality == player2.card.nationality
  //   ) {
  //     chemistry += 0.4;
  //   }

  //   if (player1.card.teamId == player2.card.teamId) {
  //     chemistry += 0.6;
  //   }

  //   if (player1CompetitionId == player2CompetitionId) {
  //     chemistry += 0.2;
  //   }

  //   return chemistry.clamp(0.0, 1.0);
  // }

  Color _getChemistryColor(double chemistry) {
    if (chemistry >= 0.85) {
      return const Color.fromARGB(255, 0, 234, 255); // Отличная химия
    }
    if (chemistry >= 0.65) {
      return Colors.green;
    }
    if (chemistry >= 0.5) {
      return Colors.yellow; // Средняя химия
    }
    if (chemistry >= 0.2) {
      return Colors.orange; // Слабая химия
    }
    return Colors.red; // Плохая химия
  }

  @override
  Widget build(BuildContext context) {
    final presenter = DraftScreenPresenter.of(context);
    // final mq = MediaQuery.of(context);

    // final fieldWidth = mq.size.width;
    // final fieldHeight = mq.size.height - mq.padding.top - mq.padding.bottom - 112;

    // final fieldWidth = mqSize.width;
    // final fieldHeight = mqSize.height;

    return StreamBuilder(
      stream: presenter.connectionsChemistry$,
      builder: (context, connectionsChemistrySnapshot) {
        return StreamBuilder(
          stream: presenter.scheme$,
          builder: (context, schemeSnapshot) {
            final yourScheme = schemeSnapshot.data;
            final yourSchemePositions = FootballSchemes.vertical[yourScheme] ?? [];

            if (yourScheme == null || yourSchemePositions.isEmpty) {
              return const SizedBox.shrink();
            }

            return FutureBuilder<List<PositionConnection>>(
              future: presenter.getPositionConnections(),
              builder: (context, positionConnectionsSnapshot) {
                final connections = positionConnectionsSnapshot.data ?? [];

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final fieldWidth = constraints.maxWidth;
                    final fieldHeight = constraints.maxHeight;

                    return Stack(
                      children: [
                        Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Image.asset("assets/raster/field/field_goal_top.jpg"),
                                Expanded(
                                  child: Image.asset(
                                    "assets/raster/field/field_space_top.jpg",
                                    height: 300,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Image.asset("assets/raster/field/field_center.jpg"),
                                Expanded(
                                  child: Image.asset(
                                    "assets/raster/field/field_space_bottom.jpg",
                                    height: 300,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Image.asset("assets/raster/field/field_goal_bottom.jpg"),
                              ],
                            ),
                            StreamBuilder(
                              stream: presenter.draftPage$,
                              builder: (context, draftPageSnapshot) {
                                final page = draftPageSnapshot.data;

                                return StreamBuilder(
                                  stream: presenter.selectedPlayer$,
                                  builder: (context, selectedPlayerSnapshot) {
                                    if (selectedPlayerSnapshot.data == null || page != 1) {
                                      return const SizedBox.shrink();
                                    }

                                    return Positioned(
                                      bottom: 16,
                                      right: 16,
                                      child: Button(
                                        icon: Icons.change_circle_outlined,
                                        onPressed: () {
                                          presenter.openPlayerSelector(selectedPlayerSnapshot.data!.$1);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                        // Линии химии между позициями
                        ...connections.map((connection) {
                          final fromX = connection.from.x * fieldWidth;
                          final fromY = (1 - connection.from.y) * fieldHeight;
                          final toX = connection.to.x * fieldWidth;
                          final toY = (1 - connection.to.y) * fieldHeight;

                          return CustomPaint(
                            painter: _ConnectionPainter(
                              from: Offset(fromX, fromY),
                              to: Offset(toX, toY),
                              color: _getChemistryColor(connection.chemistry),
                              lineWidth: 4,
                              // lineWidth: 2.0 + connection.chemistry * 3.0,
                            ),
                          );
                        }),

                        // Кружки позиций
                        ...yourSchemePositions.map((pof) {
                          const double _cardAspectRatio = 2 / 3;
                          final double cardHeight = fieldWidth * 0.25; // mqSize.width * 0.23;
                          final double cardWidth = cardHeight * _cardAspectRatio;
                          final double x = pof.x * fieldWidth;
                          final double y = (1 - pof.y) * fieldHeight;

                          return Positioned(
                            // left: x - circleSize / 2,
                            // top: y - circleSize / 2,
                            left: x - cardWidth / 2,
                            top: y - cardHeight / 2,
                            child: _PositionOnField(
                              pof: pof,
                              height: cardHeight,
                              width: cardWidth,
                              color: Colors.blueGrey.withOpacity(0.7),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

// CustomPainter для рисования линий соединения
class _ConnectionPainter extends CustomPainter {
  final Offset from;
  final Offset to;
  final Color color;
  final double lineWidth;

  _ConnectionPainter({required this.from, required this.to, required this.color, required this.lineWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(from, to, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _PositionOnField extends StatelessWidget {
  final FootballPlayerPositionOnField pof;
  final double height;
  final double width;

  final Color color;

  const _PositionOnField({required this.pof, required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    final presenter = DraftScreenPresenter.of(context);

    return StreamBuilder(
      stream: presenter.draftPage$,
      builder: (context, draftPageSnapshot) {
        final page = draftPageSnapshot.data;

        return StreamBuilder<List<(FootballPlayerPositionOnField, FootballPlayerGameModel?)>>(
          stream: presenter.startingSquad$,
          builder: (context, startingSquadSnapshot) {
            final player = startingSquadSnapshot.data?.firstWhereOrNull((p) => p.$1 == pof)?.$2;

            return StreamBuilder(
              stream: presenter.selectedPlayer$,
              builder: (context, selectedPlayerSnapshot) {
                final selectedPlayerId = selectedPlayerSnapshot.data?.$2?.card.playerId;
                final isSelected = selectedPlayerId == player?.card.playerId;

                return GestureDetector(
                  onTap: () {
                    if (presenter._draftPageSubject.value == 1) {
                      if (player != null) {
                        if (!isSelected && selectedPlayerId != null) {
                          presenter.swapPlayersOnField(player.card.playerId, selectedPlayerId);
                        } else {
                          presenter.selectPlayer(player.card.playerId);
                        }
                      } else {
                        presenter.openPlayerSelector(pof);
                      }
                    } else if (presenter._draftPageSubject.value == 2 && player != null) {
                      presenter.selectCaptain(player.card.playerId);
                    }
                  },
                  child: player != null
                      ? StreamBuilder(
                          stream: presenter.captainId$,
                          builder: (context, captainIdSnapshot) {
                            final isCaptain = captainIdSnapshot.data == player.card.playerId;

                            return DecoratedBox(
                              decoration: BoxDecoration(
                                border: (isSelected && page == 1) || (isCaptain && page != 1)
                                    ? Border.all(color: Colors.white, width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: SmallDraftFootballPlayerCardWidget(
                                  player: player.card,
                                  height: isCaptain ? height + 2 : height,
                                  width: isCaptain ? width + 2 : width,
                                ),
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          width: width,
                          height: height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(width / 4),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                pof.abstractPosition.name.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: height * 0.2,
                                ),
                              ),
                            ),
                          ),
                        ),
                  // SizedBox(
                  //   width: size,
                  //   height: size + (player != null ? 36 : 0),
                  //   child: Column(
                  //     children: [
                  //       SizedBox(
                  //         width: size,
                  //         height: size,
                  //         child: DecoratedBox(
                  //           decoration: BoxDecoration(
                  //             color: color,
                  //             borderRadius: BorderRadius.circular(size / 2),
                  //             border: Border.all(color: Colors.white, width: 1),
                  //             image: player != null
                  //                 ? DecorationImage(
                  //                     image: AssetImage(player.card.imageAssetPath),
                  //                     fit: BoxFit.cover,
                  //                   )
                  //                 : null,
                  //           ),
                  //           child: player == null
                  //               ? Center(
                  //                   child: Text(
                  //                     pof.abstractPosition.name.toUpperCase(),
                  //                     style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: size * 0.3,
                  //                     ),
                  //                   ),
                  //                 )
                  //               : null,
                  //         ),
                  //       ),
                  //       if (player != null) ...[
                  //         const SizedBox(height: 4),
                  //         SizedBox(
                  //           width: size,
                  //           child: AutoSizeText(
                  //             player.card.name,
                  //             maxLines: 2,
                  //             textAlign: TextAlign.center,
                  //             minFontSize: 10,
                  //             maxFontSize: 14,
                  //             overflow: TextOverflow.ellipsis,
                  //             style: const TextStyle(
                  //               color: Colors.white,
                  //               height: 1.1,
                  //               shadows: [
                  //                 Shadow(
                  //                   offset: Offset(1, 1),
                  //                   blurRadius: 2,
                  //                   color: Colors.black,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ],
                  //   ),
                  // ),
                );
              },
            );
          },
        );
      },
    );
  }
}
