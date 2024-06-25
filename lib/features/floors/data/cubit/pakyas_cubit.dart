import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:parking_app/core/api/end_points.dart';
import 'package:parking_app/features/floors/data/models/pakyas_model.dart';

import '../../../../../core/api/api_consumer.dart';

part 'pakyas_state.dart';

class PakyasCubit extends Cubit<PakyasState> {
  PakyasCubit(this.api) : super(PakyasInitial());
  final ApiConsumer api;
  List<Pakyas> pakyasList = [];
  int irSensor1 = 0;
  int irSensor2 = 0;
  int irSensor3 = 0;
  int irSensor4 = 0;
  int emptySensor = -1;
  getPakyasData() async {
    try {
      emit(PakyasDataLoading());
      final response = await api.get("${EndPoint.baseUrl}${EndPoint.pakyas}");
      pakyasList =
          (response as List).map((item) => Pakyas.fromJson(item)).toList();
      emit(PakyasDataLoaded(pakyasList));
    } catch (e) {
      debugPrint(e.toString());
      emit(PakyasDataFailure(errMessage: e.toString()));
    }
  }

  getSensors() async {
    try {
      emit(SensorsLoading());
      final response = await api.get(
          "https://esp32-e9004-default-rtdb.firebaseio.com/SensorData/IRdata.json?auth=N0y1Y61rFSqI5cGlfYRM1SjP0dHSohU4Ka7EL1Xc");
      final data = response as Map<String, dynamic>;
      irSensor1 = data['IRSensor1'];
      irSensor2 = data['IRSensor2'];
      irSensor3 = data['IRSensor3'];
      irSensor4 = data['IRSensor4'];
      emptySensor = data['emptySensor'];
      emit(SensorsLoaded());
    } catch (e) {
      debugPrint("The Error is in the sensors $e");
      emit(SensorsFailure(errMessage: e.toString()));
    }
  }
}
