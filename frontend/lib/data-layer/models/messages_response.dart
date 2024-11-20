import 'package:json_annotation/json_annotation.dart';
import 'package:sandbox/data-layer/models/message.dart';

part 'messages_response.g.dart';

@JsonSerializable()
class MessagesResponse {
  final List<Message> messages;
  @JsonKey(name: 'has_next_page')
  final bool hasNextPage;
  final int total;

  MessagesResponse({
    required this.messages,
    required this.hasNextPage,
    required this.total,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) => _$MessagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesResponseToJson(this);
}
