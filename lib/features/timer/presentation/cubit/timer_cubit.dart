import 'package:bloc/bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:meta/meta.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(TimerInitial());

  final CountDownController controller = CountDownController();
  int duration = 0;
  addTimeAfterPayment() {
    duration = 60*60;
    print(duration);
    emit(TimerStarted());
  }

}
