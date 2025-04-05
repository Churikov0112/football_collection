part of '../saved_player_card.dart';

class _ConfirmCreateQRBottomSheet extends StatelessWidget {
  const _ConfirmCreateQRBottomSheet();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Text(
            "Convert dublicate to QR code for your friend? Dublicate will be deleted from your collection",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.pop(false);
                  },
                  child: Text("Cancel"),
                ),
              ),
              SizedBox(width: 12),
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
          SizedBox(height: mq.padding.bottom + 16),
        ],
      ),
    );
  }
}
