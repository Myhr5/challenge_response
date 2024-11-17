import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, this.onTap, required this.widget});

  final Function()? onTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Center(
          child: widget,
        ),
      ),
    );
  }
}
