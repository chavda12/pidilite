import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCube(
        color: Colors.white,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
