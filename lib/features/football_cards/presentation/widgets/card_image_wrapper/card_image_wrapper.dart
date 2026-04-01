import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../services/localization/translator.dart';
import '../../../../../services/toast/toast_service.dart';
import '../../../../abstract/domain/models/card.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';

part 'widgets/badge/bs_actions.dart';
part 'widgets/badge/bs_qr.dart';
part 'widgets/badge/count_badge.dart';
part 'widgets/badge/new_badge.dart';

enum CardBadge { none, showCount, showNew }

enum CardElementVisibility { none, show, quest }

class CardImageWrapper extends StatelessWidget {
  const CardImageWrapper({
    required this.card,
    required this.badge,
    required this.child,
    // this.height = packHeight,
    // this.width = packWidth,
    // this.onTap,
    this.onSell,
    this.onSellAll,
    this.onShare,
    super.key,
  });

  final CardModel card;
  final CardBadge badge;
  // final double height;
  // final double width;
  // final VoidCallback? onTap;
  final VoidCallback? onSell;
  final VoidCallback? onSellAll;
  final VoidCallback? onShare;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: height,
    //   width: width,
    //   child: Stack(
    //     children: [
    //       GestureDetector(onTap: onTap, child: child),
    //       Positioned(
    //         top: 0,
    //         right: 0,
    //         child: badge == CardBadge.showCount
    //             ? _CountBadge(card: card, onSell: onSell, onSellAll: onSellAll, onShare: onShare)
    //             : badge == CardBadge.showNew
    //             ? _NewBadge()
    //             : SizedBox.shrink(),
    //       ),
    //     ],
    //   ),
    // );
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: badge == CardBadge.showCount
              ? _CountBadge(card: card, onSell: onSell, onSellAll: onSellAll, onShare: onShare)
              : badge == CardBadge.showNew
              ? _NewBadge()
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
