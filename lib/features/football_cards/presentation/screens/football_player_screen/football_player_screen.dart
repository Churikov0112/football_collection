import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/draft/domain/models/ratings.dart';
import 'package:football_collection/features/football_cards/data/market_values_repository.dart';
import 'package:football_collection/features/football_cards/presentation/widgets/player_card/football_player_card.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:go_router/go_router.dart';

import '../../../../../services/localization/translator.dart';
import '../../../../../ui_kit/utils/transfer_value_beautifier.dart';
import '../../../../abstract/presentation/blocs/utils/ratings.dart';
import '../../../domain/cards/player_card.dart';
import '../../widgets/duplicate_actions/duplicate_actions_button.dart';

part 'football_player_screen_presenter.dart';
part 'widgets/market_value_history.dart';
part 'widgets/sofifa_ratings.dart';
part 'widgets/tm_player_bio.dart';

class FootballPlayerScreen extends StatelessWidget {
  const FootballPlayerScreen({
    required this.player,

    this.hideAge = false,
    this.hideClub = false,
    this.hideFoot = false,
    this.hideName = false,
    this.hideTeam = false,
    this.hidePhoto = false,
    this.hideHeight = false,
    this.hideRatings = false,
    this.hidePosition = false,
    this.hideOutfitter = false,
    this.hideBirthDate = false,
    this.hideNationality = false,
    this.hidePrimeTransferValue = false,
    this.hideTransferValueHisory = false,
    this.hideCurrentTransferValue = false,

    super.key,
  });

  final FootballPlayerCardModel player;

  final bool hideAge;
  final bool hideClub;
  final bool hideFoot;
  final bool hideName;
  final bool hideTeam;
  final bool hidePhoto;
  final bool hideHeight;
  final bool hideRatings;
  final bool hidePosition;
  final bool hideOutfitter;
  final bool hideBirthDate;
  final bool hideNationality;
  final bool hidePrimeTransferValue;
  final bool hideTransferValueHisory;
  final bool hideCurrentTransferValue;

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return FootballPlayerScreenPresenter(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 30, 30, 30),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // color: Colors.white,
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(20),
        //   topRight: Radius.circular(20),
        // ),
        // blupColor: Colors.black.withAlpha(200),
        child: DecoratedBox(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Translator(
                        termin: AppGlossary.details,
                        builder: (value) {
                          return Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24));
                        },
                      ),
                    ),
                    IconButton(onPressed: context.pop, icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     DecoratedBox(
                      //       decoration: BoxDecoration(
                      //         border: Border.all(color: Colors.white12, width: 1),
                      //         borderRadius: const BorderRadius.only(
                      //           topLeft: Radius.circular(20),
                      //           topRight: Radius.circular(20),
                      //         ),
                      //       ),
                      //       child: Image.asset(player.imageAssetPath, fit: BoxFit.cover, height: mq.size.width * 0.3),
                      //     ),
                      //     IconButton(onPressed: context.pop, icon: const Icon(Icons.close)),
                      //   ],
                      // ),

                      // SizedBox(
                      //   width: mq.size.width * 0.3,
                      //   child: _Name(isFake: false, name: player.name, hide: hideName),
                      // ),
                      FootballPlayerCardWidget(player: player, badge: .showCount),

                      const SizedBox(height: 16),

                      DuplicateActionsButton(card: player),

                      const SizedBox(height: 16),

                      _TmPlayerBio(
                        player: player,
                        hideAge: hideAge,
                        hideClub: hideClub,
                        hideFoot: hideFoot,
                        hideHeight: hideHeight,
                        hidePosition: hidePosition,
                        hideOutfitter: hideOutfitter,
                        hideCitizenship: hideNationality,
                        hideBirthDate: hideBirthDate,
                        hideNationality: hideNationality,
                        hidePrimeTransferValue: hidePrimeTransferValue,
                        hideCurrentTransferValue: hideCurrentTransferValue,
                      ),
                      const SizedBox(height: 16),
                      if (hideCurrentTransferValue == false) ...[
                        _MarketValueHistory(player: player, hide: hideTransferValueHisory),
                        const SizedBox(height: 16),
                      ],

                      _SofifaRatings(player: player, hide: hideRatings),
                      const SizedBox(height: 16),

                      // DecoratedBox(
                      //   decoration: BoxDecoration(
                      //     color: Colors.amber,
                      //   ),
                      //   child: SizedBox(
                      //     height: 400,
                      //     width: mq.size.width,
                      //   ),
                      // ),
                      // DecoratedBox(
                      //   decoration: BoxDecoration(
                      //     color: Colors.red,
                      //   ),
                      //   child: SizedBox(
                      //     height: 400,
                      //     width: mq.size.width,
                      //   ),
                      // ),
                      // DecoratedBox(
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //   ),
                      //   child: SizedBox(
                      //     height: 400,
                      //     width: mq.size.width,
                      //   ),
                      // ),
                      // DecoratedBox(
                      //   decoration: BoxDecoration(
                      //     color: Colors.green,
                      //   ),
                      //   child: SizedBox(
                      //     height: 400,
                      //     width: mq.size.width,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 2000,
                      //   width: mq.size.width,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(color: Colors.white10),
      child: SizedBox(height: 2, width: double.infinity),
    );
  }
}
