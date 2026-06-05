import 'package:re_manu_past/models/m_week.dart';

class PMWeek {

  Future<List<MWeek>> obtenerSemanas() async {
    await Future.delayed(const Duration(seconds: 2));

    return List<MWeek>.empty();
  }
}