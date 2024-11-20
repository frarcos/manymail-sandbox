// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesResponse _$MessagesResponseFromJson(Map<String, dynamic> json) =>
    MessagesResponse(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNextPage: json['has_next_page'] as bool,
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$MessagesResponseToJson(MessagesResponse instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'has_next_page': instance.hasNextPage,
      'total': instance.total,
    };
