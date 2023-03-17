import 'package:json_annotation/json_annotation.dart';

part 'receipt_model.g.dart';

@JsonSerializable()
class ReceiptModel {

  ReceiptModel({
    this.id,
    this.filePath,
    this.currentStatus,
    this.currentStatusComment,
    this.statusUpdatedDate,
    this.dataOnExtReceipts,
  });

  String? id;
  String? filePath;
  @JsonKey(name: 'current_status')
  String? currentStatus;
  @JsonKey(name: 'current_status_comment')
  String? currentStatusComment;
  String? statusUpdatedDate;
  @JsonKey(name: 'data_on_ext_receipts')
  String? dataOnExtReceipts;
  String? createdAt;

  /// Connect the generated [_$ReceiptModelFromJson] function to the `fromJson`
  /// factory.
  factory ReceiptModel.fromJson(Map<String, dynamic> json) => _$ReceiptModelFromJson(json);

  /// Connect the generated [_$CarModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ReceiptModelToJson(this);

}