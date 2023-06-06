import 'package:data/exchange.dart';

 class XmlData implements Data {
  Map<String, dynamic> mapContentTag = {};
  @override
  List<String> fields = [];
  List<String> content = [];
  String contentXml = '=';
   @override
  void load(String xmlFile) {
    try {
      if (!xmlFile.endsWith('.xml')) {
        throw FormatException('Invalid format');
      }
      final document = File(xmlFile).readAsStringSync();
      contentXml = document;
      data = document;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  set data(String data) {
    try {
      final xmlData = XmlDocument.parse(data);
      final xmlFile = xmlData.rootElement.childElements;
      for (final tagContent in xmlFile) {
        final elementValues = <String>[];
        for (final element in tagContent.childElements) {
          mapContentTag[element.name.toString()] = element.innerText;
          elementValues.add(element.innerText);
        }
        content.add(elementValues.join(','));
        fields = mapContentTag.keys.toList();
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   @override
  String get data {
    if (!hasData) {
      return '';
    }
    return content.join('\n');
  }
   List<String> getFields() {
    return fields;
  }
   @override
  bool get hasData => content.isNotEmpty;
   @override
  void clear() {
    content = [];
  }
   @override
  void save(String fileName) {
    try {
      final outFile = File(fileName);
      outFile.createSync(recursive: true);
      outFile.writeAsStringSync(contentXml);
      print('Status: Saved successfully');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
   
}