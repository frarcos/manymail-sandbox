import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:sandbox/constants/sandbox_network.dart';
import 'package:sandbox/data-layer/models/message_content.dart';
import 'package:sandbox/data-layer/models/message_content_body.dart';
import 'package:sandbox/data-layer/models/messages_response.dart';
import 'package:sandbox/data-layer/models/new_messages_response.dart';
import 'package:sandbox/data-layer/models/standard_response.dart';
import 'package:sandbox/data-layer/services/_network_service.dart';

class MessagesService {
  static Future<NewMessagesResponse?> getNewMessages({
    String query = '',
    DateTime? from,
  }) async {
    try {
      http.Response response = await NetworkService.get(
        '${SandboxNetwork.baseUrl}/messages/new?query=$query${from != null ? '&from=${from.toIso8601String()}' : ''}',
      );
      return NewMessagesResponse.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  static Future<MessagesResponse?> getMessages({
    required int page,
    String query = '',
    DateTime? from,
  }) async {
    try {
      http.Response response = await NetworkService.get(
        '${SandboxNetwork.baseUrl}/messages?page=$page&query=$query${from != null ? '&from=${from.toIso8601String()}' : ''}',
      );
      return MessagesResponse.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  static Future<MessageContent?> getMessage({
    required String messageId,
  }) async {
    try {
      http.Response response = await NetworkService.get(
        '${SandboxNetwork.baseUrl}/messages/$messageId',
      );
      return MessageContent.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  static Future<MessageContentBody?> getMessageContentBody({
    required String messageId,
  }) async {
    try {
      http.Response response = await NetworkService.get(
        '${SandboxNetwork.baseUrl}/messages/$messageId/content',
      );
      return MessageContentBody.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  static Future<Uint8List?> getMessageAttachmentContentBody({
    required String messageAttachmentId,
  }) async {
    try {
      http.Response response = await NetworkService.get(
        '${SandboxNetwork.baseUrl}/attachments/$messageAttachmentId/content',
      );
      return response.bodyBytes;
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  static Future<StandardResponse?> deleteMessage({
    required String messageId,
  }) async {
    try {
      http.Response response = await NetworkService.delete(
        '${SandboxNetwork.baseUrl}/messages/$messageId',
      );
      return StandardResponse.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }
}
