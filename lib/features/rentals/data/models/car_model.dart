import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel {
  CarModel({
    this.id,
    this.name,
    this.specifications,
    this.status,
    this.visibility,
    this.notes,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.pricePerDay,
    this.carStateImages,
    this.kmPerDay,
    this.kmPerDayPrice,
    this.unitOfFuel,
    this.pricePerUnitOfFuel,
    this.currentRentalId,
    this.currentAssignedTo,
    this.mainImage,
    this.supportingImages,
    this.firstPendingRental,
    this.stateOfCarImages,
    this.pendingRentals,
    this.currentRental,
  });

  String? id;
  String? name;
  String? mainImage;
  List<dynamic>? supportingImages;
  String? specifications;
  String? status;
  String? visibility;
  String? notes;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic pricePerDay;
  dynamic carStateImages;
  String? kmPerDay;
  String? kmPerDayPrice;
  String? unitOfFuel;
  String? pricePerUnitOfFuel;
  dynamic currentRentalId;
  dynamic currentAssignedTo;

  dynamic firstPendingRental;
  List<dynamic>? stateOfCarImages;
  List<dynamic>? pendingRentals;
  dynamic currentRental;

  /// Connect the generated [_$CarModelFromJson] function to the `fromJson`
  /// factory.
  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);

  /// Connect the generated [_$CarModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CarModelToJson(this);


}