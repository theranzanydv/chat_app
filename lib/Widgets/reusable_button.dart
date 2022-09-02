import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color colour;

  const ReusableButton({
    required this.buttonText,
    required this.onPressed,
    required this.colour,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(buttonText, style: const TextStyle(letterSpacing: 1.5, fontSize: 15)),
        ),
      ),
    );
  }
}
