// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      emailId: json['email_id'] as String,
      recipients: json['recipients'] as String,
      sender: json['sender'] as String,
      subject: json['subject'] as String,
      shortText: json['short_text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'email_id': instance.emailId,
      'recipients': instance.recipients,
      'sender': instance.sender,
      'subject': instance.subject,
      'short_text': instance.shortText,
      'created_at': instance.createdAt.toIso8601String(),
    };
