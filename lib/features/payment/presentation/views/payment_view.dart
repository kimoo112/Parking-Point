import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/api_keys.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/timer/presentation/cubit/timer_cubit.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/utils/app_colors.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  int _selectedCardIndex = -1;

  void _handleCardTap(int index) {
    setState(() {
      _selectedCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _paymentCard(
              paymentTitle: 'Google Pay',
              paymentImage: Assets.imagesGoogleLogo,
              isSelected: _selectedCardIndex == 0,
              onTap: () => _handleCardTap(0),
            ),
            _paymentCard(
              paymentTitle: 'PayPal',
              paymentImage: Assets.imagesPaypalLogo,
              isSelected: _selectedCardIndex == 1,
              onTap: () => _handleCardTap(1),
            ),
            _paymentCard(
              paymentTitle:
                  CacheHelper().getData(key: 'number') ?? 'MasterCard',
              paymentImage: Assets.imagesMasterCardLogo,
              isSelected: _selectedCardIndex == 2,
              onTap: () => _handleCardTap(2),
            ),
            const SizedBox(height: 66),
            const Spacer(),
            BlocConsumer<TimerCubit, TimerState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return CustomBtn(
                    text: 'Pay',
                    onPressed: () {
                      context.read<TimerCubit>().addTimeAfterPayment();
                      print(context.read<TimerCubit>().duration);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => PaypalCheckoutView(
                          sandboxMode: true,
                          clientId: APiKeys.paypalClientId,
                          secretKey: APiKeys.paypalSecretKey,
                          transactions: const [
                            {
                              "amount": {
                                "total": '100',
                                "currency": "USD",
                                "details": {
                                  "subtotal": '100',
                                  "shipping": '0',
                                  "shipping_discount": 0
                                }
                              },
                              "description":
                                  "The payment transaction description.",
                              "item_list": {
                                "items": [
                                  {
                                    "name": "Apple",
                                    "quantity": 4,
                                    "price": '10',
                                    "currency": "USD"
                                  },
                                  {
                                    "name": "Pineapple",
                                    "quantity": 5,
                                    "price": '12',
                                    "currency": "USD"
                                  }
                                ],
                              }
                            }
                          ],
                          note: "Contact us for any questions on your order.",
                          onSuccess: (Map params) async {
                            log("onSuccess: $params");
                            customNavigate(context, paymentSuccessView);
                            context.read<TimerCubit>().addTimeAfterPayment();
                          },
                          onError: (error) {
                            log("onError: $error");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              error,
                              style: CustomTextStyles.openSans400style16Blue,
                            )));
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              'Canceled',
                              style: CustomTextStyles.openSans400style16Blue,
                            )));
                            Navigator.pop(context);
                          },
                        ),
                      ));
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentCard({
    required paymentTitle,
    required paymentImage,
    required bool isSelected,
    Function()? onTap,
  }) {
    return Container(
      height: 95,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            color: AppColors.grey.withOpacity(0.8),
          ),
        ],
        border: isSelected
            ? Border.all(color: AppColors.primaryColor, width: 2)
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(paymentImage),
            Text(
              paymentTitle,
              textAlign: TextAlign.center,
              style: CustomTextStyles.openSans400style16Black,
            ),
            Radio(
              activeColor: AppColors.primaryColor,
              value: true,
              groupValue: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
