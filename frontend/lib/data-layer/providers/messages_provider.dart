import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:sandbox/data-layer/models/message.dart';
import 'package:sandbox/data-layer/models/message_attachment.dart';
import 'package:sandbox/data-layer/models/message_content.dart';
import 'package:sandbox/data-layer/models/message_content_body.dart';
import 'package:sandbox/data-layer/models/messages_response.dart';
import 'package:sandbox/data-layer/models/new_messages_response.dart';
import 'package:sandbox/data-layer/models/standard_response.dart';
import 'package:sandbox/data-layer/services/messages_service.dart';

enum MessageViewType {
  rendered,
  text,
  code,
}

class MessagesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Message> messages = [];
  int totalMessages = 0;
  DateTime? lastRequest;
  MessageViewType messageViewType = MessageViewType.rendered;
  String? query;
  int? selectedMessageIndex;
  Message? selectedMessage;
  MessageContent? messageContent;
  MessageContentBody? messageContentBody;
  int page = 1;
  bool hasNextPage = true;

  void setMessageViewType({
    required MessageViewType currentMessageviewType,
  }) {
    messageViewType = currentMessageviewType;
    notifyListeners();
  }

  void setQuery({
    String? currentQuery,
  }) {
    query = currentQuery ?? query;
    page = 1;
    getMessages();
  }

  Future<void> setSelectedMessage({
    required int currentSelectedMessageIndex,
  }) async {
    selectedMessageIndex = currentSelectedMessageIndex;
    selectedMessage = messages[currentSelectedMessageIndex];
    await getMessageContent(messageId: selectedMessage!.id);
    await getMessageContentBody();
  }

  Future<void> getNewMessages() async {
    isLoading = true;
    notifyListeners();
    final NewMessagesResponse? newMessagesResponse = await MessagesService.getNewMessages(
      query: query ?? '',
      from: lastRequest ?? DateTime.now(),
    );
    lastRequest = DateTime.now().toUtc();
    messages = [...newMessagesResponse?.messages ?? [], ...messages];
    totalMessages = newMessagesResponse?.total ?? 0;
    if (selectedMessage == null && messages.isNotEmpty) {
      await setSelectedMessage(
        currentSelectedMessageIndex: 0,
      );
    }
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMessages() async {
    isLoading = true;
    notifyListeners();
    final MessagesResponse? messagesResponse = await MessagesService.getMessages(
      page: page,
      query: query ?? '',
    );
    lastRequest = DateTime.now().toUtc();
    totalMessages = messagesResponse?.total ?? 0;
    if (page == 1) {
      messages = messagesResponse?.messages ?? [];
    } else if (hasNextPage) {
      messages.addAll(messagesResponse?.messages ?? []);
    }
    hasNextPage = messagesResponse?.hasNextPage ?? false;
    page += 1;
    if (selectedMessage == null && messages.isNotEmpty) {
      await setSelectedMessage(
        currentSelectedMessageIndex: 0,
      );
    }
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMessageContent({
    required String messageId,
  }) async {
    isLoading = true;
    notifyListeners();
    messageContent = await MessagesService.getMessage(
      messageId: messageId,
    );
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  Future<void> getMessageContentBody() async {
    isLoading = true;
    notifyListeners();
    messageContentBody = await MessagesService.getMessageContentBody(
      messageId: selectedMessage?.id ?? '',
    );
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  Future<void> downloadMessageAttachment(MessageAttachment attachment) async {
    final fileContent = await MessagesService.getMessageAttachmentContentBody(
      messageAttachmentId: attachment.id,
    );
    final blob = html.Blob([fileContent]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = attachment.filename;
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }

  Future<void> deleteMessage({
    required String messageId,
  }) async {
    isLoading = true;
    notifyListeners();
    final StandardResponse? standardResponse = await MessagesService.deleteMessage(
      messageId: messageId,
    );
    if (standardResponse?.success ?? false) {
      messages.removeWhere((message) => message.id == messageId);
    }
    notifyListeners();
    isLoading = false;
    notifyListeners();
  }

  void clear({
    bool clearQuery = true,
  }) {
    isLoading = false;
    messages = [];
    totalMessages = 0;
    lastRequest = null;
    messageViewType = MessageViewType.rendered;
    if (clearQuery) {
      query = null;
    }
    selectedMessageIndex = null;
    selectedMessage = null;
    messageContent = null;
    messageContentBody = null;
    page = 1;
    hasNextPage = true;
  }
}
