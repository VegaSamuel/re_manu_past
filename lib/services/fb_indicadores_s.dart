import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbIndicadoresS {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  double _umaDiaria = 0.0;
  double _salarioMinimo = 0.0;

  final Completer<void> _loadingCompleter = Completer<void>();

  FbIndicadoresS() {
    _initListener();
  }

  void _initListener() {
    String anioActual = DateTime.now().year.toString();
    print('Buscando indicadores del año: $anioActual');

    _db.collection('indicadores').doc(anioActual).snapshots().listen(
          (snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data();
          _umaDiaria = (data?['uma_diaria'] ?? 0.0).toDouble();
          _salarioMinimo = (data?['salario_general'] ?? 0.0).toDouble();
        } else {
          print('ADVERTENCIA: No existe el documento $anioActual en Firestore.');
        }

        if (!_loadingCompleter.isCompleted) {
          _loadingCompleter.complete();
        }
      },
      onError: (error) {
        print('Error al escuchar Firestore: $error');
        if (!_loadingCompleter.isCompleted) {
          _loadingCompleter.complete();
        }
      },
    );
  }

  Future<void> asegurarCarga() {
    return _loadingCompleter.future;
  }

  double getUma() {
    return _umaDiaria;
  }

  double getSalario() {
    return _salarioMinimo;
  }
}
