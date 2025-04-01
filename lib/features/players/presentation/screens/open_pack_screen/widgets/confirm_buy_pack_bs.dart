import 'package:flutter/material.dart';
import 'package:football_collection/features/players/domain/models/pack.dart';
import 'package:go_router/go_router.dart';

class ConfirmBuyPackBottomSheet extends StatelessWidget {
  const ConfirmBuyPackBottomSheet({
    required this.pack,
    super.key,
  });

  final PackModel pack;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text("Confirm to buy pack for ${pack.price} 🏆"),
          const SizedBox(height: 20),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.pop(false);
                  },
                  child: Text("Cancel"),
                ),
              ),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.pop(true);
                  },
                  child: Text("Confirm"),
                ),
              ),
            ],
          ),
          SizedBox(height: mq.padding.bottom + 20)
        ],
      ),
    );
  }
}
