// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMessagesResponse _$NewMessagesResponseFromJson(Map<String, dynamic> json) =>
    NewMessagesResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$NewMessagesResponseToJson(
        NewMessagesResponse instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'total': instance.total,
    };
