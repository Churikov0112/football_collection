import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/features/albums/presentation/widgets/saved_player_card.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/models/player.dart';
import '../../blocs/stickerpack_bloc/stickerpack_bloc.dart';

part 'mixins/yandex_ads_mixin.dart';
part 'sticker_pack_screen_presenter.dart';
part 'widgets/player_cards_swiper.dart';

class StickerpackScreen extends StatelessWidget {
  const StickerpackScreen({
    required this.country,
    super.key,
  });

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => StickerpackBloc(getIt.get()),
      child: StickerpackScreenPresenter(
        country: country,
        child: Builder(builder: (context) {
          final presenter = StickerpackScreenPresenter.of(context);

          return Scaffold(
            backgroundColor: Colors.amber,
            appBar: AppBar(title: Text("Open Pack")),
            body: StreamBuilder<bool>(
                stream: presenter.isPackOpenedStream$,
                builder: (context, isPackOpenedSnapshot) {
                  return BlocBuilder<StickerpackBloc, StickerpackState>(
                    builder: (context, stickerpackState) {
                      final pack = stickerpackState.pack ?? [];

                      if (pack.isEmpty) return const Center(child: CircularProgressIndicator());

                      if (isPackOpenedSnapshot.data ?? false) return _PlayerCardsSwiper(pack: pack);

                      return Center(
                        child: GestureDetector(
                          onTap: presenter.openPack,
                          child: Container(
                            height: 300,
                            width: 200,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                  );
                }),
          );
        }),
      ),
    );
  }
}
