import 'package:flutter/material.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';
import 'package:sandbox/ui/routing/sandbox_navigator_key.dart';
import 'package:sandbox/ui/widgets/sandbox_button.dart';

class ActionDialog {
  Future<bool?> show({
    required String title,
    required String subTitle,
    required String dismissAction,
    required String confirmAction,
    Color? negativeButtonColor,
    Color? negativeTitleColor,
  }) async {
    if (sandboxNavigatorKey.currentContext != null) {
      return showDialog<bool>(
        context: sandboxNavigatorKey.currentContext!,
        builder: (context) {
          return Dialog(
            surfaceTintColor: SandboxColors.white,
            backgroundColor: SandboxColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SandboxPaddings.lm,
                  vertical: SandboxPaddings.m,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: SandboxPaddings.xs,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: SandboxTextStyle.titleLarge,
                      ),
                    ),
                    const SizedBox(
                      height: SandboxPaddings.xs,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subTitle,
                        style: SandboxTextStyle.labelLarge.copyWith(
                          color: SandboxColors.grey3,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: SandboxPaddings.s,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SandboxButton(
                          label: dismissAction,
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        const SizedBox(
                          width: SandboxPaddings.lm,
                        ),
                        SandboxButton(
                          label: confirmAction,
                          labelColor: negativeTitleColor,
                          fillColor: negativeButtonColor ?? SandboxColors.grey1,
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    return false;
  }
}
