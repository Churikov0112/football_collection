part of '../guess_market_value_up_or_down_screen.dart';

class _GuessOptions extends StatelessWidget {
  const _GuessOptions({required this.options, required this.rightAnswer});

  final List<String> options;
  final String rightAnswer;

  @override
  Widget build(BuildContext context) {
    // final shuffledOptions = [...options];
    // shuffledOptions.shuffle();
    final presenter = GuessMarketValueUpOrDownScreenPresenter.of(context);

    return StreamBuilder<String?>(
      stream: presenter.selectedOptionStream$,
      builder: (context, selectedOptionSnapshot) {
        final selectedOption = selectedOptionSnapshot.data;
        final guessed = selectedOption == rightAnswer;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: 16,
            children: [
              for (final option in options)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (selectedOption == null) {
                        presenter.showResult(selectedAnswer: option, rightAnswer: rightAnswer);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedOption != null
                            ? guessed
                                  ? selectedOption == option
                                        ? Colors.green
                                        : Colors.black54
                                  : selectedOption == option
                                  ? Colors.red
                                  : option == rightAnswer
                                  ? Colors.green
                                  : Colors.black54
                            : Colors.black54,
                        border: selectedOption == null ? Border.all() : null,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Text(option, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
