part of 'timer_cubit.dart';

@immutable
sealed class TimerState {}

final class TimerInitial extends TimerState {}
final class TimerPaused extends TimerState {}
final class TimerStarted extends TimerState {}
