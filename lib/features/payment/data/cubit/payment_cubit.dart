import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:parking_app/core/api/api_consumer.dart';

import '../../../../core/api/end_points.dart';

part 'payment_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this.api) : super(BookingInitial());
final   ApiConsumer api;
   postPakyasToBasket({required int id ,required String name ,required String pictureUrl ,}) async {
    emit(BookingLoading());

    try {
      final response =
          await api.post('${EndPoint.baseUrl}${EndPoint.bookings}', data:{
  "basketId": "1",
  "customerAddress": {
    "firstName": "Eman",
    "lastName": "Ibrahim",
    "city": "Alex",
    "street": "BorgElArab",
    "numCar": "SIA9922",
    "phone": "01159494123"
  }
});
        emit(BookingSuccess());
      
    } catch (e) {
      debugPrint(e.toString());
      emit(BookingFailure(e.toString()));
    }
  }
}

