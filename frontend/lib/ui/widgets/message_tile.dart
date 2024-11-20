import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';
import 'package:sandbox/data-layer/models/message.dart';
import 'package:sandbox/data-layer/providers/messages_provider.dart';
import 'package:sandbox/utils/date_time_utils.dart';

class MessageTile extends StatefulWidget {
  final int index;
  final Message message;

  const MessageTile({
    required this.index,
    required this.message,
    super.key,
  });

  static double height = 100;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        context.read<MessagesProvider>().setSelectedMessage(
              currentSelectedMessageIndex: widget.index,
            );
      },
      splashColor: Colors.transparent,
      child: Container(
        height: MessageTile.height,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: SandboxColors.grey2,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildInfoSection(),
            _buildIndicatorSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SandboxPaddings.m,
          vertical: SandboxPaddings.s,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message.senderName,
              style: SandboxTextStyle.bodySmall.copyWith(
                color: SandboxColors.grey3,
              ),
            ),
            Text(
              widget.message.subject,
              style: SandboxTextStyle.titleSmall,
            ),
            Text(
              widget.message.shortText,
              style: SandboxTextStyle.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateTimeUtils.localizeDateTime(
                  context: context,
                  dateTime: widget.message.createdAt,
                ),
                style: SandboxTextStyle.bodySmall.copyWith(
                  color: SandboxColors.grey3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorSection() {
    return Container(
      width: 5,
      height: double.infinity,
      decoration: BoxDecoration(
          color: context.watch<MessagesProvider>().selectedMessage?.id == widget.message.id ? SandboxColors.blue : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            bottomLeft: Radius.circular(2),
          )),
    );
  }
}
