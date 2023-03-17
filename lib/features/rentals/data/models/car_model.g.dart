// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarModel _$CarModelFromJson(Map<String, dynamic> json) => CarModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      specifications: json['specifications'] as String?,
      status: json['status'] as String?,
      visibility: json['visibility'] as String?,
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      pricePerDay: json['pricePerDay'],
      carStateImages: json['carStateImages'],
      kmPerDay: json['kmPerDay'] as String?,
      kmPerDayPrice: json['kmPerDayPrice'] as String?,
      unitOfFuel: json['unitOfFuel'] as String?,
      pricePerUnitOfFuel: json['pricePerUnitOfFuel'] as String?,
      currentRentalId: json['currentRentalId'],
      currentAssignedTo: json['currentAssignedTo'],
      mainImage: json['mainImage'] as String?,
      supportingImages: json['supportingImages'] as List<dynamic>?,
      firstPendingRental: json['firstPendingRental'],
      stateOfCarImages: json['stateOfCarImages'] as List<dynamic>?,
      pendingRentals: json['pendingRentals'] as List<dynamic>?,
      currentRental: json['currentRental'],
    );

Map<String, dynamic> _$CarModelToJson(CarModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mainImage': instance.mainImage,
      'supportingImages': instance.supportingImages,
      'specifications': instance.specifications,
      'status': instance.status,
      'visibility': instance.visibility,
      'notes': instance.notes,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'pricePerDay': instance.pricePerDay,
      'carStateImages': instance.carStateImages,
      'kmPerDay': instance.kmPerDay,
      'kmPerDayPrice': instance.kmPerDayPrice,
      'unitOfFuel': instance.unitOfFuel,
      'pricePerUnitOfFuel': instance.pricePerUnitOfFuel,
      'currentRentalId': instance.currentRentalId,
      'currentAssignedTo': instance.currentAssignedTo,
      'firstPendingRental': instance.firstPendingRental,
      'stateOfCarImages': instance.stateOfCarImages,
      'pendingRentals': instance.pendingRentals,
      'currentRental': instance.currentRental,
    };
