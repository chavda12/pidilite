import 'package:flutter/material.dart';
import 'package:translate_now/layers/domain/entity/tnc_entity.dart';
import 'package:translate_now/layers/presentation/constants/theme.dart';
import 'package:translate_now/layers/presentation/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:translate_now/layers/presentation/features/dashboard/widgets/add_tnc_bottomsheet.dart';
import 'package:translate_now/layers/presentation/widgets/secondary_button.dart';

class TncTile extends StatefulWidget {
  final TncEntity tnc;
  const TncTile({
    super.key,
    required this.tnc,
  });

  @override
  State<TncTile> createState() => _TncTileState();
}

class _TncTileState extends State<TncTile> {
  bool _hasTranslated = false;
  String _translatedText = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      _getTranslation();
    });
    super.initState();
  }

  void _getTranslation() {
    final translatedText = dashboardCubit.getTranslation(widget.tnc);
    if (translatedText.isEmpty) return;
    setState(() {
      _translatedText = translatedText;
      _hasTranslated = true;
    });
  }

  void _handleOnPressed() async {
    final translatedText = await dashboardCubit.transalteText(widget.tnc);

    if (translatedText.isEmpty) return;
    setState(() {
      _translatedText = translatedText;
      _hasTranslated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AddUpdateTncBottomsheet.show(
        context,
        tnc: widget.tnc,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppTheme.secondaryColor,
          border: Border.all(
            color: AppTheme.tertiaryColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.tnc.value,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            if (_hasTranslated) ...{
              const Divider(
                color: AppTheme.tertiaryColor,
              ),
              Text(
                _translatedText,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            } else ...{
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(
                    text: "Read In Hindi",
                    onPressed: _handleOnPressed,
                  ),
                ],
              )
            },
          ],
        ),
      ),
    );
  }
}
