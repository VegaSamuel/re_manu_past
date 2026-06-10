import 'package:flutter/material.dart';
import 'package:re_manu_past/logic/m_calculator.dart';
import 'package:re_manu_past/models/m_week.dart';
import 'package:re_manu_past/persistance/p_m_week.dart';
import 'package:re_manu_past/util/formatter.dart';

class WeekCalculator extends StatefulWidget {
  const WeekCalculator({super.key});

  @override
  State<WeekCalculator> createState() => _WeekCalculatorState();
}

class _WeekCalculatorState extends State<WeekCalculator> {
  bool _isCalculated = false;
  bool _isLoading = false;
  final MWeek _mw = MWeek();

  final TextEditingController _diezmosController = TextEditingController();
  final TextEditingController _ofrendaController = TextEditingController();
  final TextEditingController _porcentajeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _mw.anio = DateTime.now().year;
    _mw.mes = DateTime.now().month.toString();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'FEBRERO 2026\nSemana 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),

              if (!_isCalculated) _buildInputForm() else _buildCalculatedView(),

              const SizedBox(height: 40),

              if (!_isCalculated)
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                            });

                            _mw.diezOfre = double.tryParse(_diezmosController.text) ?? 0.0;
                            _mw.ofreEsc = double.tryParse(_ofrendaController.text) ?? 0.0;
                            _mw.porc = ((double.tryParse(_porcentajeController.text) ?? 50) / 100);

                            await MCalculator(_mw).calculate();

                            setState(() {
                              _isLoading = false;
                              _isCalculated = true;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Calcular',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton('Cancelar', () {
                      setState(() {
                        _isCalculated = false;
                      });
                    }),
                    _buildActionButton('Guardar', () async {
                      String id = await PMWeek().insertarSemana(_mw);
                      print('Semana registrada con el ID: $id');
                    }),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFBBE0FE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            label: 'Diezmos y Ofrendas',
            prefixText: '\$',
            controller: _diezmosController,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            label: 'Ofrenda Escuela Biblica',
            prefixText: '\$',
            controller: _ofrendaController,
          ),
          const SizedBox(height: 20),
          _buildInputField(
            label: 'Porcentaje para Manutención',
            prefixText: '%',
            controller: _porcentajeController,
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatedView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFBBE0FE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCalculated = false;
                    });
                  },
                  child: const Icon(Icons.edit, size: 20),
                ),
              ),
              Column(
                children: [
                  _buildDataRow(
                    'Diezmos y Ofrendas',
                    Formatter().getCurrencyFormat().format(_mw.diezOfre),
                  ),
                  _buildDataRow(
                    'Ofrenda Escuela Biblica',
                    Formatter().getCurrencyFormat().format(_mw.ofreEsc),
                  ),
                  _buildDataRow(
                    'Porcentaje de Manutencion',
                    Formatter().getPercenrtFormat().format(_mw.porc),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFBBE0FE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildDataRow(
                '3.5% Fondo Seguridad Social',
                Formatter().getCurrencyFormat().format(_mw.fondSegSoc),
              ),
              _buildDataRow(
                'Base para calculo',
                Formatter().getCurrencyFormat().format(_mw.base),
              ),
              _buildDataRow(
                'Manutencion antes del diezmo',
                Formatter().getCurrencyFormat().format(_mw.preDiez),
              ),
              _buildDataRow(
                'Diezmos del Pastor',
                Formatter().getCurrencyFormat().format(_mw.diezPast),
              ),
              _buildDataRow(
                'Manutencion Pastoral',
                Formatter().getCurrencyFormat().format(_mw.manuPast),
              ),
              _buildDataRow('Manutencion Pastoral Acumulada', ''),
              _buildDataRow(
                'ISR Provisional',
                Formatter().getCurrencyFormat().format(_mw.isrPro),
              ),
              _buildDataRow(
                'ISR Retenido en el mes',
                Formatter().getCurrencyFormat().format(_mw.isrRM),
              ),
              _buildDataRow(
                'ISR Retenido en la semana',
                Formatter().getCurrencyFormat().format(_mw.isrRS),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    String? prefixText,
    String? suffixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (prefixText != null) ...[
              Text(
                prefixText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
            ],

            Expanded(
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),

            if (suffixText != null) ...[
              const SizedBox(width: 8),
              Text(
                suffixText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  void dispose() {
    _diezmosController.dispose();
    _ofrendaController.dispose();
    _porcentajeController.dispose();
    super.dispose();
  }
}
