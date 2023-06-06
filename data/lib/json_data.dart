import 'package:data/exchange.dart';

 class JsonData implements Data {
  late List<Map<String, dynamic>> jsondata;
  late String contentJson;
  late String contentToSave;
   @override
  void load(String jsonFile) {
    try {
      if (!jsonFile.endsWith('.json')) {
        throw FormatException('Invalid format');
      }
       final file = File(jsonFile);
      if (!file.existsSync()) {
        throw FileSystemException('File not found');
      }
       final jsonString = file.readAsStringSync();
      contentToSave = jsonString;
      data = jsonString;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  List<String> get fields => jsondata.first.keys.toList();
   @override
  set data(String data) {
    try {
      jsondata = List<Map<String, dynamic>>.from(jsonDecode(data));
      contentJson = jsonEncode(jsondata);
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
      for (final row in jsondata) {
        strValues.write(row.toString());
        strValues.write('\n');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    return strValues.toString();
  }
   @override
  bool get hasData => jsondata.isNotEmpty;
   @override
  void save(String fileName) {
    try {
      final outFile = File(fileName);
      outFile.createSync(recursive: true);
      outFile.writeAsStringSync(contentToSave);
      print('Status: Saved successfully');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  void clear() {
    jsondata = [];
  }
}