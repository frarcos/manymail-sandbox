import 'package:flutter/material.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';

class SandboxTooltip extends StatelessWidget {
  final String label;
  final Widget child;
  final double verticalOffset;

  const SandboxTooltip({
    super.key,
    required this.label,
    required this.child,
    this.verticalOffset = SandboxPaddings.lm,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: BoxDecoration(
        color: SandboxColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: SandboxColors.grey1,
        ),
      ),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      verticalOffset: verticalOffset,
      preferBelow: false,
      waitDuration: const Duration(milliseconds: 500),
      richMessage: WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SandboxPaddings.s,
            vertical: SandboxPaddings.xs,
          ),
          child: Text(
            label,
            style: SandboxTextStyle.labelLarge,
          ),
        ),
      ),
      child: child,
    );
  }
}
