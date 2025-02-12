/*
 * File name: payment_details_widget.dart
 * Last modified: 2023.01.26 at 18:29:48
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/booking_model.dart';
import '../../bookings/widgets/booking_row_widget.dart';

class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({
    Key? key,
    required Booking booking,
  })  : _booking = booking,
        super(key: key);

  final Booking _booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  imageUrl: _booking.salon!.firstImageUrl ,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 80,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error_outline),
                ),
              ),
            ],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Wrap(
              runSpacing: 10,
              alignment: WrapAlignment.start,
              children: <Widget>[
                Text(
                  _booking.salon?.name ?? '',
                  style: Get.textTheme.bodyMedium,
                  maxLines: 3,
                  // textAlign: TextAlign.end,
                ),
                Divider(height: 8, thickness: 1),
                BookingRowWidget(
                  description: "Tax Amount".tr,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Ui.getPrice(_booking.getTaxesValue(), style: Get.textTheme.titleSmall),
                  ),
                ),
                BookingRowWidget(
                  description: "Subtotal".tr,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Ui.getPrice(_booking.getSubtotal(), style: Get.textTheme.titleSmall),
                  ),
                ),
                if ((_booking.coupon?.discount ?? 0) > 0)
                  BookingRowWidget(
                    description: "Coupon".tr,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        children: [
                          Text(' - ', style: Get.textTheme.bodyLarge),
                          Ui.getPrice(_booking.getCouponValue(), style: Get.textTheme.bodyLarge),
                        ],
                      ),
                    ),
                    hasDivider: false,
                  ),
                BookingRowWidget(
                  description: "Total Amount".tr,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Ui.getPrice(_booking.getTotal(), style: Get.textTheme.titleLarge),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
