import 'package:fc_26_england/di/di.dart';
import 'package:fc_26_england/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:fc_26_england/services/localization/translator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import '../../../../../../services/navigation/go_router/navigation.dart';
import '../../../../../../ui_kit/widgets/glass_button.dart';
import '../../../../../../ui_kit/widgets/transparent_appbar/watch_ad_screen/watch_ad_screen.dart';

part 'draft_description_screen_presenter.dart';

class DraftDescriptionScreen extends StatelessWidget {
  const DraftDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return DraftDescriptionScreenPresenter(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 36, 36, 36),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: mq.safeTopPadding()),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Translator(
                        termin: AppGlossary.draft,
                        builder: (value) => Text(
                          value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: context.pop,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 1, height: 1, color: Colors.white10),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Translator(
                        termin: AppGlossary.welcomeToDraft,
                        builder: (value) => Text(value),
                      ),
                      Translator(
                        termin: AppGlossary.draftDescription1,
                        builder: (value) => Text(value),
                      ),
                      Translator(
                        termin: AppGlossary.draftDescription2,
                        builder: (value) => Text(value),
                      ),
                      Translator(
                        termin: AppGlossary.draftDescription3,
                        builder: (value) => Text(value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: mq.padding.bottom + 16,
              child: Translator(
                termin: AppGlossary.startDraft,
                builder: (value) => GlassButton(
                  onPressed: () {
                    final balanceBloc = getIt.get<BalanceBloc>();
                    final balance = balanceBloc.state.balance ?? 0;
                    if (balance >= 100) {
                      getIt.get<BalanceBloc>().add(BalanceEventDecrease(amount: 100));
                      context.pop();
                      context.push(RoutePaths.draft);
                    } else {
                      BottomSheetController.showBottomSheet(context, (context) => const WatchAdScreen());
                    }
                  },
                  text: "$value - 100 🏆",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
