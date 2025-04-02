// part of '../album_screen.dart';

// class _AlbumPage extends StatelessWidget {
//   const _AlbumPage({
//     required this.players,
//   });

//   final List<PlayerModel> players;

//   @override
//   Widget build(BuildContext context) {
    // final absentWIdget = GestureDetector(
    //   onTap: () {
    //     context.push(RoutePaths.stickerpack).whenComplete(() {
    //       getIt.get<AllPlayersBloc>().add(AllPlayersEventLoad(fromRuntimeCache: true));
    //       getIt.get<SavedPlayersBloc>().add(SavedPlayersEventLoad(fromRuntimeCache: true));
    //     });
    //   },
    //   child: Container(
    //     color: Colors.grey[300],
    //     child: Padding(
    //       padding: const EdgeInsets.all(10),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             player.name,
    //             textAlign: TextAlign.center,
    //             style: const TextStyle(
    //               fontSize: 16,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           const SizedBox.shrink(),
    //           Opacity(
    //             opacity: 0.3,
    //             child: Text(
    //               getCountryEmoji(player),
    //               style: const TextStyle(fontSize: 24),
    //             ),
    //           ),
    //           Text(
    //             player.id.toString(),
    //             style: const TextStyle(
    //               fontSize: 54,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.black26,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // return BlocBuilder<SavedPlayersBloc, SavedPlayersState>(
    //   bloc: getIt.get(),
    //   buildWhen: (previous, current) => current is SavedPlayersStateLoadSucceeded,
    //   builder: (context, savedPlayersState) {
    //     if (savedPlayersState is SavedPlayersStateLoadSucceeded) {
    //       final isPlayerSaved = savedPlayersState.players.contains(player);
    //       if (isPlayerSaved) {
    //         return PlayerPackCardWidget(player: player);
    //       }
    //     }
    //     return absentWIdget;
    //   },
    // );

//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 200,
//         childAspectRatio: 2 / 3,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//       ),
//       padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
//       itemCount: players.length,
//       itemBuilder: (context, index) {
//         return _PlayerCard(
//           player: players[index],
//         );
//       },
//     );
//   }
// }
