import 'package:json_annotation/json_annotation.dart';

part 'message_content_body.g.dart';

@JsonSerializable()
class MessageContentBody {
  @JsonKey(name: 'text_body')
  final String textBody;
  @JsonKey(name: 'text_html')
  final String textHtml;

  MessageContentBody({
    required this.textBody,
    required this.textHtml,
  });

  factory MessageContentBody.fromJson(Map<String, dynamic> json) => _$MessageContentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentBodyToJson(this);
}
