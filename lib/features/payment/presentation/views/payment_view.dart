import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/api_keys.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

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
            const SizedBox(height: 66),
            Image.asset(Assets.imagesPaypalLogo),
            const SizedBox(height: 20),
            Text(
                "Currently, Parking Point exclusively supports PayPal payments. However, we are actively exploring additional payment integrations for future expansion.",
                textAlign: TextAlign.center,
                style: CustomTextStyles.openSans400style16Blue),
            const Spacer(),
            CustomBtn(
                text: 'Pay',
                onPressed: () {
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
                          "description": "The payment transaction description.",
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
                }),
          ],
        ),
      ),
    );
  }
}
