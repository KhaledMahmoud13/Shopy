import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/assets_manager.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

class ImageDialog extends StatelessWidget {
  final bool authentication;

  ImageDialog({super.key, required this.authentication});

  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorManager.background,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s12)),
            ),
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              children: [
                Text(
                  AppStrings.selectImageFrom,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: AppSize.s10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectImage(ImageSource.gallery, context);
                      },
                      child: Card(
                        color: ColorManager.darkSlateGray,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          child: Column(
                            children: [
                              Image.asset(
                                ImageAssets.gallery,
                                height: AppSize.s60,
                                width: AppSize.s60,
                              ),
                              const SizedBox(height: AppSize.s10),
                              Text(
                                AppStrings.gallery,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectImage(ImageSource.camera, context);
                      },
                      child: Card(
                        color: ColorManager.darkSlateGray,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          child: Column(
                            children: [
                              Image.asset(
                                ImageAssets.camera,
                                height: AppSize.s60,
                                width: AppSize.s60,
                              ),
                              const SizedBox(height: AppSize.s10),
                              Text(
                                AppStrings.camera,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectImage(ImageSource source, BuildContext context) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);

    if (context.mounted) {
      if (authentication) {
        final AuthenticationViewModel authenticationViewModel =
            Provider.of<AuthenticationViewModel>(context, listen: false);

        authenticationViewModel.setImagePath(pickedFile!.path);
      } else {
        final UserViewModel userViewModel =
            Provider.of<UserViewModel>(context, listen: false);

        userViewModel.setImagePath(pickedFile!.path);
      }

      print(pickedFile);
      Navigator.pop(context);
    }
  }
}
