import 'package:flutter/material.dart';
import 'package:radon_app/widgets/asap_text.dart';
class FooAppbar extends AppBar {
  FooAppbar({super.key, required BuildContext context, required String title, Function? onPressed})
      : super(
    title: AsapText(
      text: title,
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).colorScheme.onSurface,
    ),
    leading: Navigator.canPop(context) ? IconButton(
      onPressed: () {
        onPressed != null ? onPressed() : Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.chevron_left_rounded,
        size: 40,
      ),
    ) : null,
    elevation: 0,
    centerTitle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
  );
}