import 'package:json_annotation/json_annotation.dart';

part 'standard_response.g.dart';

@JsonSerializable()
class StandardResponse {
  bool success;

  StandardResponse({
    required this.success,
  });

  factory StandardResponse.fromJson(Map<String, dynamic> json) => _$StandardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StandardResponseToJson(this);
}
