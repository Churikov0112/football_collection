import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/player.dart';
import '../../blocs/all_players_bloc/all_players_bloc.dart';
import '../../blocs/saved_players_bloc/saved_players_bloc.dart';
import '../../widgets/player_card_widget.dart';

part 'widgets/player_card.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getIt.get<AllPlayersBloc>().add(AllPlayersEventLoad());
      getIt.get<SavedPlayersBloc>().add(SavedPlayersEventLoad());
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Euro Pack Collection",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromRGBO(43, 92, 255, 1),
      ),
      backgroundColor: const Color.fromRGBO(43, 92, 255, 1),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          // _AlbumPagesList(),
          // BlocBuilder<AllPlayersBloc, AllPlayersState>(
          //   bloc: getIt.get(),
          //   builder: (context, allPlayersState) {
          //     final allPlayers = allPlayersState.allPlayers ?? [];

          // на каждой странице должно быть по 4 карточки игроков
          // напиши код для определения переменной pagesLength, которая будет содержать количество страниц

          // int pagesLength = allPlayers.length ~/ 4;
          // if (allPlayers.length / pagesLength is! int) {
          //   pagesLength++;
          // }

          // return PageFlipWidget(
          //   key: _controller,
          //   backgroundColor: Colors.white,
          //   // isRightSwipe: true,
          //   lastPage: Container(color: Colors.white, child: const Center(child: Text('Last Page!'))),
          //   children: <Widget>[
          //     // for (var pageIndex = 0; pageIndex < pagesLength; pageIndex++)
          //     //   _AlbumPage(
          //     //     players: allPlayers.sublist(pageIndex * 4, (pageIndex + 1) * 4),
          //     //   ),
          //     for (var pageIndex = 0; pageIndex < 10; pageIndex++)
          //       _AlbumPage(
          //         players: allPlayers.sublist(pageIndex * 4, (pageIndex + 1) * 4),
          //       ),
          //   ],
          // );

          //     return const SizedBox.shrink();
          //   },
          // ),
        ],
      ),
    );
  }
}
