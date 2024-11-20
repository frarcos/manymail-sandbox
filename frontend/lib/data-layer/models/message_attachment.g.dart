// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageAttachment _$MessageAttachmentFromJson(Map<String, dynamic> json) =>
    MessageAttachment(
      id: json['id'] as String,
      messageId: json['message_id'] as String,
      filename: json['filename'] as String,
      contentType: json['content_type'] as String,
    );

Map<String, dynamic> _$MessageAttachmentToJson(MessageAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message_id': instance.messageId,
      'filename': instance.filename,
      'content_type': instance.contentType,
    };
