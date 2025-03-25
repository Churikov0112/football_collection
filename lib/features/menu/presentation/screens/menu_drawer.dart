import 'package:flutter/material.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              context.push(RoutePaths.miniGames);
            },
            title: Text("Mini games"),
          )
        ],
      ),
    );
  }
}
