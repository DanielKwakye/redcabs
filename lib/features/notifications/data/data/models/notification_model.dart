import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {

  @JsonKey(name: 'message_type')
  String? messageType;

  String? message;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  NotificationModel({this.messageType, this.message, this.createdAt});

  /// Connect the generated [_$NotificationModelFromJson] function to the `fromJson`
  /// factory.
  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  /// Connect the generated [_$CarModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

}