/*
 * File name: category_grid_item_widget.dart
 * Last modified: 2023.01.26 at 18:26:27
 * Author: SmarterVision - https://codecanyon.net/user/smartervision
 * Copyright (c) 2023
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../routes/app_routes.dart';

class CategoryGridItemWidget extends StatelessWidget {
  final Category category;
  final String heroTag;

  CategoryGridItemWidget({Key? key, required this.category, required this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Get.theme.colorScheme.secondary.withOpacity(0.08),
      onTap: () {
        Get.toNamed(Routes.CATEGORY, arguments: category);
      },
      child: Container(
        decoration: Ui.getBoxDecoration(),
        child: Wrap(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: new BoxDecoration(
                color: category.color!.withOpacity(0.15),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              child: (category.image!.url.toLowerCase().endsWith('.svg')
                  ? SvgPicture.network(
                      category.image!.url,
                      color: category.color,
                      height: 53,
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: category.image!.url,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    category.name ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: false,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  if ((category.subCategories?.length ?? 0) > 0) Divider(height: 25, thickness: 0.5),
                  Wrap(
                    spacing: 5,
                    children: List.generate(category.subCategories?.length ?? 0, (index) {
                      var _category = category.subCategories!.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.CATEGORY, arguments: _category);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          child: Text(_category.name!, style: Get.textTheme.bodySmall?.merge(TextStyle(fontSize: 10))),
                          decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                      );
                    }),
                    runSpacing: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
