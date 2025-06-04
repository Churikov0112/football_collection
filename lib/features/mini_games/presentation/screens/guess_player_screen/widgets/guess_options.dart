part of '../guess_player_screen.dart';

class _GuessOptions extends StatelessWidget {
  const _GuessOptions({
    required this.rightAnswer,
    required this.options,
  });

  final List<FootballPlayerModel> options;
  final FootballPlayerModel rightAnswer;

  @override
  Widget build(BuildContext context) {
    final presenter = GuessPlayerScreenPresenter.of(context);

    return StreamBuilder<FootballPlayerModel?>(
      stream: presenter.selectedOptionStream$,
      builder: (context, selectedOptionSnapshot) {
        final selectedOption = selectedOptionSnapshot.data;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 8,
            children: [
              for (final option in options) ...[
                _Option(
                  option: option,
                  selectedOption: selectedOption,
                  rightAnswer: rightAnswer,
                ),
              ],
              // if (selectedOption != null && !guessed) ...[
              //   const SizedBox(height: 16),
              //   DecoratedBox(
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.all(Radius.circular(12)),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 12),
              //       child: Center(
              //         child: Text(
              //           "${emojiFlagByCountryName(rightAnswer.name) ?? ""}  ${rightAnswer.name}",
              //           maxLines: 2,
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ],
            ],
          ),
        );
      },
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.option,
    required this.selectedOption,
    required this.rightAnswer,
  });

  final FootballPlayerModel option;
  final FootballPlayerModel rightAnswer;
  final FootballPlayerModel? selectedOption;

  @override
  Widget build(BuildContext context) {
    final presenter = GuessPlayerScreenPresenter.of(context);
    final guessed = selectedOption == rightAnswer;

    return GestureDetector(
      onTap: () async {
        if (selectedOption == null) {
          presenter.showResult(selectedAnswer: option, rightAnswer: rightAnswer);
        }
      },
      child: DecoratedBox(
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
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              "${emojiFlagByCountryName(option.name) ?? ""}  ${option.name}",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
