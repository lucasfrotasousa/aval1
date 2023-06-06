import 'package:data/exchange.dart';

 class TsvData extends DelimitedData {
  List<String> fieldsTSV = [];
  dynamic listofvalues = [];
   @override
  String get separator => '"\t"';
   @override
  void load(tsvfile) {
    try {
      if (!tsvfile.contains('.tsv')) {
        throw FormatException('Invalid Format');
      }
      tsvfile = File(tsvfile).readAsStringSync();
      data = tsvfile;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  set data(String data) {
    try {
      final values = data.split('\n');
      for (var value in values) {
        listofvalues.add(value.split('\t'));
      }
      fieldsTSV = listofvalues[0];
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  String get data {
    if (!hasData) return '';
    String strValues = '';
    try {
      for (int i = 0; i < listofvalues.length; i++) {
        strValues += (listofvalues[i]
            .toString()
            .replaceAll(' ', '\t')
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(',', ''));
         strValues += '\n';
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    return strValues;
  }
   @override
  List<String> get fields {
    return fieldsTSV;
  }
   @override
  void save(String fileName) {
    try {
      String strValues = '';
      for (int i = 0; i < listofvalues.length; i++) {
        strValues += (listofvalues[i]
            .toString()
            .replaceAll(' ', '\t')
            .replaceAll('[', '')
            .replaceAll(']', '')
            .replaceAll(',', ''));
        strValues += '\n';
      }
       final outFile = File(fileName);
      outFile.createSync(recursive: true);
      outFile.writeAsStringSync(strValues);
      print('Status: Saved successfully');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  void clear() {
    listofvalues = '';
  }
   @override
  bool get hasData => listofvalues.isNotEmpty;
}