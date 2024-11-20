import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';

class SandboxTextField extends StatefulWidget {
  final bool autofocus;
  final String? initialValue;
  final String hint;
  final String? error;
  final int? maxLength;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Widget? trailing;
  final IconData? iconData;
  final TextInputAction? textInputAction;
  final Function(bool)? onFocusChange;
  final FocusNode? focusNode;
  final bool obscureText;

  const SandboxTextField({
    super.key,
    this.autofocus = false,
    this.initialValue,
    required this.hint,
    this.error,
    this.maxLength,
    this.onChanged,
    this.onFieldSubmitted,
    this.trailing,
    this.iconData,
    this.textInputAction,
    this.onFocusChange,
    this.focusNode,
    this.obscureText = false,
  });

  @override
  State<SandboxTextField> createState() => _SandboxTextFieldState();
}

class _SandboxTextFieldState extends State<SandboxTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autofocus: widget.autofocus,
          initialValue: widget.initialValue,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          selectionHeightStyle: BoxHeightStyle.max,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: SandboxColors.grey1.withOpacity(0.6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: SandboxPaddings.m,
              vertical: SandboxPaddings.mm,
            ),
            hintText: widget.hint,
            hintStyle: SandboxTextStyle.labelLarge.copyWith(
              color: SandboxColors.grey3,
            ),
            suffixIconConstraints: const BoxConstraints(),
            suffixIcon: widget.iconData != null
                ? Padding(
                    padding: const EdgeInsets.only(
                      right: SandboxPaddings.xm,
                    ),
                    child: Icon(
                      widget.iconData,
                      color: SandboxColors.grey3,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      right: SandboxPaddings.xm,
                    ),
                    child: widget.trailing,
                  ),
            counterText: '',
            counterStyle: const TextStyle(fontSize: 0),
          ),
          style: SandboxTextStyle.labelLarge,
        ),
        if (widget.error?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SandboxPaddings.s,
              vertical: SandboxPaddings.s,
            ),
            child: Text(
              widget.error!,
              style: SandboxTextStyle.labelMedium.copyWith(
                color: SandboxColors.red,
              ),
            ),
          ),
      ],
    );
  }
}
