import 'package:flutter/material.dart';
import 'package:translate_now/layers/presentation/constants/theme.dart';
import 'package:translate_now/layers/presentation/extensions/context_extension.dart';

class PrimaryBotton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const PrimaryBotton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(context.width, 50),
        ),
        backgroundColor: const WidgetStatePropertyAll(
          AppTheme.quaternaryColor,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
