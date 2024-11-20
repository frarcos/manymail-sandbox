import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';
import 'package:sandbox/data-layer/providers/messages_provider.dart';
import 'package:sandbox/ui/widgets/attachment_tile.dart';
import 'package:sandbox/utils/date_time_utils.dart';

class ContentBodyWidget extends StatefulWidget {
  const ContentBodyWidget({super.key});

  @override
  State<ContentBodyWidget> createState() => _ContentBodyWidgetState();
}

class _ContentBodyWidgetState extends State<ContentBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildContentBodyHeaderSection(),
          SelectionArea(child: _buildContentBodySection()),
          if (context.read<MessagesProvider>().messageContent?.attachments.isNotEmpty ?? false) _buildAttachmentsSection(),
        ],
      ),
    );
  }

  Widget _buildContentBodyHeaderSection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: SandboxColors.grey2,
          ),
        ),
      ),
      padding: const EdgeInsets.all(SandboxPaddings.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${context.read<MessagesProvider>().selectedMessage?.senderName} <${context.read<MessagesProvider>().selectedMessage?.senderEmail}>',
                style: SandboxTextStyle.bodyMedium.copyWith(
                  color: SandboxColors.grey3,
                ),
              ),
              const Spacer(),
              Text(
                DateTimeUtils.localizeDateTime(
                  context: context,
                  dateTime: context.read<MessagesProvider>().selectedMessage?.createdAt,
                ),
                style: SandboxTextStyle.bodySmall.copyWith(
                  color: SandboxColors.grey3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: SandboxPaddings.xs,
          ),
          Text(
            context.read<MessagesProvider>().selectedMessage?.subject ?? '',
            style: SandboxTextStyle.titleLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildContentBodySection() {
    switch (context.watch<MessagesProvider>().messageViewType) {
      case MessageViewType.rendered:
        return _buildContentBodyHtmlSection();
      case MessageViewType.text:
        return _buildContentBodyTextSection();
      case MessageViewType.code:
        return _buildContentBodyCodeSection();
    }
  }

  Widget _buildContentBodyHtmlSection() {
    return HtmlWidget(
      context.read<MessagesProvider>().messageContentBody?.textHtml ?? '',
    );
  }

  Widget _buildContentBodyTextSection() {
    return Padding(
      padding: const EdgeInsets.all(SandboxPaddings.m),
      child: Text(
        context.read<MessagesProvider>().messageContentBody?.textBody ?? '',
        style: SandboxTextStyle.bodyMedium,
      ),
    );
  }

  Widget _buildContentBodyCodeSection() {
    return Padding(
      padding: const EdgeInsets.all(SandboxPaddings.m),
      child: Text(
        context.read<MessagesProvider>().messageContentBody?.textHtml ?? '',
        style: SandboxTextStyle.bodySmall,
      ),
    );
  }

  Widget _buildAttachmentsSection() {
    return Container(
      padding: const EdgeInsets.all(SandboxPaddings.m),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: SandboxColors.grey2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Attachments',
                style: SandboxTextStyle.titleLarge,
              ),
            ],
          ),
          const SizedBox(
            height: SandboxPaddings.s,
          ),
          Wrap(
            children: (context.read<MessagesProvider>().messageContent?.attachments ?? [])
                .map(
                  (attachment) => AttachmentTile(
                    attachment: attachment,
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
