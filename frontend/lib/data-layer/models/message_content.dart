import 'package:json_annotation/json_annotation.dart';
import 'package:sandbox/data-layer/models/message_attachment.dart';

part 'message_content.g.dart';

@JsonSerializable()
class MessageContent {
  final List<MessageAttachment> attachments;

  MessageContent({
    required this.attachments,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) => _$MessageContentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}
