import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FooContainer extends HookWidget {
  const FooContainer(
      {super.key,
      required this.title,
      required this.titleIcon,
      required this.titleColor,
      required this.borderRadius,
      required this.backgroundColor,
      required this.body});

  final String title;
  final IconData titleIcon;
  final Color titleColor;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(titleIcon, color: titleColor),
              Text(title, style: TextStyle(color: titleColor)),
            ],
          ),
          body,
        ],
      ),
    );
  }
}
