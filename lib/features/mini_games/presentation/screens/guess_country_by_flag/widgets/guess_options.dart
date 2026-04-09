part of '../guess_country_by_flag_screen.dart';

class _GuessOptions extends StatelessWidget {
  const _GuessOptions({required this.rightAnswer, required this.options});

  final List<FootballNationalTeamModel> options;
  final FootballNationalTeamModel rightAnswer;

  @override
  Widget build(BuildContext context) {
    final presenter = GuessCountryByFlagScreenPresenter.of(context);

    return StreamBuilder<String?>(
      stream: presenter.selectedOptionStream$,
      builder: (context, selectedOptionSnapshot) {
        final selectedOption = selectedOptionSnapshot.data;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 8,
            children: [
              for (final option in options) ...[
                _Option(option: option, selectedOption: selectedOption, rightAnswer: rightAnswer),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({required this.option, required this.selectedOption, required this.rightAnswer});

  final FootballNationalTeamModel option;
  final FootballNationalTeamModel rightAnswer;
  final String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final presenter = GuessCountryByFlagScreenPresenter.of(context);
    final guessed = selectedOption == rightAnswer.id;

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
                    ? selectedOption == option.id
                          ? Colors.green
                          : Colors.black54
                    : selectedOption == option.id
                    ? Colors.red
                    : option.id == rightAnswer.id
                    ? Colors.green
                    : Colors.black54
              : Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              option.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
