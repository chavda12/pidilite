import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:translate_now/layers/di/setup_locators.dart' as di;
import 'package:translate_now/layers/presentation/constants/globals.dart';
import 'package:translate_now/layers/presentation/features/dashboard/dashboard_ui.dart';
import 'package:translate_now/layers/presentation/utils/loader.dart';
import 'package:translate_now/layers/presentation/widgets/cubit_wrapper.dart';
import 'package:translate_now/layers/presentation/widgets/loader_widget.dart';

Future<void> initDeps() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setupLocators();
}

void main() {
  runZonedGuarded(
    () async {
      await initDeps();
      runApp(const CubitWrapper(
        child: TranslateNowApp(),
      ));
    },
    (e, st) {},
  );
}

class TranslateNowApp extends StatelessWidget {
  const TranslateNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    setContext(context);
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      home: LoaderOverlay(
        overlayColor: Colors.black.withOpacity(0.5),
        overlayWidgetBuilder: (progress) => const LoaderWidget(),
        child: Builder(builder: (context) {
          setLoadderContext(context);
          return const DashboardUi();
        }),
      ),
    );
  }
}
