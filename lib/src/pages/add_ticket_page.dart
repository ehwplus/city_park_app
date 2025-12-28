import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/model/ticket/ruhrtopcard.dart';
import 'package:city_park_app/src/model/ticket/ticket_model.dart';
import 'package:city_park_app/src/model/ticket/ticket_store_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart' as qr_scanner;
import 'package:uuid/uuid.dart';

class AddTicketPage extends ConsumerStatefulWidget {
  const AddTicketPage({super.key, this.existing, this.preselectedTicketType, this.preselectedPark});

  static const routeName = '/settings/tickets/add';

  static const routeNameRuhrTopCard = '/settings/tickets/add-ruhr-top-card';

  final TicketModel? existing;

  final TicketType? preselectedTicketType;

  final ParkEnum? preselectedPark;

  @override
  ConsumerState<AddTicketPage> createState() => _AddTicketPageState();
}

class _AddTicketPageState extends ConsumerState<AddTicketPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _qrCodeController = TextEditingController();
  final _barCodeController = TextEditingController();
  final _uuid = const Uuid();

  String? _existingUuid;

  final bool allowToSelectPark = false;

  final Map<ParkEnum, bool> _selectedParks = {for (final park in ParkEnum.values) park: false};

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    if (existing != null) {
      _existingUuid = existing.uuid;
      _firstNameController.text = existing.firstName ?? '';
      _lastNameController.text = existing.lastName ?? '';
      _cardNumberController.text = existing.cardNumber ?? '';
      _qrCodeController.text = existing.qrCode ?? '';
      _barCodeController.text = existing.barCode ?? '';
      if (existing.birthday != null) {
        _birthdayController.text = existing.birthday!.toIso8601String().split('T').first;
      }
      if (existing.expirationDate != null) {
        _expirationDateController.text = existing.expirationDate!.toIso8601String().split('T').first;
      }
      for (final park in existing.parks) {
        _selectedParks[park] = true;
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _cardNumberController.dispose();
    _qrCodeController.dispose();
    _barCodeController.dispose();
    super.dispose();
  }

  Future<void> _scanQr() async {
    String? result;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => _QrScannerPage(
              scanQr: true,
              onScanned: (value) {
                result = value;
                Navigator.of(ctx).pop();
              },
            ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _qrCodeController.text = result!;
      });
    }
  }

  Future<void> _scanBarCode() async {
    String? result;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => _QrScannerPage(
              scanQr: false,
              onScanned: (value) {
                result = value;
                Navigator.of(ctx).pop();
              },
            ),
      ),
    );
    if (result != null && mounted) {
      setState(() {
        _barCodeController.text = result!;
      });
    }
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    DateTime? expirationDate;
    if (_expirationDateController.text.isNotEmpty) {
      try {
        expirationDate = DateTime.parse(_expirationDateController.text);
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.ticketsFormInvalidDate)));
        return;
      }
    }

    if (widget.preselectedTicketType == TicketType.ruhrTopCard) {
      final ticket = RuhrTopCard(
        uuid: _existingUuid ?? _uuid.v4(),
        firstName: _firstNameController.text.isEmpty ? null : _firstNameController.text,
        lastName: _lastNameController.text.isEmpty ? null : _lastNameController.text,
        qrCode: _qrCodeController.text.isEmpty ? null : _qrCodeController.text,
        barCode: _barCodeController.text.isEmpty ? null : _barCodeController.text,
        expirationDate: expirationDate,
        cardNumber: _cardNumberController.text.isEmpty ? null : _cardNumberController.text,
      );
      await ref.read(ticketStoreProvider.notifier).add(ticket);
      if (mounted) Navigator.of(context).pop();
      return;
    }

    DateTime? birthday;
    if (_birthdayController.text.isNotEmpty) {
      try {
        birthday = DateTime.parse(_birthdayController.text);
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.ticketsFormInvalidDate)));
        return;
      }
    }

    final parks = _selectedParks.entries.where((e) => e.value).map((e) => e.key).toList();
    final ticket = TicketModel(
      uuid: _existingUuid ?? _uuid.v4(),
      firstName: _firstNameController.text.isEmpty ? null : _firstNameController.text,
      lastName: _lastNameController.text.isEmpty ? null : _lastNameController.text,
      birthday: birthday,
      qrCode: _qrCodeController.text.isEmpty ? null : _qrCodeController.text,
      barCode: _barCodeController.text.isEmpty ? null : _barCodeController.text,
      expirationDate: expirationDate,
      cardNumber: _cardNumberController.text.isEmpty ? null : _cardNumberController.text,
      parks: allowToSelectPark ? parks : [ParkEnum.essenGrugapark],
      type: widget.preselectedTicketType ?? TicketType.seasonPass,
    );

    await ref.read(ticketStoreProvider.notifier).add(ticket);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.preselectedTicketType == TicketType.ruhrTopCard
              ? 'Ruhr.Topcard'
              : widget.existing == null
              ? l10n.ticketsAddTitle
              : l10n.ticketsManagementTitle,
        ),
        actions: [IconButton(icon: const Icon(Icons.check), onPressed: _save)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: l10n.ticketsFormFirstName),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: l10n.ticketsFormLastName),
              ),
              TextFormField(
                controller: _birthdayController,
                decoration: InputDecoration(labelText: l10n.ticketsFormBirthday),
              ),
              TextFormField(
                controller: _expirationDateController,
                decoration: InputDecoration(labelText: l10n.ticketsFormExpirationDate),
              ),
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(labelText: l10n.ticketsFormCardNumber),
              ),
              TextFormField(
                controller: _qrCodeController,
                decoration: InputDecoration(labelText: l10n.ticketsFormQrCode),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _scanQr,
                icon: const Icon(Icons.qr_code_scanner),
                label: Text(l10n.ticketsFormScanQRCodeButton),
              ),
              TextFormField(
                controller: _barCodeController,
                decoration: InputDecoration(labelText: l10n.ticketsFormBarCode),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _scanBarCode,
                icon: const Icon(Icons.code),
                label: Text(l10n.ticketsFormScanBarCodeButton),
              ),
              if (allowToSelectPark) ...[
                const SizedBox(height: 16),
                Text(l10n.ticketsFormParksLabel),
                ...ParkEnum.values.map(
                  (park) => CheckboxListTile(
                    title: Text(park.name),
                    value: _selectedParks[park],
                    onChanged: (value) {
                      setState(() {
                        _selectedParks[park] = value ?? false;
                      });
                    },
                  ),
                ),
              ],
              if (kDebugMode) Text(widget.existing?.type.name ?? widget.preselectedTicketType?.name ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}

class _QrScannerPage extends StatefulWidget {
  const _QrScannerPage({required this.onScanned, required this.scanQr});

  final void Function(String) onScanned;

  final bool scanQr;

  @override
  State<_QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<_QrScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  qr_scanner.QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.scanQr ? l10n.ticketsFormScanQRCodeButton : l10n.ticketsFormScanBarCodeButton)),
      body: qr_scanner.QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: qr_scanner.QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.primary,
          borderRadius: 8,
          borderLength: 24,
          borderWidth: 8,
          cutOutSize: 260,
        ),
      ),
    );
  }

  void _onQRViewCreated(qr_scanner.QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final code = scanData.code;
      if (code != null && mounted) {
        widget.onScanned(code);
        controller.pauseCamera();
      }
    });
  }
}
