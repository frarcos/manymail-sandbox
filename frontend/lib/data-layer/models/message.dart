import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String id;
  @JsonKey(name: 'email_id')
  final String emailId;
  final String recipients;
  final String sender; // Original sender field
  final String subject;
  @JsonKey(name: 'short_text')
  final String shortText;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Message({
    required this.id,
    required this.emailId,
    required this.recipients,
    required this.sender,
    required this.subject,
    required this.shortText,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  String get senderName {
    final nameMatch = RegExp(r'^"([^"]+)"').firstMatch(sender);
    return nameMatch != null ? nameMatch.group(1)! : '';
  }

  String get senderEmail {
    final emailMatch = RegExp(r'<([^>]+)>').firstMatch(sender);
    return emailMatch != null ? emailMatch.group(1)! : '';
  }
}
