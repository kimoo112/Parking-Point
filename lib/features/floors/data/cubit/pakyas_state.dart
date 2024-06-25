part of 'pakyas_cubit.dart';

@immutable
sealed class PakyasState {}

final class PakyasInitial extends PakyasState {}

final class PakyasDataLoading extends PakyasState {}

final class PakyasDataLoaded extends PakyasState {
  final List<Pakyas> pakyas;

  PakyasDataLoaded(this.pakyas);
}

final class PakyasDataFailure extends PakyasState {
  final String errMessage;

  PakyasDataFailure({required this.errMessage});
}

final class SensorsLoading extends PakyasState {}
final class SensorsLoaded extends PakyasState {

}
final class SensorsFailure extends PakyasState {
  final String errMessage;

  SensorsFailure({required this.errMessage});

}