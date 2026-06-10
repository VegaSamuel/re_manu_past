import 'package:re_manu_past/logic/isr_calculator.dart';
import 'package:re_manu_past/models/m_week.dart';
import 'package:re_manu_past/services/fb_indicadores_s.dart';

class MCalculator {
  MWeek w = MWeek();

  MCalculator(MWeek mWeek) {
    w = mWeek;
  }

  /// Calcula la manutención pastoral conforme a los datos de una semana
  Future<MWeek> calculate() async {
    final indicadores = FbIndicadoresS();

    await indicadores.asegurarCarga();

    final salario = indicadores.getSalario();
    print('Salario minimo utilizado: $salario');

    w.fondSegSoc = w.diezOfre * 0.035;
    w.tope = ((salario * 20) * 30.4);
    w.base = w.diezOfre - w.fondSegSoc;
    w.preDiez = (w.base * w.porc) + (w.diezOfre * 0.25);
    w.diezPast = w.preDiez * 0.1;
    w.manuPast = w.preDiez - w.diezPast;

    return w;
  }

  /// Calcula el ISR a favor de la semana
  Future<double> getIsrAFavor() async {
    IsrCalculator ic = IsrCalculator(w.manuPast, 0.0);

    int ise = ic.calculateAlt().round();
    int ice = await ic.calculate();

    return (ise - ice).toDouble();
  }
}
