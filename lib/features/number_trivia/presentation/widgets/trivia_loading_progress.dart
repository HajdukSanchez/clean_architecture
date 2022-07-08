import 'package:flutter/material.dart';

class TriviaLoadingProgress extends StatelessWidget {
  const TriviaLoadingProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: CircularProgressIndicator(color: Colors.green),
      ),
    );
  }
}
