import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: 150.0, // Set the desired width
          height: 50.0, // Set the desired height
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          alignment: Alignment.center,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}

