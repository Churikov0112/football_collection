part of '../guess_who_is_more_expensive_screen.dart';

class _GuessOptionsLessMoreEqual extends StatelessWidget {
  const _GuessOptionsLessMoreEqual({
    required this.options,
    required this.rightAnswer,
  });

  final List<String> options;
  final String rightAnswer;

  @override
  Widget build(BuildContext context) {
    final presenter = GuessWhichFootballPlayerIsMoreExpensiveScreenPresenter.of(context);

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
                          border: selectedOption == null ? Border.all() : null,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: Text(option, style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
