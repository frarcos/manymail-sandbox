import 'package:flutter/material.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';

class SandboxButton extends StatefulWidget {
  final Widget? icon;
  final String? label;
  final Widget? suffix;
  final VoidCallback? onTap;
  final bool active;
  final Color? fillColor;
  final Color? labelColor;
  final bool outlined;
  final bool expanded;
  final bool dense;

  const SandboxButton({
    super.key,
    this.icon,
    this.label,
    this.suffix,
    this.onTap,
    this.active = false,
    this.fillColor,
    this.labelColor,
    this.outlined = false,
    this.expanded = false,
    this.dense = false,
  });

  @override
  State<SandboxButton> createState() => _SandboxButtonState();
}

class _SandboxButtonState extends State<SandboxButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      descendantsAreFocusable: false,
      canRequestFocus: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: !widget.expanded ? 50 : 0,
        ),
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              hovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              hovered = false;
            });
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: hovered && widget.outlined ? SandboxColors.grey1.withOpacity(0.8) : Colors.transparent,
                width: 3,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: RawMaterialButton(
              onPressed: widget.onTap ?? () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: widget.fillColor ?? (widget.active ? SandboxColors.grey2.withOpacity(0.6) : Colors.transparent),
              splashColor: Colors.transparent,
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              highlightElevation: 0,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.symmetric(
                horizontal: widget.outlined ? SandboxPaddings.lm : SandboxPaddings.l,
                vertical: widget.dense ? SandboxPaddings.mm : 17,
              ),
              child: Row(
                mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  if (widget.icon != null) widget.icon!,
                  if (widget.label != null && widget.icon != null)
                    const SizedBox(
                      width: SandboxPaddings.s,
                    ),
                  if (widget.label != null)
                    Text(
                      widget.label!,
                      style: SandboxTextStyle.labelLarge.copyWith(
                        color: widget.labelColor,
                      ),
                    ),
                  if (widget.suffix != null) const Spacer(),
                  if (widget.suffix != null)
                    const SizedBox(
                      width: SandboxPaddings.lm,
                    ),
                  if (widget.suffix != null) widget.suffix!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
