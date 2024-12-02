import 'package:flutter/material.dart';
import 'package:translate_now/layers/presentation/constants/theme.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(
          AppTheme.tertiaryColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: AppTheme.quaternaryColor,
              width: 2
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
