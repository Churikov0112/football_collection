import 'package:flutter/widgets.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';

import '../../../../../../../../abstract/presentation/blocs/utils/ratings.dart';

class RatingTag extends StatelessWidget {
  const RatingTag({required this.value, this.color, super.key});

  final int value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: ratingColor(value)?.darken(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Center(
          child: Text(value.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
