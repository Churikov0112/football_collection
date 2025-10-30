part of '../home_screen.dart';

class _DraftTile extends StatelessWidget {
  const _DraftTile();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<SavedCardsBloc, SavedCardsState>(
      bloc: getIt.get<SavedCardsBloc>(),
      builder: (context, savedState) {
        final savedCardsIds = savedState.savedCardsIds ?? [];

        return GestureDetector(
          onTap: () {
            if (savedCardsIds.length < 100) {
              ToastService.showErrorToast(title: AppGlossary.draftLimitation.translate());
              return;
            }
            try {
              FirebaseAnalytics.instance.logEvent(name: "draft_opened");
            } catch (e) {
              LogService.error(e.toString(), e);
            }
            BottomSheetController.showBottomSheet(context, (context) => const DraftDescriptionScreen());
          },
          child: FrostedGlassContainer(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            blupColor: Colors.white10,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                border: Border.all(color: Colors.white54, width: 4), // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [
                //     Colors.white.withOpacity(0.5),
                //     Colors.white.withOpacity(0.1),
                //     Colors.white.withOpacity(0.1),
                //     Colors.white.withOpacity(0.5),
                //   ],
                //   stops: const [0.0, 0.15, 0.85, 1.0],
                // ),
              ),
              child: SizedBox(
                width: size.width,
                height: 150,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "D R A F T",
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
