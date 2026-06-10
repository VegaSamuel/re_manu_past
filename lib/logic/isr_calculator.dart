import 'package:re_manu_past/listeners/indicadores_listener.dart';
import 'package:re_manu_past/util/tarifas.dart';

class IsrCalculator {
  final Tarifas t = Tarifas();

  double _manuIgle = 0.0;
  double _manuDist = 0.0;

  IsrCalculator(double manuIgle, double manuDist) {
    _manuIgle = manuIgle;
    _manuDist = manuDist;
  }

  double calculate() {
    final indicadores = IndicadoresListener();

    double total = _manuIgle + _manuDist;
    double esmg = (indicadores.getUmaDiaria() * 30.4) * 5;
    double bsIm = total - esmg;

    t.baseImpuesto = bsIm;

    double exc = bsIm - t.getLimInf();
    double impMar = exc * t.getExcPorc();
    double cuota = t.getImpMargi();

    return impMar + cuota;
  }

  double calculateAlt() {
    double total = _manuIgle + _manuDist;
    double esmg = (0.0 * 30.4) * 5;
    double bsIm = total - esmg;

    t.baseImpuesto = bsIm;

    double exc = bsIm - t.getLimInf();
    double impMar = exc * t.getExcPorc();
    double cuota = t.getImpMargi();

    return impMar + cuota;
  }
}
