part of '../football_player_card.dart';

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
            AppGlossary.convertDuplicateToQr.translate(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    context.pop(false);
                  },
                  child: Text(AppGlossary.cancel.translate()),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.pop(true);
                  },
                  child: Text(AppGlossary.confirm.translate()),
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
