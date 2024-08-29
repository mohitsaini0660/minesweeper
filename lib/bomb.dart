import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyBomb extends StatelessWidget {
  bool revealed;
  // ignore: prefer_typing_uninitialized_variables
  final function;

  MyBomb({required this.revealed, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          color: revealed ? Colors.grey[800] : Colors.grey[400],
        ),
      ),
    );
  }
}
