import 'package:data/exchange.dart';
 abstract class DelimitedData implements Data {
  String get separator;

  get delimiter => null;
}