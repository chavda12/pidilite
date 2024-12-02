import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translate_now/layers/presentation/features/dashboard/cubit/dashboard_cubit.dart';

class CubitWrapper extends StatelessWidget {
  final Widget child;
  const CubitWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => DashboardCubit(),
        )
      ],
      child: child,
    );
  }
}
