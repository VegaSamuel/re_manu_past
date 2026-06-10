class IndicadoresFb {
  final int anio;
  final double umaDiaria;
  final double salarioGeneral;

  IndicadoresFb({
    required this.anio,
    required this.umaDiaria,
    required this.salarioGeneral,
  });

  factory IndicadoresFb.fromFirestone(Map<String, dynamic> data) {
    return IndicadoresFb(
      anio: data['anio'] ?? 0,
      umaDiaria: (data['uma_diara'] as num).toDouble(),
      salarioGeneral: (data['salario_general'] as num).toDouble(),
    );
  }
}
