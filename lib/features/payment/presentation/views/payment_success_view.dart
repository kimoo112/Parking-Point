import 'package:flutter/material.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';

class PaymentSuccessView extends StatelessWidget {
  const PaymentSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            customNavigate(context, homeNavbar);
          },
          icon: const Icon(Icons.home_filled),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 200,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            Text(
              'Payment Successful !'.toUpperCase(),
              style: CustomTextStyles.openSansBoldStyle40,
            ),
            const SizedBox(height: 10),
            Text(
              'Thank you for your purchase',
              style: CustomTextStyles.openSans400style24Blue,
            ),
          ],
        ),
      ),
    );
  }
}
