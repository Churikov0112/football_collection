import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../football_cards/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import '../../../../football_cards/presentation/widgets/player_card/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_position_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessPositionScreen extends StatelessWidget {
  const GuessPositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: GuessPositionScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessPositionScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<
                    RandomFootballPlayersBloc,
                    RandomFootballPlayersState
                  >(
                    builder: (context, randomPlayersState) {
                      final allPlayers = randomPlayersState.players ?? [];
                      final player = allPlayers.firstOrNull;

                      if (player?.position == null) {
                        return Align(child: const CircularProgressIndicator());
                      }

                      final correctAnswer = player!.position!;
                      final wrongOptions = <String>[];
                      for (final item in allPlayers) {
                        final position = item.position;
                        if (position == null ||
                            position == correctAnswer ||
                            wrongOptions.contains(position)) {
                          continue;
                        }
                        wrongOptions.add(position);
                      }

                      if (wrongOptions.length < 3) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          presenter.loadRandomPlayers();
                        });
                        return Align(child: const CircularProgressIndicator());
                      }

                      final options = [correctAnswer, ...wrongOptions.take(3)];
                      options.shuffle();

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Align(
                            child: FootballPlayerCardWidget(
                              player: player,
                              badge: .none,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _GuessOptions(
                            options: options,
                            rightAnswer: correctAnswer,
                          ),
                          const SizedBox(height: 20),
                          StreamBuilder<bool>(
                            stream: presenter.isBannerAlreadyCreatedStream$,
                            builder: (context, isBannerAlreadyCreatedSnapshot) {
                              if (isBannerAlreadyCreatedSnapshot.data != true) {
                                return const SizedBox(height: 100);
                              }
                              return SizedBox(
                                height: 100,
                                child: AdWidget(bannerAd: presenter.banner),
                              );
                            },
                          ),
                          SizedBox(height: mq.padding.bottom),
                        ],
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.guessPosition,
                    builder: (value) => TransparentAppbar(title: value),
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

String _localizePosition(String position) {
  final language = getIt.get<LanguageBloc>().state.language;

  switch (position) {
    case 'Goalkeeper':
      return switch (language) {
        Languages.russian => 'Вратарь',
        Languages.spanish => 'Portero',
        Languages.portuguese => 'Goleiro',
        Languages.french => 'Gardien',
        Languages.italian => 'Portiere',
        Languages.turkish => 'Kaleci',
        Languages.chinese => '门将',
        Languages.arabic => 'حارس مرمى',
        Languages.japanese => 'ゴールキーパー',
        Languages.hindi => 'गोलकीपर',
        Languages.bengal => 'গোলরক্ষক',
        Languages.german => 'Torwart',
        Languages.korean => '골키퍼',
        Languages.vietnamese => 'Thu mon',
        Languages.english => 'Goalkeeper',
      };
    case 'Centre-Back':
      return switch (language) {
        Languages.russian => 'Центральный защитник',
        Languages.spanish => 'Defensa central',
        Languages.portuguese => 'Zagueiro central',
        Languages.french => 'Defenseur central',
        Languages.italian => 'Difensore centrale',
        Languages.turkish => 'Stoper',
        Languages.chinese => '中后卫',
        Languages.arabic => 'قلب دفاع',
        Languages.japanese => 'センターバック',
        Languages.hindi => 'सेंटर बैक',
        Languages.bengal => 'সেন্টার-ব্যাক',
        Languages.german => 'Innenverteidiger',
        Languages.korean => '센터백',
        Languages.vietnamese => 'Trung ve',
        Languages.english => 'Centre-Back',
      };
    case 'Left-Back':
      return switch (language) {
        Languages.russian => 'Левый защитник',
        Languages.spanish => 'Lateral izquierdo',
        Languages.portuguese => 'Lateral esquerdo',
        Languages.french => 'Arriere gauche',
        Languages.italian => 'Terzino sinistro',
        Languages.turkish => 'Sol bek',
        Languages.chinese => '左后卫',
        Languages.arabic => 'ظهير أيسر',
        Languages.japanese => '左サイドバック',
        Languages.hindi => 'लेफ्ट बैक',
        Languages.bengal => 'লেফট-ব্যাক',
        Languages.german => 'Linksverteidiger',
        Languages.korean => '레프트백',
        Languages.vietnamese => 'Hau ve trai',
        Languages.english => 'Left-Back',
      };
    case 'Right-Back':
      return switch (language) {
        Languages.russian => 'Правый защитник',
        Languages.spanish => 'Lateral derecho',
        Languages.portuguese => 'Lateral direito',
        Languages.french => 'Arriere droit',
        Languages.italian => 'Terzino destro',
        Languages.turkish => 'Sag bek',
        Languages.chinese => '右后卫',
        Languages.arabic => 'ظهير أيمن',
        Languages.japanese => '右サイドバック',
        Languages.hindi => 'राइट बैक',
        Languages.bengal => 'রাইট-ব্যাক',
        Languages.german => 'Rechtsverteidiger',
        Languages.korean => '라이트백',
        Languages.vietnamese => 'Hau ve phai',
        Languages.english => 'Right-Back',
      };
    case 'Defensive Midfield':
      return switch (language) {
        Languages.russian => 'Опорный полузащитник',
        Languages.spanish => 'Mediocentro defensivo',
        Languages.portuguese => 'Volante',
        Languages.french => 'Milieu defensif',
        Languages.italian => 'Centrocampista difensivo',
        Languages.turkish => 'Defansif orta saha',
        Languages.chinese => '后腰',
        Languages.arabic => 'وسط دفاعي',
        Languages.japanese => '守備的ミッドフィルダー',
        Languages.hindi => 'डिफेंसिव मिडफील्डर',
        Languages.bengal => 'ডিফেন্সিভ মিডফিল্ডার',
        Languages.german => 'Defensives Mittelfeld',
        Languages.korean => '수비형 미드필더',
        Languages.vietnamese => 'Tien ve phong ngu',
        Languages.english => 'Defensive Midfield',
      };
    case 'Central Midfield':
      return switch (language) {
        Languages.russian => 'Центральный полузащитник',
        Languages.spanish => 'Centrocampista',
        Languages.portuguese => 'Meio-campista central',
        Languages.french => 'Milieu central',
        Languages.italian => 'Centrocampista centrale',
        Languages.turkish => 'Merkez orta saha',
        Languages.chinese => '中场',
        Languages.arabic => 'وسط',
        Languages.japanese => 'センターミッドフィルダー',
        Languages.hindi => 'सेंट्रल मिडफील्डर',
        Languages.bengal => 'সেন্ট্রাল মিডফিল্ডার',
        Languages.german => 'Zentrales Mittelfeld',
        Languages.korean => '중앙 미드필더',
        Languages.vietnamese => 'Tien ve trung tam',
        Languages.english => 'Central Midfield',
      };
    case 'Attacking Midfield':
      return switch (language) {
        Languages.russian => 'Атакующий полузащитник',
        Languages.spanish => 'Mediapunta',
        Languages.portuguese => 'Meia ofensivo',
        Languages.french => 'Milieu offensif',
        Languages.italian => 'Trequartista',
        Languages.turkish => 'Ofansif orta saha',
        Languages.chinese => '前腰',
        Languages.arabic => 'وسط هجومي',
        Languages.japanese => '攻撃的ミッドフィルダー',
        Languages.hindi => 'अटैकिंग मिडफील्डर',
        Languages.bengal => 'অ্যাটাকিং মিডফিল্ডার',
        Languages.german => 'Offensives Mittelfeld',
        Languages.korean => '공격형 미드필더',
        Languages.vietnamese => 'Tien ve tan cong',
        Languages.english => 'Attacking Midfield',
      };
    case 'Left Midfield':
      return switch (language) {
        Languages.russian => 'Левый полузащитник',
        Languages.spanish => 'Mediocampista izquierdo',
        Languages.portuguese => 'Meio-campista esquerdo',
        Languages.french => 'Milieu gauche',
        Languages.italian => 'Centrocampista sinistro',
        Languages.turkish => 'Sol orta saha',
        Languages.chinese => '左中场',
        Languages.arabic => 'وسط أيسر',
        Languages.japanese => '左ミッドフィルダー',
        Languages.hindi => 'लेफ्ट मिडफील्डर',
        Languages.bengal => 'লেফট মিডফিল্ডার',
        Languages.german => 'Linkes Mittelfeld',
        Languages.korean => '왼쪽 미드필더',
        Languages.vietnamese => 'Tien ve trai',
        Languages.english => 'Left Midfield',
      };
    case 'Right Midfield':
      return switch (language) {
        Languages.russian => 'Правый полузащитник',
        Languages.spanish => 'Mediocampista derecho',
        Languages.portuguese => 'Meio-campista direito',
        Languages.french => 'Milieu droit',
        Languages.italian => 'Centrocampista destro',
        Languages.turkish => 'Sag orta saha',
        Languages.chinese => '右中场',
        Languages.arabic => 'وسط أيمن',
        Languages.japanese => '右ミッドフィルダー',
        Languages.hindi => 'राइट मिडफील्डर',
        Languages.bengal => 'রাইট মিডফিল্ডার',
        Languages.german => 'Rechtes Mittelfeld',
        Languages.korean => '오른쪽 미드필더',
        Languages.vietnamese => 'Tien ve phai',
        Languages.english => 'Right Midfield',
      };
    case 'Left Winger':
      return switch (language) {
        Languages.russian => 'Левый вингер',
        Languages.spanish => 'Extremo izquierdo',
        Languages.portuguese => 'Ponta esquerda',
        Languages.french => 'Ailier gauche',
        Languages.italian => 'Ala sinistra',
        Languages.turkish => 'Sol kanat',
        Languages.chinese => '左边锋',
        Languages.arabic => 'جناح أيسر',
        Languages.japanese => '左ウイング',
        Languages.hindi => 'लेफ्ट विंगर',
        Languages.bengal => 'লেফট উইঙ্গার',
        Languages.german => 'Linksaußen',
        Languages.korean => '레프트 윙어',
        Languages.vietnamese => 'Tien dao canh trai',
        Languages.english => 'Left Winger',
      };
    case 'Right Winger':
      return switch (language) {
        Languages.russian => 'Правый вингер',
        Languages.spanish => 'Extremo derecho',
        Languages.portuguese => 'Ponta direita',
        Languages.french => 'Ailier droit',
        Languages.italian => 'Ala destra',
        Languages.turkish => 'Sag kanat',
        Languages.chinese => '右边锋',
        Languages.arabic => 'جناح أيمن',
        Languages.japanese => '右ウイング',
        Languages.hindi => 'राइट विंगर',
        Languages.bengal => 'রাইট উইঙ্গার',
        Languages.german => 'Rechtsaußen',
        Languages.korean => '라이트 윙어',
        Languages.vietnamese => 'Tien dao canh phai',
        Languages.english => 'Right Winger',
      };
    case 'Centre-Forward':
      return switch (language) {
        Languages.russian => 'Центральный нападающий',
        Languages.spanish => 'Delantero centro',
        Languages.portuguese => 'Centroavante',
        Languages.french => 'Avant-centre',
        Languages.italian => 'Centravanti',
        Languages.turkish => 'Santrfor',
        Languages.chinese => '中锋',
        Languages.arabic => 'مهاجم صريح',
        Languages.japanese => 'センターフォワード',
        Languages.hindi => 'सेंटर फॉरवर्ड',
        Languages.bengal => 'সেন্টার ফরোয়ার্ড',
        Languages.german => 'Mittelstürmer',
        Languages.korean => '센터 포워드',
        Languages.vietnamese => 'Tien dao trung tam',
        Languages.english => 'Centre-Forward',
      };
    case 'Second Striker':
      return switch (language) {
        Languages.russian => 'Оттянутый нападающий',
        Languages.spanish => 'Segundo delantero',
        Languages.portuguese => 'Segundo atacante',
        Languages.french => 'Deuxieme attaquant',
        Languages.italian => 'Seconda punta',
        Languages.turkish => 'Ikinci forvet',
        Languages.chinese => '影锋',
        Languages.arabic => 'مهاجم ثان',
        Languages.japanese => 'セカンドストライカー',
        Languages.hindi => 'सेकंड स्ट्राइकर',
        Languages.bengal => 'সেকেন্ড স্ট্রাইকার',
        Languages.german => 'Hängende Spitze',
        Languages.korean => '세컨드 스트라이커',
        Languages.vietnamese => 'Ho cong',
        Languages.english => 'Second Striker',
      };
    case 'Striker':
      return switch (language) {
        Languages.russian => 'Нападающий',
        Languages.spanish => 'Delantero',
        Languages.portuguese => 'Atacante',
        Languages.french => 'Attaquant',
        Languages.italian => 'Attaccante',
        Languages.turkish => 'Forvet',
        Languages.chinese => '前锋',
        Languages.arabic => 'مهاجم',
        Languages.japanese => 'ストライカー',
        Languages.hindi => 'स्ट्राइकर',
        Languages.bengal => 'স্ট্রাইকার',
        Languages.german => 'Stürmer',
        Languages.korean => '스트라이커',
        Languages.vietnamese => 'Tien dao',
        Languages.english => 'Striker',
      };
    default:
      return position;
  }
}
