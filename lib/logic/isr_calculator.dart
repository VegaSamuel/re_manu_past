import 'package:re_manu_past/services/fb_indicadores_s.dart';
import 'package:re_manu_past/util/tarifas.dart';

class IsrCalculator {
  final Tarifas t = Tarifas();

  double _manuIgle = 0.0;
  double _manuDist = 0.0;

  IsrCalculator(double manuIgle, double manuDist) {
    _manuIgle = manuIgle;
    _manuDist = manuDist;
  }

  Future<int> calculate() async {
    final indicadores = FbIndicadoresS();

    await indicadores.asegurarCarga();

    final umaDiaria = indicadores.getUma();
    print('El Uma utilizado es: $umaDiaria');

    double total = _manuIgle + _manuDist;
    double esmg = (umaDiaria * 30.4) * 5;
    double bsIm = total - esmg;

    t.baseImpuesto = bsIm;

    double exc = bsIm - t.getLimInf();
    double impMar = exc * t.getExcPorc();
    double cuota = t.getImpMargi();

    return (impMar + cuota).round();
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
