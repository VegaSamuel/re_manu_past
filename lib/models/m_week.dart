class MWeek {
  String uuid = '';
  int nWeek = 0;
  int anio = 0;
  String mes = '';
  double diezOfre = 0.0;
  double ofreEsc = 0.0;
  double fondSegSoc = 0.0;
  double tope = 0.0;
  double base = 0.0;
  double porc = 0.0;
  double preDiez = 0.0;
  double diezPast = 0.0;
  double manuPast = 0.0;
  double isrPro = 0.0;
  double isrRM = 0.0;
  double isrRS = 0.0;
  double pago = 0.0;
  bool isPagado = false;

  MWeek();

  void pagar() { isPagado = true; }

  factory MWeek.fromFirestore(String id, Map<String, dynamic> json) {
    final week = MWeek();
    week.uuid = id;
    week.nWeek = (json['n_week'] as num?)?.toInt() ?? 0;
    week.anio = (json['anio'] as num?)?.toInt() ?? 0;
    week.mes = json['mes'] ?? '';

    week.diezOfre = (json['diez_ofre'] as num?)?.toDouble() ?? 0.0;
    week.ofreEsc = (json['ofre_esc'] as num?)?.toDouble() ?? 0.0;
    week.fondSegSoc = (json['fond_seg_soc'] as num?)?.toDouble() ?? 0.0;
    week.tope = (json['tope'] as num?)?.toDouble() ?? 0.0;
    week.base = (json['base'] as num?)?.toDouble() ?? 0.0;
    week.porc = (json['porc'] as num?)?.toDouble() ?? 0.0;
    week.preDiez = (json['pre_diez'] as num?)?.toDouble() ?? 0.0;
    week.diezPast = (json['diez_past'] as num?)?.toDouble() ?? 0.0;
    week.manuPast = (json['manu_past'] as num?)?.toDouble() ?? 0.0;
    week.isrPro = (json['isr_pro'] as num?)?.toDouble() ?? 0.0;
    week.isrRM = (json['isr_rm'] as num?)?.toDouble() ?? 0.0;
    week.isrRS = (json['isr_rs'] as num?)?.toDouble() ?? 0.0;
    week.pago = (json['pago'] as num?)?.toDouble() ?? 0.0;
    week.isPagado = json['is_pagado'] ?? false;

    return week;
  }

  Map<String, dynamic> toFirestore() {
    return {
      'n_week': nWeek,
      'anio': anio,
      'mes': mes,

      'diez_ofre': diezOfre,
      'ofre_esc': ofreEsc,
      'fond_seg_soc': fondSegSoc,
      'tope': tope,
      'base': base,
      'porc': porc,
      'pre_diez': preDiez,
      'diez_past': diezPast,
      'manu_past': manuPast,
      'isr_pro': isrPro,
      'isr_rm': isrRM,
      'isr_rs': isrRS,
      "is_pagado": isPagado,
    };
  }
}