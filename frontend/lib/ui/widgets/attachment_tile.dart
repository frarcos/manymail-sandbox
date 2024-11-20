import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';
import 'package:sandbox/data-layer/models/message_attachment.dart';
import 'package:sandbox/data-layer/providers/messages_provider.dart';
import 'package:sandbox/ui/widgets/action_dialog.dart';

class AttachmentTile extends StatelessWidget {
  final MessageAttachment attachment;

  const AttachmentTile({
    super.key,
    required this.attachment,
  });

  Color get color {
    return SandboxColors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: RawMaterialButton(
        onPressed: () async {
          final bool? confirmed = await ActionDialog().show(
            title: 'Download attachment?',
            subTitle: 'Do you really want to download "${attachment.filename}"?',
            dismissAction: 'No',
            confirmAction: 'Yes',
            negativeButtonColor: SandboxColors.blue,
            negativeTitleColor: SandboxColors.white,
          );
          if (confirmed ?? false) {
            context.read<MessagesProvider>().downloadMessageAttachment(
                  attachment,
                );
          }
        },
        splashColor: Colors.transparent,
        child: Container(
          width: 120,
          height: 110,
          padding: const EdgeInsets.all(SandboxPaddings.s),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: SandboxColors.grey1,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.file_present_rounded,
                      color: SandboxColors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: SandboxPaddings.xs,
              ),
              Text(
                attachment.filename,
                style: SandboxTextStyle.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
