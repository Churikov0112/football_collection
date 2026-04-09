part of '../guess_flag_by_country_screen.dart';

class _GuessOptions extends StatelessWidget {
  const _GuessOptions({required this.rightAnswer, required this.options});

  final List<FootballNationalTeamModel> options;
  final FootballNationalTeamModel rightAnswer;

  @override
  Widget build(BuildContext context) {
    final presenter = GuessFlagByCountryScreenPresenter.of(context);

    return StreamBuilder<String?>(
      stream: presenter.selectedOptionStream$,
      builder: (context, selectedOptionSnapshot) {
        final selectedOption = selectedOptionSnapshot.data;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
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
    final presenter = GuessFlagByCountryScreenPresenter.of(context);
    final mq = MediaQuery.of(context);
    final tileWidth = (mq.size.width - 12 - 12 - 12) / 2;
    final isAnswered = selectedOption != null;
    final isSelected = selectedOption == option.id;
    final isRight = option.id == rightAnswer.id;
    final isCorrectSelection = isAnswered && selectedOption == rightAnswer.id;
    final overlayColor = !isAnswered
        ? null
        : isCorrectSelection
        ? (isSelected ? Colors.green.withOpacity(0.7) : null)
        : isSelected
        ? Colors.red.withOpacity(0.7)
        : isRight
        ? Colors.green.withOpacity(0.7)
        : null;

    return GestureDetector(
      onTap: () async {
        if (selectedOption == null) {
          presenter.showResult(selectedAnswer: option, rightAnswer: rightAnswer);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: SizedBox(
          width: tileWidth,
          height: tileWidth,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/raster/team_flags/${option.id}.jpg', fit: BoxFit.cover),
              if (overlayColor != null) ColoredBox(color: overlayColor),
              if (overlayColor != null)
                Center(child: Icon(isRight ? Icons.check : Icons.close, color: Colors.white, size: 32)),
            ],
          ),
        ),
      ),
    );
  }
}
