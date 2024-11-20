import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';
import 'package:sandbox/data-layer/providers/account_provider.dart';
import 'package:sandbox/data-layer/providers/messages_provider.dart';
import 'package:sandbox/ui/routing/sandbox_router.dart';
import 'package:sandbox/ui/screens/login_screen.dart';
import 'package:sandbox/ui/widgets/action_dialog.dart';
import 'package:sandbox/ui/widgets/content_body_widget.dart';
import 'package:sandbox/ui/widgets/keboard_shortcuts_tooltip.dart';
import 'package:sandbox/ui/widgets/message_tile.dart';
import 'package:sandbox/ui/widgets/sandbox_button.dart';
import 'package:sandbox/ui/widgets/sandbox_icon_button.dart';
import 'package:sandbox/ui/widgets/sandbox_text_field.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';
  static const String routePath = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<MessagesProvider>().getMessages();
    });
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      context.read<MessagesProvider>().getNewMessages();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isBottom = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
        if (isBottom) {
          if (context.read<MessagesProvider>().hasNextPage) {
            context.read<MessagesProvider>().getMessages();
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: SandboxColors.white,
        body: Row(
          children: [
            _buildMenuSection(),
            _buildBodySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1,
            color: SandboxColors.grey2,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildSearchSection(),
          _buildMessagesListSection(),
          _buildFooterSection(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(
        left: SandboxPaddings.s,
        right: SandboxPaddings.s,
      ),
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
          Image.asset(
            'assets/images/logos/logo.png',
            width: 30,
          ),
          const SizedBox(
            width: SandboxPaddings.s,
          ),
          Expanded(
            child: SandboxTextField(
              trailing: Icon(
                Icons.search_rounded,
                size: 20,
              ),
              hint: 'Search...',
              onChanged: (value) {
                context.read<MessagesProvider>().setQuery(
                      currentQuery: value,
                    );
              },
            ),
          ),
          const SizedBox(
            width: SandboxPaddings.s,
          ),
          SandboxTooltip(
            label: 'Refresh messages',
            child: SandboxIconButton(
              icon: Icons.refresh_rounded,
              onTap: () async {
                context.read<MessagesProvider>().clear();
                await context.read<MessagesProvider>().getMessages();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesListSection() {
    if (context.read<MessagesProvider>().messages.isEmpty) {
      return Expanded(
        child: Column(
          children: [
            const SizedBox(
              height: SandboxPaddings.xm,
            ),
            Center(
              child: Text(
                'Nothing found...',
                style: SandboxTextStyle.bodyMedium,
              ),
            ),
            const Spacer(),
          ],
        ),
      );
    } else {
      return Expanded(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return MessageTile(
                index: index,
                message: context.read<MessagesProvider>().messages[index],
              );
            },
            itemCount: context.watch<MessagesProvider>().messages.length,
          ),
        ),
      );
    }
  }

  Widget _buildFooterSection() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(
        left: SandboxPaddings.s,
        right: SandboxPaddings.s,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: SandboxColors.grey2,
          ),
        ),
      ),
      child: Row(
        children: [
          SandboxButton(
            fillColor: SandboxColors.red,
            labelColor: SandboxColors.white,
            label: 'Logout',
            onTap: () async {
              final bool? isConfirmed = await ActionDialog().show(
                title: 'Logout?',
                subTitle: 'Logout ok?',
                dismissAction: 'No',
                confirmAction: 'Yes',
                negativeButtonColor: SandboxColors.red,
                negativeTitleColor: SandboxColors.white,
              );
              if (isConfirmed ?? false) {
                await context.read<AccountProvider>().logout();
                sandboxRouter.goNamed(LoginScreen.routeName);
              }
            },
          ),
          const Spacer(),
          SandboxTooltip(
            label: 'Open documentation',
            child: SandboxIconButton(
              icon: Icons.help_outline_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodySection() {
    return Expanded(
      child: Column(
        children: [
          _buildHeaderSection(),
          _buildContentSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: SandboxColors.grey2,
          ),
        ),
      ),
      padding: const EdgeInsets.only(
        left: SandboxPaddings.m,
        right: SandboxPaddings.m,
      ),
      child: Stack(
        children: [
          _buildViewTypeSelectorSection(),
          if (context.watch<MessagesProvider>().selectedMessageIndex != null) _buildMessageSelectorSection(),
          Align(
            alignment: Alignment.centerRight,
            child: SandboxIconButton(
              enabled: context.watch<MessagesProvider>().selectedMessage != null,
              icon: Icons.delete_rounded,
              iconColor: SandboxColors.red,
              onTap: () async {
                final bool? confirmed = await ActionDialog().show(
                  title: 'Delete this email?',
                  subTitle: 'Do you really want to delete this email?',
                  dismissAction: 'No',
                  confirmAction: 'Yes',
                  negativeButtonColor: SandboxColors.red,
                  negativeTitleColor: SandboxColors.white,
                );
                if (confirmed ?? false) {
                  await context.read<MessagesProvider>().deleteMessage(
                        messageId: context.read<MessagesProvider>().selectedMessage!.id,
                      );
                  context.read<MessagesProvider>().clear(clearQuery: false);
                  await context.read<MessagesProvider>().getMessages();
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewTypeSelectorSection() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SandboxTooltip(
            label: 'View rendered email',
            child: SandboxIconButton(
              icon: Icons.newspaper,
              iconColor: context.watch<MessagesProvider>().messageViewType == MessageViewType.rendered ? SandboxColors.blue : SandboxColors.grey3,
              onTap: () {
                context.read<MessagesProvider>().setMessageViewType(currentMessageviewType: MessageViewType.rendered);
              },
            ),
          ),
          SandboxTooltip(
            label: 'View email in plain text',
            child: SandboxIconButton(
              icon: Icons.text_format,
              iconColor: context.watch<MessagesProvider>().messageViewType == MessageViewType.text ? SandboxColors.blue : SandboxColors.grey3,
              onTap: () {
                context.read<MessagesProvider>().setMessageViewType(currentMessageviewType: MessageViewType.text);
              },
            ),
          ),
          SandboxTooltip(
            label: 'View email code',
            child: SandboxIconButton(
              icon: Icons.code,
              iconColor: context.watch<MessagesProvider>().messageViewType == MessageViewType.code ? SandboxColors.blue : SandboxColors.grey3,
              onTap: () {
                context.read<MessagesProvider>().setMessageViewType(currentMessageviewType: MessageViewType.code);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageSelectorSection() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SandboxIconButton(
            enabled: context.watch<MessagesProvider>().selectedMessageIndex != 0,
            icon: Icons.arrow_back_ios_rounded,
            iconSize: 18,
            onTap: () {
              context.read<MessagesProvider>().setSelectedMessage(
                    currentSelectedMessageIndex: context.read<MessagesProvider>().selectedMessageIndex! - 1,
                  );
              _scrollController.animateTo(
                (context.read<MessagesProvider>().selectedMessageIndex!) * MessageTile.height,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
          const SizedBox(
            width: SandboxPaddings.s,
          ),
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                '${(context.watch<MessagesProvider>().selectedMessageIndex ?? 0) + 1} of ${context.watch<MessagesProvider>().totalMessages}',
                style: SandboxTextStyle.labelLarge,
              ),
            ),
          ),
          const SizedBox(
            width: SandboxPaddings.s,
          ),
          SandboxIconButton(
            enabled: context.watch<MessagesProvider>().selectedMessageIndex != context.watch<MessagesProvider>().totalMessages - 1,
            icon: Icons.arrow_forward_ios_rounded,
            iconSize: 18,
            onTap: () {
              context.read<MessagesProvider>().setSelectedMessage(
                    currentSelectedMessageIndex: context.read<MessagesProvider>().selectedMessageIndex! + 1,
                  );
              _scrollController.animateTo(
                (context.read<MessagesProvider>().selectedMessageIndex!) * MessageTile.height,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Expanded(
      child: ContentBodyWidget(),
    );
  }
}
