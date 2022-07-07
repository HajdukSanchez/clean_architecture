import 'package:flutter/material.dart';

class TriviaButton extends StatelessWidget {
  const TriviaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.red,
        child: const Text("Search"),
      ),
    );
  }
}
