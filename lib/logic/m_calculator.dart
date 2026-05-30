import 'package:re_manu_past/logic/isr_calculator.dart';
import 'package:re_manu_past/models/m_week.dart';

class MCalculator {
  MWeek w = MWeek();

  final double _salMin = 0.00;

  MCalculator (MWeek mWeek) {
    w = mWeek;
  }

  /// Calcula la manutención pastoral conforme a los datos de una semana
  MWeek calculate() {
    w.fondSegSoc = w.diezOfre * 0.035;
    w.tope = ((_salMin * 20) * 30.4);
    w.base = w.diezOfre - w.fondSegSoc;
    w.preDiez = (w.base * w.porc) + (w.diezOfre * 0.25);
    w.diezPast = w.preDiez * 0.1;
    w.manuPast = w.preDiez;

    return w;
  }

  /// Calcula el ISR a favor de la semana
  double getIsrAFavor() {
    IsrCalculator ic = IsrCalculator(w.manuPast, 0.0);

    int ise = ic.calculateAlt().round();
    int ice = ic.calculate().round();

    return (ise - ice).toDouble();
  }
}