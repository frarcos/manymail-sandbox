import 'package:json_annotation/json_annotation.dart';
import 'package:sandbox/data-layer/models/message.dart';

part 'new_messages_response.g.dart';

@JsonSerializable()
class NewMessagesResponse {
  final List<Message> messages;
  final int total;

  NewMessagesResponse({
    required this.messages,
    required this.total,
  });

  factory NewMessagesResponse.fromJson(Map<String, dynamic> json) => _$NewMessagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewMessagesResponseToJson(this);
}
