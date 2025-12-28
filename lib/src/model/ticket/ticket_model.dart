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
    this.barCode,
    this.cardNumber,
    required this.parks,
    this.expirationDate,
    this.type = TicketType.seasonPass,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);

  final String uuid;

  final String? firstName;

  final String? lastName;

  final String? qrCode;

  final String? barCode;

  final DateTime? birthday;

  final DateTime? expirationDate;

  final String? cardNumber;

  final List<ParkEnum> parks;

  final TicketType type;

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}

enum TicketType { seasonPass, single, ruhrTopCard }
