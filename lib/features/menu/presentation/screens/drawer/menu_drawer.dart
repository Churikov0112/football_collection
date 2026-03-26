import 'package:flutter/material.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/utils/open_in_browser.dart';
import 'package:go_router/go_router.dart';

import '../../../../cheats/presentation/screens/enter_cheat_code_screen/enter_cheat_code_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black.withAlpha(175),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 50),
            ListTile(
              onTap: () {
                context.push(RoutePaths.miniGames);
              },
              leading: Icon(Icons.gamepad, color: Colors.white),
              title: Translator(
                termin: AppGlossary.miniGames,
                builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
              ),
            ),
            ListTile(
              onTap: () {
                context.push(RoutePaths.leaderboard);
              },
              leading: Icon(Icons.leaderboard, color: Colors.white),
              title: Translator(
                termin: AppGlossary.rating,
                builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
              ),
            ),
            // BlocBuilder<SavedCardsBloc, SavedCardsState>(
            //   bloc: getIt.get(),
            //   builder: (context, savedCardsState) {
            //     final savedCardsIds = savedCardsState.savedCardsIds ?? [];
            //     return ListTile(
            //       onTap: () {
            //         if (savedCardsIds.length < 100) {
            //           ToastService.showErrorToast(title: AppGlossary.draftLimitation.translate());
            //           return;
            //         }
            //         try {
            //           FirebaseAnalytics.instance.logEvent(name: "draft_opened");
            //         } catch (e) {
            //           LogService.error(e.toString(), e);
            //         }
            //         BottomSheetController.showBottomSheet(context, (context) => const DraftDescriptionScreen());
            //       },
            //       leading: Icon(Icons.gamepad, color: Colors.white),
            //       title: Translator(
            //         termin: AppGlossary.draft,
            //         builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              onTap: () {
                context.push(RoutePaths.getCardByQr);
              },
              leading: Icon(Icons.qr_code_2, color: Colors.white),
              title: Translator(
                termin: AppGlossary.scanQr,
                builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
              ),
            ),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return EnterCheatCodeScreen();
                  },
                );
              },
              leading: Icon(Icons.keyboard, color: Colors.white),
              title: Translator(
                termin: AppGlossary.cheatCodes,
                builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
              ),
            ),
            ListTile(
              onTap: () {
                context.push(RoutePaths.settings);
              },
              leading: Icon(Icons.settings, color: Colors.white),
              title: Translator(
                termin: AppGlossary.settings,
                builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
              ),
            ),
            ListTile(),
            ListTile(
              onTap: () async {
                await openInBrowser("https://football-collection.tilda.ws");
              },
              leading: Icon(Icons.language, color: Colors.white),
              title: Translator(
                termin: AppGlossary.ourWebsite,
                builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
              ),
            ),
            ListTile(
              onTap: () async {
                await openInBrowser("https://t.me/dosbrosdev");
              },
              leading: Icon(Icons.telegram, color: Colors.white),
              title: Translator(
                termin: AppGlossary.ourTelegram,
                builder: (value) => Text(value, style: TextStyle(color: Colors.white)),
              ),
            ),
            ListTile(
              onTap: () async {
                await openInBrowser("https://chat.whatsapp.com/FRadRMQ6gLP4mX03KDANtf");
              },
              leading: const Icon(Icons.chat, color: Colors.white),
              title: Translator(
                termin: AppGlossary.ourWhatsApp,
                builder: (value) => Text(value, style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
