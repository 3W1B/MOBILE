import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:radon_app/widgets/asap_text.dart';

class FooContainer extends HookWidget {
  const FooContainer({
    super.key,
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
      padding: const EdgeInsets.all(
        8
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(titleIcon, color: titleColor),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AsapText(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor),
              ),
            ],
          ),
        child,
        ],
      ),
    );
  }
}
