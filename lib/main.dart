import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/api/dio_consumer.dart';
import 'package:parking_app/core/cache/cache_helper.dart';
import 'package:parking_app/features/auth/cubit/auth_cubit.dart';
import 'package:parking_app/features/home/data/cubit/garages_cubit.dart';
import 'package:parking_app/features/timer/presentation/cubit/timer_cubit.dart';

import 'core/routes/app_router.dart';
import 'core/utils/bloc_observer.dart';
import 'features/floors/data/cubit/pakyas_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  Bloc.observer = MyBlocObserver();
  runApp(const ParkingApp());
}

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => GaragesCubit(DioConsumer(dio: Dio())),
        ),
          BlocProvider(
                create: (context) => TimerCubit(),),
        BlocProvider(
          create: (context) => PakyasCubit(DioConsumer(dio: Dio())),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Parking APP',
        theme: ThemeData(
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
