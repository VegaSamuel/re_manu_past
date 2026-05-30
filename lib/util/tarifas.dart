class Tarifas {
  // Rangos de limites de tarifa
  final List<double> _limitesTarifa = [
    0.01, 746.05, 6332.06, 11128.02, 12935.83, 15487.72, 31236.50, 49233.01, 93993.91, 125325.21, 375975.62
  ];
  // Rangos de cuotas fijas
  final List<double> _cuotasFijas = [
    0.00, 14.32,371.83, 893.63, 1182.88, 1640.18, 5004.12, 9236.89, 22665.17, 32691.18, 117912.32
  ];
  // Rangos de porcentaje de excedente
  final List<double> _tasaExcedente = [
    0.0192, 0.064, 0.1088, 0.16, 0.1792, 0.2136, 0.2352, 0.30, 0.32, 0.34, 0.35
  ];

  double _baseImpuesto = 0.0;

  double get baseImpuesto => _baseImpuesto;

  /// Define la base de impuesto
  /// Tiene que ser un número positivo
  set baseImpuesto(double base) {
    if (base >= 0) { _baseImpuesto = base; } else { throw ArgumentError("La base no puede ser negativa"); }
  }

  /// Obtiene la tarifa correspondiente a la [baseImpuesto] definida
  double getLimInf() {
    if (_baseImpuesto < 0.0) { return 0.0; } else {
      for(int i = 0; i <= _limitesTarifa.length; i++) {
        if (_limitesTarifa[i] >= _baseImpuesto) { return _limitesTarifa[i-1]; }
      }
    }
    return 0.0;
  }

  /// Obtiene el porcentaje de excedente correspondiente a la [baseImpuesto] definida
  double getExcPorc() {
    if (_baseImpuesto < 0.0) { return 0.0; } else {
      for(int i = 0; i <= _limitesTarifa.length; i++) {
        if (_limitesTarifa[i] >= _baseImpuesto) { return _tasaExcedente[i-1]; }
      }
    }
    return 0.0;
  }

  /// Obtiene la cuota de impuesto marginal correspondiente a la [baseImpuesto] definida
  double getImpMargi() {
    if (_baseImpuesto < 0.0) { return 0.0; } else {
      for(int i = 0; i <= _limitesTarifa.length; i++) {
        if (_limitesTarifa[i] >= _baseImpuesto) { return _cuotasFijas[i-1]; }
      }
    }
    return 0.0;
  }
}