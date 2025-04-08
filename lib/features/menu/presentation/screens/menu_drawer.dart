import 'package:flutter/material.dart';
import 'package:football_collection/features/cheats/presentation/screens/enter_cheat_code_screen/enter_cheat_code_screen.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black.withAlpha(175),
      child: ListView(
        children: [
          const SizedBox(height: 50),
          ListTile(
            onTap: () {
              context.push(RoutePaths.miniGames);
            },
            leading: Icon(
              Icons.gamepad,
              color: Colors.white,
            ),
            title: Translator(
              termin: AppGlossary.miniGames,
              builder: (value) => Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              context.push(RoutePaths.getPlayerByQr);
            },
            leading: Icon(
              Icons.qr_code_2,
              color: Colors.white,
            ),
            title: Translator(
              termin: AppGlossary.scanQr,
              builder: (value) => Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
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
            leading: Icon(
              Icons.keyboard,
              color: Colors.white,
            ),
            title: Translator(
              termin: AppGlossary.cheatCodes,
              builder: (value) => Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              context.push(RoutePaths.settings);
            },
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Translator(
              termin: AppGlossary.settings,
              builder: (value) => Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            title: Translator(
              termin: AppGlossary.about,
              builder: (value) => Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.language,
              color: Colors.white,
            ),
            title: Translator(
              termin: AppGlossary.webVersion,
              builder: (value) => Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
