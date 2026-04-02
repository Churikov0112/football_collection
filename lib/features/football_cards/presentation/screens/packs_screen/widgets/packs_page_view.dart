import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/services/localization/translator.dart';

import '../../../../../countries/domain/models/national_team.dart';
import '../football_players_packs_screen.dart';
import 'team_flag_on_pack.dart';

class PacksPageView extends StatelessWidget {
  const PacksPageView({required this.packs, required this.state, super.key});

  final List<PackModel> packs;
  final OpenPackCombinedState state;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final presenter = FootballPlayersPacksScreenPresenter.of(context);

    return Visibility(
      visible: !state.unpacking,
      child: CarouselSlider(
        carouselController: presenter.packsCarouselController,

        options: CarouselOptions(
          // enlargeCenterPage: true,
          initialPage: presenter.selectedPackIndexSubject.value,
          height: 450.0,
          viewportFraction: (packWidth / size.width) + 0.1,
          onPageChanged: (index, reason) {
            presenter.setSelectedPackIndex(index);
          },
        ),
        items: [
          for (int i = 0; i < packs.length; i++)
            GestureDetector(
              onTap: () {
                final selectedPackIndex = presenter.selectedPackIndexSubject.value;
                if (!state.unpacking && !state.packsHiding && !state.isWaitingConfirm && i == selectedPackIndex) {
                  if (packs[i].price == 0) {
                    presenter.openPack(packs[i]);
                  } else {
                    presenter.requestBuyPackConfirm(packs[i]);
                  }
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Translator(
                            termin: AppGlossary.free,
                            builder: (value) => Text(
                              packs[i].price > 0 ? "${packs[i].price} 🏆" : value,
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      if (packs[i].imageAssetPath == "assets/raster/packs/pack-general.png") ...[
                        const SizedBox(height: 8),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: packWidth),
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                "${emojiFlagByCountryName(packs[i].title) ?? ""} ${packs[i].title}",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      Image.asset(packs[i].imageAssetPath, height: packHeight, width: packWidth, fit: BoxFit.fill),
                      if (packs[i].type == PackType.team)
                        Positioned(
                          top: (packHeight - packWidth * 0.3) / 2,
                          left: (packWidth - packWidth * 0.3) / 2,
                          right: (packWidth - packWidth * 0.3) / 2,
                          bottom: (packHeight - packWidth * 0.3) / 2,
                          child: TeamFlagOnPack(
                            teamdId: packs[i].cards?.firstOrNull?.teamId ?? "",
                            size: packWidth * 0.3,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
        // PageView.builder(
        //   itemCount: packs.length,
        //   controller: presenter.packsPageController,
        //   onPageChanged: (index) {
        //     presenter.setSelectedPackIndex(index);
        //   },
        //   itemBuilder: (context, index) {
        //     final pack = packs[index];
        //     return GestureDetector(
        //       onTap: () {
        //         if (!state.unpacking && !state.packsHiding && !state.isWaitingConfirm) {
        //           if (packs[index].price == 0) {
        //             presenter.openPack();
        //           } else {
        //             presenter.requestBuyPackConfirm(packs[index]);
        //           }
        //         }
        //       },
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         children: [
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               DecoratedBox(
        //                 decoration: BoxDecoration(
        //                   color: Colors.black45,
        //                   borderRadius: BorderRadius.circular(16),
        //                 ),
        //                 child: Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        //                   child: Text(
        //                     pack.price > 0 ? "${pack.price} 🏆" : "Free",
        //                     style: TextStyle(
        //                       fontSize: 20,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               if (pack.imageAssetPath == "assets/raster/packs/pack-general.png") ...[
        //                 const SizedBox(height: 8),
        //                 ConstrainedBox(
        //                   constraints: BoxConstraints(maxWidth: packWidth),
        //                   child: DecoratedBox(
        //                     decoration: BoxDecoration(
        //                       color: Colors.black45,
        //                       borderRadius: BorderRadius.circular(16),
        //                     ),
        //                     child: Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        //                       child: Text(
        //                         "${emojiFlagByCountryName(pack.title) ?? ""} ${pack.title}",
        //                         textAlign: TextAlign.center,
        //                         maxLines: 2,
        //                         style: TextStyle(
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ],
        //           ),
        //           const SizedBox(height: 8),
        //           Image.asset(
        //             pack.imageAssetPath,
        //             height: packHeight,
        //             width: packWidth,
        //             fit: BoxFit.fill,
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
