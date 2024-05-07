import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:parking_app/core/api/end_points.dart';
import 'package:parking_app/features/floors/data/models/pakyas_model.dart';

import '../../../../../core/api/api_consumer.dart';

part 'pakyas_state.dart';

class PakyasCubit extends Cubit<PakyasState> {
  PakyasCubit(this.api) : super(PakyasInitial());
  final ApiConsumer api;
  List<Pakyas> pakyasList = [];
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
}
