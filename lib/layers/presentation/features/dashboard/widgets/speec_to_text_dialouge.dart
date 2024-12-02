import 'package:flutter/material.dart';
import 'package:translate_now/layers/presentation/widgets/primary_button.dart';

class SpeechToTextDialouge extends StatefulWidget {
  const SpeechToTextDialouge({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => const SpeechToTextDialouge(),
    );
  }

  @override
  State<SpeechToTextDialouge> createState() => _SpeechToTextDialougeState();
}

class _SpeechToTextDialougeState extends State<SpeechToTextDialouge> {
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Please speak",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Press the button and start speaking",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            PrimaryBotton(
              onPressed: () {},
              text: "Submit",
            ),
          ],
        ),
      ),
    );
  }
}
