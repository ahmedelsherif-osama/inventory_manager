class SNModel {
  final String stockItemSerialNumber;
  final String accountCountry;
  final String stage;
  String? GRID;
  String? vendorName;

  SNModel({
    required this.stockItemSerialNumber,
    required this.accountCountry,
    required this.stage,
    required String? GRID,
    required String? vendorName,
  });
}
