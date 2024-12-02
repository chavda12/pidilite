import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translate_now/layers/presentation/constants/theme.dart';
import 'package:translate_now/layers/presentation/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:translate_now/layers/presentation/features/dashboard/widgets/add_tnc_bottomsheet.dart';
import 'package:translate_now/layers/presentation/features/dashboard/widgets/tnc_tile.dart';
import 'package:translate_now/layers/presentation/widgets/primary_button.dart';

class DashboardUi extends StatefulWidget {
  const DashboardUi({super.key});

  @override
  State<DashboardUi> createState() => _DashboardUiState();
}

class _DashboardUiState extends State<DashboardUi> {
  final ScrollController _scrollController = ScrollController();

  bool get isControllerAtEnd =>
      _scrollController.position.pixels ==
      _scrollController.position.maxScrollExtent;

  @override
  void initState() {
    dashboardCubit.fetchTncPaginated();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_loadNextPage);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextPage);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<DashboardCubit>();

    final tncList = dashboardState.tncList;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Loaded TnC: ${tncList.length}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: tncList.length,
                  itemBuilder: (_, index) {
                    return TncTile(tnc: tncList[index]);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                ),
              ),
              if (tncList.isAtLastPage) ...{
                const SizedBox(height: 20),
                PrimaryBotton(
                  text: 'Add More',
                  onPressed: _handleLoadMore,
                )
              },
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLoadMore() {
  
    AddUpdateTncBottomsheet.show(context).then((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _loadNextPage() {
    if (isControllerAtEnd) {
      dashboardCubit.fetchTncPaginated();
    }
  }
}
