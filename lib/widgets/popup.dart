import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/widgets/asap_text.dart';

class PopupHookWidget extends HookWidget {
  const PopupHookWidget(
      {super.key, required this.title, required this.onConfirm});

  final String title;
  final Function(String) onConfirm;

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return AlertDialog(
      title: AsapText(text: title),
      content: TextField(
        controller: textEditingController,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const AsapText(text: 'Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm(textEditingController.text);
            Navigator.of(context).pop();
          },
          child: const AsapText(text: 'Confirm'),
        ),
      ],
    );
  }
}
