import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:parking_app/core/api/end_ponits.dart';

import '../../../../core/api/api_consumer.dart';
import '../model/garage_model.dart';

part 'garages_state.dart';

class GaragesCubit extends Cubit<GaragesState> {
  GaragesCubit(this.api) : super(GaragesInitial());
  final ApiConsumer api;
  List<Garage> garagesList = [];
  fetchGaragesData() async {
    try {
      emit(GaragesDataLoading());
      final response = await api.get('${EndPoint.baseUrl}${EndPoint.garages}');
      if (response is List) {
        List<Garage> garagesList =
            (response).map((json) => Garage.fromJson(json)).toList();
        debugPrint(' the garages Name :${garagesList[1].name}');
        debugPrint(' the garages length :${garagesList.length}');
        emit(GaragesDataLoaded(garagesList));
      } else {
        throw Exception('Invalid response format: $response');
      }
    } catch (e) {
      final errorMessage = 'Error fetching garages: $e';
      debugPrint(errorMessage);
      emit(GaragesDataFailure(errMessage: errorMessage));
    }
  }
 
}
