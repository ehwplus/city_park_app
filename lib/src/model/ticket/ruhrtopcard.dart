import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/model/ticket/ticket_model.dart';

class RuhrTopCard extends TicketModel {
  RuhrTopCard({
    required super.uuid,
    required super.firstName,
    required super.lastName,
    required super.qrCode,
    required super.expirationDate,
    required super.cardNumber,
    required super.barCode,
  }) : super(
         type: TicketType.ruhrTopCard,
         parks: const [ParkEnum.essenGrugapark, ParkEnum.dortmundWestfalenpark, ParkEnum.dortmundZoo],
       );
}
