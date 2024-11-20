import 'package:json_annotation/json_annotation.dart';

part 'message_attachment.g.dart';

@JsonSerializable()
class MessageAttachment {
  final String id;
  @JsonKey(name: 'message_id')
  final String messageId;
  final String filename;
  @JsonKey(name: 'content_type')
  final String contentType;

  MessageAttachment({
    required this.id,
    required this.messageId,
    required this.filename,
    required this.contentType,
  });

  factory MessageAttachment.fromJson(Map<String, dynamic> json) => _$MessageAttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageAttachmentToJson(this);
}
