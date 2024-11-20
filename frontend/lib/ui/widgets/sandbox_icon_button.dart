import 'package:flutter/material.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';

class SandboxIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final double iconSize;
  final double padding;
  final bool enabled;

  const SandboxIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.iconSize = 22,
    this.padding = SandboxPaddings.m,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: RawMaterialButton(
        enableFeedback: enabled,
        onPressed: () {
          if (enabled) {
            onTap?.call();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(iconSize / 3),
        ),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: const BoxConstraints(),
        padding: EdgeInsets.all(padding),
        splashColor: Colors.transparent,
        child: Icon(
          icon,
          color: (iconColor ?? SandboxColors.black).withOpacity(enabled ? 1 : 0.6),
          size: iconSize,
        ),
      ),
    );
  }
}
