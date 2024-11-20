// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => MessageAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'attachments': instance.attachments,
    };
