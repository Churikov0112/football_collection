// part of '../album_screen.dart';

// final _controller = GlobalKey<PageFlipWidgetState>();

// class _AlbumPagesList extends StatelessWidget {
//   const _AlbumPagesList();

//   @override
//   Widget build(BuildContext context) {
//     // final pagesLength = (allPlayers.length / 4).ceil();

//     return BlocBuilder<AllPlayersBloc, AllPlayersState>(
//       bloc: getIt.get(),
//       builder: (context, allPlayersState) {
//         if (allPlayersState.allPlayers?.isNotEmpty == true) {
//           final allPlayers = allPlayersState.allPlayers ?? [];
//           Map<String, List<FootballPlayerModel>> teamPages = {};
//           for (var i = 0; i < allPlayers.length; i++) {
//             teamPages[allPlayers[i].countryName] = [...teamPages[allPlayers[i].countryName] ?? [], allPlayers[i]];
//           }

//           return PageFlipWidget(
//             key: _controller,
//             duration: const Duration(seconds: 1),
//             backgroundColor: Colors.white,
//             // isRightSwipe: true,
//             lastPage: Container(color: Colors.white, child: const Center(child: Text('Last Page!'))),
//             children: <Widget>[
//               ...teamPages.values.map((players) => _AlbumPage(players: players)),
//             ],
//           );
//         }

//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
// }
