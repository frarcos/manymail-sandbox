// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_content_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageContentBody _$MessageContentBodyFromJson(Map<String, dynamic> json) =>
    MessageContentBody(
      textBody: json['text_body'] as String,
      textHtml: json['text_html'] as String,
    );

Map<String, dynamic> _$MessageContentBodyToJson(MessageContentBody instance) =>
    <String, dynamic>{
      'text_body': instance.textBody,
      'text_html': instance.textHtml,
    };
