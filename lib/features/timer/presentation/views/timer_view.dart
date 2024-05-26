import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/timer/presentation/cubit/timer_cubit.dart';

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late CountDownController controller;
  late int duration;
  @override
  void initState() {
    super.initState();
    controller = context.read<TimerCubit>().controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerCubit, TimerState>(
      listener: (context, state) {
        controller = context.read<TimerCubit>().controller;
        duration = context.read<TimerCubit>().duration;
      },
      builder: (context, state) {
        return Scaffold(
            body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (controller.isPaused) {
                    controller.resume();
                  } else if (context.read<TimerCubit>().controller.isStarted) {
                    controller.pause();
                  } else {
                    if (context.read<TimerCubit>().duration == 0) {
                    } else {
                      controller.start();
                    }
                  }
                },
                child: CircularCountDownTimer(
                  duration: context.read<TimerCubit>().duration,
                  initialDuration: 0,
                  controller: controller,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  ringColor: Colors.grey[300]!,
                  fillColor: AppColors.primaryColor,
                  backgroundColor: AppColors.offWhite,
                  strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,
                  textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textFormat: CountdownTextFormat.HH_MM_SS,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {},
                  onComplete: () {
                    debugPrint('Countdown Ended');
                  },
                  onChange: (String timeStamp) {
                    debugPrint('Countdown Changed $timeStamp');
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      return "Book First";
                    } else {
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    }
                  },
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomBtn(
                  text: 'Restart',
                  onPressed: () => controller.reset(),
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}
