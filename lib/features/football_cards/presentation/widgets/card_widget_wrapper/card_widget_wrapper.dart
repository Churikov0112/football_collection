import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';

import '../../../../abstract/domain/models/card.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../duplicate_actions/duplicate_actions.dart';

part 'widgets/badge/count_badge.dart';
part 'widgets/badge/new_badge.dart';

enum CardBadge { none, showCount, showNew }

class CardWidgetWrapper extends StatelessWidget {
  const CardWidgetWrapper({
    required this.card,
    required this.badge,
    required this.child,
    this.onSell,
    this.onSellAll,
    this.onShare,
    super.key,
  });

  final CardModel card;
  final CardBadge badge;
  final VoidCallback? onSell;
  final VoidCallback? onSellAll;
  final VoidCallback? onShare;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: badge == CardBadge.showCount
              ? _CountBadge(card: card, onSell: onSell, onSellAll: onSellAll, onShare: onShare)
              : badge == CardBadge.showNew
              ? const _NewBadge()
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
