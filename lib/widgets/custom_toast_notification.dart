import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/utils/app_colors.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum ToastType { success, error, warning }

class CustomToastNotification {
  static show(String title,
      {ToastType type = ToastType.success,
      bool isFilled = true,
      bool? bottomPosition = false,
      Duration? duration}) async {
    showToastWidget(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
        margin: const EdgeInsets.symmetric(horizontal: 36.0),
        decoration: BoxDecoration(
          color: isFilled ? getToastColor(type) : AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowGrey.withOpacity(0.08),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: getToastColor(type),
                shape: BoxShape.circle,
              ),
              // child: SvgPicture.asset(getToastIcon(type)),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isFilled ? AppColors.white : getToastColor(type),
                  fontSize: 12.5,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      position: bottomPosition == true
          ? StyledToastPosition.bottom
          : StyledToastPosition.top,
      animation: bottomPosition == true
          ? StyledToastAnimation.slideFromBottom
          : StyledToastAnimation.slideFromTop,
      duration: duration,
    );
  }

  static showBottomToast(BuildContext context, String title) async {
    showToast(
      title,
      context: context,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      backgroundColor: AppColors.transparentBlack,
      textStyle: const TextStyle(fontSize: 12.5, color: AppColors.white),
    );
  }

  static Color getToastColor(ToastType type) {
    switch (type) {
      case ToastType.success:
        return AppColors.darkGreen2;
      case ToastType.error:
        return AppColors.error;
      case ToastType.warning:
        return AppColors.warning;

      default:
        return AppColors.darkGreen2;
    }
  }

  // static String getToastIcon(ToastType type) {
  //   switch (type) {
  //     case ToastType.success:
  //       return SvgIcons.successToast;
  //     case ToastType.error:
  //       return SvgIcons.errorToast;
  //     case ToastType.warning:
  //       return SvgIcons.warningToast;

  //     default:
  //       return SvgIcons.successToast;
  //   }
  // }

  // static Color getToastColor(ToastType type) {
  //   switch (type) {
  //     case ToastType.success:
  //       return AppColors.successGreen;
  //     case ToastType.error:
  //       return AppColors.errorRed;
  //     case ToastType.warning:
  //       return AppColors.orangeWarning;

  //     default:
  //       return AppColors.successGreen;
  //   }
  // }
}
