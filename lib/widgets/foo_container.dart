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
      required this.child,
      });

  final String title;
  final IconData titleIcon;
  final Color titleColor;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      padding: const EdgeInsets.only(
        right: 12,
        top: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 24),
              Icon(titleIcon, color: titleColor),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(color: titleColor)),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
