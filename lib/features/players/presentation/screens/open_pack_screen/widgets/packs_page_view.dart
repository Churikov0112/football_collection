import 'package:flutter/material.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/players/domain/models/pack.dart';

import '../open_pack_screen.dart';

class PacksPageView extends StatelessWidget {
  const PacksPageView({
    required this.packs,
    required this.state,
    super.key,
  });

  final List<PackModel> packs;
  final OpenPackCombinedState state;

  @override
  Widget build(BuildContext context) {
    final presenter = OpenPackScreenPresenter.of(context);

    return Visibility(
      visible: !state.unpacking,
      child: SizedBox(
        height: packHeight + 100,
        child: PageView.builder(
          itemCount: packs.length,
          controller: presenter.packsPageController,
          onPageChanged: (index) {
            presenter.setSelectedPackIndex(index);
          },
          itemBuilder: (context, index) {
            final pack = packs[index];
            return GestureDetector(
              onTap: () {
                if (!state.unpacking && !state.packsHiding && !state.isWaitingConfirm) {
                  if (packs[index].price == 0) {
                    presenter.openPack();
                  } else {
                    presenter.requestBuyPackConfirm(packs[index]);
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
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            pack.price > 0 ? "${pack.price} 🏆" : "Free",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      if (pack.imageAssetPath == "assets/raster/packs/pack-general.png") ...[
                        const SizedBox(height: 8),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: packWidth),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text(
                                "${emojiFlagByCountryName(pack.title) ?? ""} ${pack.title}",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Image.asset(
                    pack.imageAssetPath,
                    height: packHeight,
                    width: packWidth,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
