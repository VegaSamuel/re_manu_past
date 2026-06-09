import 'package:intl/intl.dart';

class Formatter {
  final NumberFormat _currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$', decimalDigits: 2);
  final NumberFormat _percentFormat = NumberFormat.percentPattern('es_MX',)..maximumFractionDigits = 2;

  NumberFormat getCurrencyFormat() {
    return _currencyFormat;
  }

  NumberFormat getPercenrtFormat() {
    return _percentFormat;
  }
}