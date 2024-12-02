import 'package:flutter/material.dart';
import 'package:translate_now/layers/domain/entity/tnc_entity.dart';
import 'package:translate_now/layers/presentation/constants/theme.dart';
import 'package:translate_now/layers/presentation/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:translate_now/layers/presentation/features/dashboard/widgets/speec_to_text_dialouge.dart';
import 'package:translate_now/layers/presentation/widgets/primary_button.dart';
import 'package:translate_now/layers/presentation/widgets/secondary_button.dart';

class AddUpdateTncBottomsheet extends StatefulWidget {
  const AddUpdateTncBottomsheet({
    super.key,
    this.tnc,
  });


  final TncEntity? tnc;
  static Future<bool?> show(
    BuildContext context, {
    TncEntity? tnc,
  }) async {
    return showModalBottomSheet<bool>(
      isScrollControlled: true,
      
      backgroundColor: AppTheme.primaryColor,
      context: context,
      builder: (_) => AddUpdateTncBottomsheet(
        tnc: tnc,
      ),
    );
  }

  @override
  State<AddUpdateTncBottomsheet> createState() =>
      _AddUpdateTncBottomsheetState();
}

class _AddUpdateTncBottomsheetState extends State<AddUpdateTncBottomsheet> {
  final TextEditingController _controllerTEC = TextEditingController();
  final FocusNode _focusNode = FocusNode();


  late TncEntity _tnc = widget.tnc ?? TncEntity.newTnc();
  late final bool isEdit = widget.tnc != null;

  String _translatedText = '';
  bool get _didTranslate => _translatedText.isNotEmpty;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.tnc != null) {
        _controllerTEC.text = _tnc.value;
      }
      _getTranslatedText();
      _focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllerTEC.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _getTranslatedText() async {
    final translatedText = dashboardCubit.getTranslation(_tnc);

    setState(() {
      _translatedText = translatedText;
    });
  }

  void _translateToHindi() async {
    final translatedText = await dashboardCubit.transalteText(_tnc);

    setState(() {
      _translatedText = translatedText;
    });
  }

  void _onValueChange(String value) {
    _tnc = _tnc.copyWith(value: value);
    setState(() {
      _translatedText = '';
    });
  }

  void _handleMicTap() {
      SpeechToTextDialouge.show(context);
  }

  void _onConfirmTap() {
    if (isEdit) {
      dashboardCubit.updateTnc(_tnc);
    } else {
      dashboardCubit.addTnc(_tnc);
    }
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => FocusScope.of(context).unfocus(),
    child: Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: keyboardHeight + 20, 
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? 'Edit Terms & Conditions' : 'Add new Terms & Conditions',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextFormField(
              focusNode: _focusNode,
              controller: _controllerTEC,
              onChanged: _onValueChange,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.mic),
                  color: Colors.white,
                  onPressed: _handleMicTap,
                ),
                labelText: "Terms & Conditions",
                focusColor: Colors.white,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppTheme.quaternaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
           
            if (_didTranslate) ...[
              const SizedBox(height: 20),
              const Text(
                'Translated Text',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 21),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      _translatedText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
            ValueListenableBuilder(
              valueListenable: _controllerTEC,
              builder: (_, data, __) {
                if (data.text.isEmpty || _didTranslate) {
                  return const SizedBox();
                }
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SecondaryButton(
                          text: 'View in Hindi',
                          onPressed: _translateToHindi,
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            PrimaryBotton(
              text: 'Confirm',
              onPressed: _onConfirmTap,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
  }
}
