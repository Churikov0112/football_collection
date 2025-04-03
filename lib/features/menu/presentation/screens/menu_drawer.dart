import 'package:flutter/material.dart';
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
          ListTile(
            onTap: () {
              context.push(RoutePaths.miniGames);
            },
            leading: Icon(
              Icons.gamepad,
              color: Colors.white,
            ),
            title: Text(
              "Mini games",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.qr_code_2,
              color: Colors.white,
            ),
            title: Text(
              "Scan QR",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.keyboard,
              color: Colors.white,
            ),
            title: Text(
              "Cheat codes",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
