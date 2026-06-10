import 'dart:async';
import 'package:re_manu_past/models/indicadores_fb.dart';
import 'package:re_manu_past/services/fb_indicadores_s.dart';

class IndicadoresListener {
  static final IndicadoresListener _instance = IndicadoresListener._internal();

  factory IndicadoresListener() => _instance;

  IndicadoresListener._internal() {
    int anioActual = DateTime.now().year;
    _listenIndicadores(anioActual);
  }

  final FbIndicadoresS _fbService = FbIndicadoresS();

  IndicadoresFb? _indicadoresAnioActual;
  StreamSubscription<IndicadoresFb?>? _subscription;

  void _listenIndicadores(int anio) {
    _subscription = _fbService.getIndicadoresAnio(anio).listen((data) {
      _indicadoresAnioActual = data;
      print('Indicadores listos en memoria para el año: $anio');
    });
  }

  double getUmaDiaria() {
    final indicadores = _indicadoresAnioActual;
    if (indicadores != null) {
      return indicadores.umaDiaria;
    }

    return 0.0;
  }

  double getSalarioMinimo() {
    final indicadores = _indicadoresAnioActual;
    if (indicadores != null) {
      return indicadores.salarioGeneral;
    }

    return 0.0;
  }

  void dispose() {
    _subscription?.cancel();
  }
}
