import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_manu_past/models/indicadores_fb.dart';

class FbIndicadoresS {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<IndicadoresFb?> getIndicadoresAnio(int anio) {
    return _db.collection('indicadores').doc(anio.toString()).snapshots().map((
      doc,
    ) {
      if (doc.exists) {
        return IndicadoresFb.fromFirestone(doc.data() as Map<String, dynamic>);
      }
      return null;
    });
  }
}
