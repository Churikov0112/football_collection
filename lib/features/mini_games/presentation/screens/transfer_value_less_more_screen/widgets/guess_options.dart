import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/random_players_bloc/random_players_bloc.dart';
import 'package:football_collection/services/toast/toast_service.dart';

class GuessOptionsLessMoreEqual extends StatelessWidget {
  const GuessOptionsLessMoreEqual({
    required this.options,
    required this.rightAnswer,
    super.key,
  });

  final List<String> options;
  final String rightAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        spacing: 16,
        children: [
          for (final option in options)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  if (option == rightAnswer) {
                    getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 1));
                    ToastService.showToast(title: "Правильно!", subtitle: "Начислено 1 🏆", seconds: 1);
                  } else {
                    ToastService.showErrorToast(title: "Неправильно!", seconds: 1);
                  }
                  context.read<RandomPlayersBloc>().add(RandomPlayersEventGet(count: 2, hasTransferValue: true));
                },
                child: Text(option),
              ),
            ),
        ],
      ),
    );
  }
}
