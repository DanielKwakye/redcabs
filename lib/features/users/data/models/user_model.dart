import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@CopyWith()
@JsonSerializable()
class UserModel extends Equatable {
  final String? id;
  final String? userId;
  final String? name;

  @JsonKey(name: 'other_names')
  final String? otherNames;

  final String? dossier;
  final String? phone;
  final String? password;
  final String? email;
  final String? registeredForPush;
  @JsonKey(name: 'driver_info')
  final Map<String,dynamic>? driverInfo;

  final String? unlockDashboard;
  final String? userType; //prospective_driver, regular_driver, prospective_student, regular_student,
  final String? accountType; // driver / student
  final String? prospectiveDriverStatus;// in-progress, service-selected
  final String? selectedServiceType;
  final String? timeRemainingForDashboardAccess;
  final bool? agreedToHouseRules;
  final int? rentalsInProgress;

  @JsonKey(name: 'start_week')
  final String? startWeek;

  @JsonKey(name: 'end_week')
  final String? endWeek;

  final String? address;
  final bool? isValidEmail;
  final bool? enrolmentCompleted;


  const UserModel({
    this.id,
    this.userId,
    this.name,
    this.otherNames,
    this.dossier,
    this.phone,
    this.password,
    this.email,
    this.registeredForPush,
    this.driverInfo,
    this.unlockDashboard,
    this.userType,
    this.accountType,
    this.prospectiveDriverStatus,
    this.selectedServiceType,
    this.timeRemainingForDashboardAccess,
    this.agreedToHouseRules,
    this.rentalsInProgress,
    this.startWeek,
    this.endWeek,
    this.address,
    this.isValidEmail,
    this.enrolmentCompleted
  });

  @override
  List<Object?> get props => [ id ];

  /// Connect the generated [_$UserModelFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
