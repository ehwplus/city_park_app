import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TicketModel {
  const TicketModel({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    this.birthday,
    required this.qrCode,
    this.cardNumber,
    required this.parks,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);

  final String uuid;

  final String? firstName;

  final String? lastName;

  final String? qrCode;

  final DateTime? birthday;

  final String? cardNumber;

  final List<ParkEnum> parks;

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
