part of 'garages_cubit.dart';

@immutable
sealed class GaragesState {}

final class GaragesInitial extends GaragesState {}

final class GaragesDataLoading extends GaragesState {}

final class GaragesDataLoaded extends GaragesState {
  final List<Garage> garages;

  GaragesDataLoaded(this.garages);
}

final class GaragesDataFailure extends GaragesState {
  final String errMessage;

  GaragesDataFailure({required this.errMessage});
}
