import 'package:flutter/material.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_colors.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({
    super.key,
    this.parkingName,
    this.hourPrice,
  });
  final String? parkingName;
  final double? hourPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Underground parking',
                    style: CustomTextStyles.openSansBoldStyle12Blue),
                Text('$hourPrice \$/h',
                    style: CustomTextStyles.openSansBoldStyle16Blue)
              ],
            ),
            Text(parkingName ?? 'Indigo Parking',
                style: CustomTextStyles.openSansBoldStyle16),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.directions_car,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(width: 10),
                Text('50 places disponibles',
                    style: CustomTextStyles.openSansBoldStyle12Grey),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.phone,
                  color: AppColors.darkGrey,
                ),
                Text('Call', style: CustomTextStyles.openSansBoldStyle12Grey),
                Icon(Icons.calendar_today, color: AppColors.darkGrey),
                Text('Itinerary',
                    style: CustomTextStyles.openSansBoldStyle12Grey),
                Icon(Icons.share, color: AppColors.darkGrey),
                Text('Share', style: CustomTextStyles.openSansBoldStyle12Grey),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            Text('INFO', style: CustomTextStyles.openSans400style16Blue),
            const SizedBox(height: 5),
            Text(
                '705 rue Sainte-Catherine O, Montréal, QC, H3B 4G5Stationnement intérieur souterrain dans l’édifice du Centre Eaton',
                style: CustomTextStyles.openSansBoldStyle12Grey),
            const SizedBox(height: 10),
            Text(
                'For payment, pay in the app below and scan the barcode that will appear after the payment',
                style: CustomTextStyles.openSansBoldStyle12Blue),
            const SizedBox(height: 22),
            Text('Price - week', style: CustomTextStyles.openSansBoldStyle16),
            const SizedBox(height: 10),
            _priceWeakWidget(),
            const SizedBox(height: 10),
            const SizedBox(height: 22),
            CustomBtn(
              text: 'Pay Now'.toUpperCase(),
              onPressed: () {
                customNavigate(context, floorsView);
              },
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _priceWeakWidget() {
    return SingleChildScrollView(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Adjust border radius as needed
              border: Border.all(
                color: AppColors.black,
                width: 1,
              ),
            ),
            child: Text('1h \$15/h',
                style: CustomTextStyles.openSansBoldStyle12Grey),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Adjust border radius as needed
              border: Border.all(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            child: Text('4h \$50',
                style: CustomTextStyles.openSansBoldStyle12Blue),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.black,
                width: 1,
              ),
            ),
            child: Text('Journée entière \$75/jou',
                style: CustomTextStyles.openSansBoldStyle12Grey),
          )
        ],
      ),
    );
  }
}
