import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_manu_past/models/m_week.dart';

class PMWeek {
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    'semanas',
  );

  Future<List<MWeek>> obtenerSemanas() async {
    try {
      final querySnapshot = await _collection.get();

      return querySnapshot.docs.map((doc) {
        return MWeek.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error al obtener las semanas: $e');
      return [];
    }
  }

  Stream<List<MWeek>> escucharSemanasRealtime() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MWeek.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<String> insertarSemana(MWeek week) async {
    try {
      if (week.uuid.isNotEmpty) {
        await _collection.doc(week.uuid).set(week.toFirestore());
        return week.uuid;
      } else {
        DocumentReference doc = await _collection.add(week.toFirestore());
        week.uuid = doc.id;
        return doc.id;
      }
    } catch (e) {
      print('Error al insertar semana: $e');
      rethrow;
    }
  }

  Future<void> actualizarSemana(MWeek week) async {
    try {
      if (week.uuid.isEmpty) {
        throw Exception('No se puede actualizar una semana sin un uuid valido');
      }
      await _collection.doc(week.uuid).update(week.toFirestore());
    } catch (e) {
      print('Error al actualizar semana: $e');
      rethrow;
    }
  }

  Future<void> eliminarSemana(String uuid) async {
    try {
      await _collection.doc(uuid).delete();
    } catch(e) {
      print('Error al eliminar la semana: $e');
      rethrow;
    }
  }

  Future<void> registrarPago(String uuid) async {
    try{
      await _collection.doc(uuid).update({
        'is_pagado': true,
      });
    } catch(e) {
      print('Error al registrar el pago: $e');
      rethrow;
    }
  }
}
