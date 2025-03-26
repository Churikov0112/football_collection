import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';

import '../../blocs/balance_bloc/balance_bloc.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BalanceBloc, BalanceState>(
      bloc: getIt.get(),
      builder: (context, balanceState) {
        final balance = balanceState.balance ?? 0;
        return Text("$balance 🏆");
      },
    );
  }
}
