import 'package:flutter/material.dart';
import 'package:re_manu_past/models/m_week.dart';
import 'package:re_manu_past/persistance/p_m_week.dart';

class MonthView extends StatelessWidget {
  const MonthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: FutureBuilder<List<MWeek>>(
                  future: PMWeek().obtenerSemanas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error al cargar los datos'),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No hay semanas registradas'),
                      );
                    }

                    final list = snapshot.data!;

                    return ListView.builder(
                      itemCount: list.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == list.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          );
                        }

                        final semana = list[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildSemanaCard(
                              semana: semana.fondSegSoc.toString(),
                              diezmos: semana.diezOfre.toString(),
                              manutencion: semana.manuPast.toString(),
                              isr: semana.preDiez.toString()),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),

              _buildFilaTotal('Manutención acumulada', ''),
              _buildFilaTotal('Pago al pastor', ''),
              _buildFilaTotal('Ayuda adicional', ''),
              _buildFilaTotal('ISR a Favor', ''),

              const SizedBox(height: 30),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemanaCard({
    required String semana,
    required String diezmos,
    required String manutencion,
    required String isr,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFBBE1FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            semana,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildFilaConcepto('Diezmos y ofrendas', diezmos),
          _buildFilaConcepto('Manutención pastoral', manutencion),
          _buildFilaConcepto('ISR a favor', isr),
        ],
      ),
    );
  }

  Widget _buildFilaConcepto(String concepto, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(concepto, style: TextStyle(fontSize: 15, color: Colors.black87)),
          Text(valor, style: TextStyle(fontSize: 15, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildFilaTotal(String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Text(
            valor,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
