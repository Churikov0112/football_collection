import 'package:flutter/material.dart';
import 'package:football_collection/features/mini_games/presentation/widgets/balance_widget/balance_widget.dart';
import 'package:football_collection/ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import 'package:go_router/go_router.dart';

import '../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import 'watch_ad_screen/watch_ad_screen.dart';

class TransparentAppbar extends StatelessWidget {
  const TransparentAppbar({
    required this.title,
    this.foregroundColor,
    this.backgroundColor,
    this.showDrawer = false,
    this.showBalance = true,
    super.key,
  });

  final String title;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool showDrawer;
  final bool showBalance;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return FrostedGlassContainer(
      blupColor: backgroundColor?.withOpacity(0.26) ?? Colors.black26,
      child: Padding(
        padding: EdgeInsets.only(top: mq.padding.top + 8, right: 8, left: 8, bottom: 8),
        child: Row(
          children: [
            if (showDrawer)
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu, color: foregroundColor ?? Colors.white),
              )
            else
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back, color: foregroundColor ?? Colors.white),
              ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: foregroundColor ?? Colors.white),
              ),
            ),
            if (showBalance) ...[
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  BottomSheetController.showBottomSheet(context, (context) => const WatchAdScreen());
                },
                child: BalanceWidget(textColor: foregroundColor ?? Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
