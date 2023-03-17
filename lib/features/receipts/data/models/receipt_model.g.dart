// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      id: json['id'] as String?,
      filePath: json['filePath'] as String?,
      currentStatus: json['current_status'] as String?,
      currentStatusComment: json['current_status_comment'] as String?,
      statusUpdatedDate: json['statusUpdatedDate'] as String?,
      dataOnExtReceipts: json['data_on_ext_receipts'] as String?,
    )..createdAt = json['createdAt'] as String?;

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'current_status': instance.currentStatus,
      'current_status_comment': instance.currentStatusComment,
      'statusUpdatedDate': instance.statusUpdatedDate,
      'data_on_ext_receipts': instance.dataOnExtReceipts,
      'createdAt': instance.createdAt,
    };
