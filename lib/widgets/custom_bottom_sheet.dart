import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/services/navigator_service.dart';
import 'package:flutter_clean_architecture/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtomSheet {
  static show({
    BuildContext? context,
    required String title,
    required Widget child,
    TextStyle? titleStyle,
  }) {
    // get context from naivgator key from navigator service
    context ??= NavigatorService().key.currentContext!;

    return showModalBottomSheet<void>(
      context: context,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          topLeft: Radius.circular(24.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
          ),
          margin: EdgeInsets.fromLTRB(16, 0, 16, Platform.isIOS ? 24 : 16),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: titleStyle ??
                        TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.lightWhiteBg,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          color: AppColors.primaryColor, size: 18.0),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              child,
            ],
          ),
        );
      },
    );
  }
}
