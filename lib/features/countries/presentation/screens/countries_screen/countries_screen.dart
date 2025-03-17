import 'package:flutter/material.dart';

part 'countries_screen_presenter.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return CountriesScreenPresenter(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: mq.padding.top),
          ],
        ),
      ),
    );
  }
}
