import 'package:flutter/material.dart';

class TriviaInputText extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?) onSubmit;

  const TriviaInputText({
    Key? key,
    required this.controller,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        controller: controller,
        onSubmitted: onSubmit,
        decoration: InputDecoration(
            hintText: "Ex. 123",
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.numbers_rounded, color: Colors.black.withOpacity(0.6))),
      ),
    );
  }
}
