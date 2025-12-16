// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
  uuid: json['uuid'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  birthday:
      json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
  qrCode: json['qrCode'] as String?,
  expirationDate:
      json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
  cardNumber: json['cardNumber'] as String?,
  parks: [], // TODO
);

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'qrCode': instance.qrCode,
      'birthday': instance.birthday?.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'cardNumber': instance.cardNumber,
    };
