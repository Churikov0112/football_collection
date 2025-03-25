import 'package:flutter/material.dart';
import 'package:football_collection/services/toast/toast_service.dart';

class GuessOptions extends StatelessWidget {
  const GuessOptions({
    required this.options,
    required this.rightAnswer,
    super.key,
  });

  final List<String> options;
  final String rightAnswer;

  @override
  Widget build(BuildContext context) {
    final shuffledOptions = [...options];
    shuffledOptions.shuffle();

    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: [
          for (final option in shuffledOptions)
            OutlinedButton(
              onPressed: () {
                if (option == rightAnswer) {
                  ToastService.showToast(title: "Правильно!", subtitle: "Начислено 1 🏆");
                } else {
                  ToastService.showErrorToast(title: "Неправильно!");
                }
              },
              child: Text(option),
            ),
        ],
      ),
    );
  }
}
