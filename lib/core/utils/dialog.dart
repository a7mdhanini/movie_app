import 'package:flutter_movie_app/core/themes/app_colors.dart';
import 'package:flutter_movie_app/core/utils/images/app_icons.dart';
import 'package:flutter_movie_app/core/widgets/buttons/my_button.dart';
import 'package:flutter_movie_app/core/widgets/my_icon.dart';
import 'package:flutter/material.dart';

enum DialogType { none, success, error, warning }

class MyDialog extends StatelessWidget {
  final DialogType dialogType;
  final VoidCallback? onTapConfirm;
  final VoidCallback? onTapCancel;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Widget? child;
  final String? onConfirmText;
  final String? onCancelText;

  const MyDialog({
    this.dialogType = DialogType.none,
    this.onTapConfirm,
    this.onTapCancel,
    this.paddingHorizontal,
    this.paddingVertical,
    this.onConfirmText,
    this.onCancelText,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///-------------------///
          ///----Header Icon----///
          ///-------------------///
          Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: paddingHorizontal ?? 20,
                  right: paddingHorizontal ?? 20,
                  top: paddingVertical ?? 20,
                  bottom: paddingVertical ?? 20,
                ),
                child: child ?? const SizedBox(),
              ),
              const SizedBox(height: 24),
              dialogType == DialogType.none
                  ? const SizedBox()
                  : Positioned(
                      top: -30,
                      right: 0,
                      left: 0,
                      child: MyIcon(
                        icon: dialogType == DialogType.success
                            ? AppIcons.success
                            : dialogType == DialogType.warning
                                ? AppIcons.warning
                                : AppIcons.warning,
                        size: 50,
                      ),
                    ),
            ],
          ),

          ///---------------///
          ///----Buttons----///
          ///---------------///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                ///----Confirm Button----///
                Visibility(
                  visible: onConfirmText != null,
                  child: Expanded(
                    child: MyButton(
                      onPressed: onTapConfirm,
                      title: onConfirmText,
                      color: AppColors.blue3,
                      titleColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                ///----Cancel Button----///
                Visibility(
                  visible: onCancelText != null,
                  child: Expanded(
                    child: MyButton(
                      onPressed: onTapCancel ?? () => Navigator.pop(context),
                      title: onCancelText,
                      borderColor: AppColors.blue3.withOpacity(0.2),
                    ),
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
