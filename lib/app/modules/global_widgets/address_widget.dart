/*
 * File name: address_widget.dart
 * Last modified: 2023.01.26 at 18:24:51
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/settings_service.dart';

class AddressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Row(
        children: [
          Icon(Icons.place_outlined),
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SETTINGS_ADDRESSES);
              },
              child: Obx(() {
                if (Get.find<SettingsService>().address.value.isUnknown()) {
                  return Text("Please choose your address".tr, style: Get.textTheme.bodyLarge);
                }
                return Text(Get.find<SettingsService>().address.value.address ?? '', style: Get.textTheme.bodyLarge);
              }),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.gps_fixed),
            onPressed: () async {
              Get.toNamed(Routes.SETTINGS_ADDRESS_PICKER);
            },
          )
        ],
      ),
    );
  }
}
