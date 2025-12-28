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
  barCode: json['barCode'] as String?,
  cardNumber: json['cardNumber'] as String?,
  parks:
      (json['parks'] as List<dynamic>)
          .map((e) => $enumDecode(_$ParkEnumEnumMap, e))
          .toList(),
  expirationDate:
      json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
  type:
      $enumDecodeNullable(_$TicketTypeEnumMap, json['type']) ??
      TicketType.seasonPass,
);

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'qrCode': instance.qrCode,
      'barCode': instance.barCode,
      'birthday': instance.birthday?.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'cardNumber': instance.cardNumber,
      'parks': instance.parks.map((e) => _$ParkEnumEnumMap[e]!).toList(),
      'type': _$TicketTypeEnumMap[instance.type]!,
    };

const _$ParkEnumEnumMap = {
  ParkEnum.essenGrugapark: 'essenGrugapark',
  ParkEnum.dortmundWestfalenpark: 'dortmundWestfalenpark',
  ParkEnum.dortmundZoo: 'dortmundZoo',
  ParkEnum.mannheimLuisenpark: 'mannheimLuisenpark',
  ParkEnum.mannheimHerzogenriedpark: 'mannheimHerzogenriedpark',
};

const _$TicketTypeEnumMap = {
  TicketType.seasonPass: 'seasonPass',
  TicketType.single: 'single',
  TicketType.ruhrTopCard: 'ruhrTopCard',
};
