import 'package:flutter/material.dart';

class TriviaButton extends StatelessWidget {
  final IconData icon;
  final void Function() function;
  final Color bgColor;
  final Color iconColor;
  final double size;

  const TriviaButton({
    Key? key,
    required this.icon,
    required this.function,
    this.bgColor = Colors.green,
    this.iconColor = Colors.white,
    this.size = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: function,
        icon: Icon(icon),
        color: iconColor,
      ),
    );
  }
}
