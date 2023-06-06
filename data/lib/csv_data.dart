import 'package:data/exchange.dart';

 class CsvData extends DelimitedData {
  late List<List<dynamic>> csvContent;
   @override
  late List<String> fields;
   @override
  String get separator => ",";
   List<String> get getFields => fields;
   @override
  void load(String csvFile) {
    try {
      if (!csvFile.endsWith('.csv')) {
        throw FormatException('Invalid format');
      }
      final file = File(csvFile);
      if (!file.existsSync()) {
        throw FileSystemException('File not found');
      }
      final csvString = file.readAsStringSync();
      data = csvString;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  String get data {
    if (!hasData) {
      return '';
    }
    final strValues = StringBuffer();
    try {
      for (final row in csvContent) {
        strValues.write(row.join(separator).replaceAll('[', '').replaceAll(']', ''));
        strValues.write('\n');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    return strValues.toString();
  }
   @override
  set data(String data) {
    try {
      csvContent = const CsvToListConverter().convert(data, eol: '\n');
      fields = csvContent.first.map((e) => e.toString()).toList();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  void save(String fileName) {
    try {
      final csv = const ListToCsvConverter().convert(csvContent, textDelimiter: '', eol: '\n');
      final outFile = File(fileName);
      outFile.createSync(recursive: true);
      outFile.writeAsStringSync(csv);
      print('Status: Saved successfully');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  void clear() {
    try {
      csvContent = [];
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  bool get hasData => csvContent.isNotEmpty;
}