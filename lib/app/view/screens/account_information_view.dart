import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/default_button.dart';
import 'package:shopy/app/view/widgets/default_text_from.dart';
import 'package:shopy/app/view/widgets/image_dialog.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/assets_manager.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/enums.dart';
import 'package:shopy/core/util/utils.dart';

class AccountInformationView extends StatelessWidget {
  AccountInformationView({super.key});

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _birthDateController;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    final UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    _fullNameController = TextEditingController(
        text: authenticationViewModel.currentUser.fullName);
    _emailController =
        TextEditingController(text: authenticationViewModel.currentUser.email);
    _weightController = TextEditingController(
        text: authenticationViewModel.currentUser.weight.toString());
    _heightController = TextEditingController(
        text: authenticationViewModel.currentUser.height.toString());
    _birthDateController = TextEditingController(
        text: authenticationViewModel.currentUser.birthDate);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p8),
          physics: const ClampingScrollPhysics(),
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: RoundedIcon(
                margin: const EdgeInsets.all(AppMargin.m8),
                onPressed: () => Navigator.pop(context),
                icon: Icons.keyboard_backspace,
              ),
            ),
            const SizedBox(height: AppSize.s40),
            Consumer<UserViewModel>(
              builder: (context, value, child) => GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ImageDialog(authentication: false),
                  );
                },
                child: Container(
                  width: AppSize.s100,
                  height: AppSize.s100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.transparent,
                    image: userViewModel.imagePath != ''
                        ? DecorationImage(
                            image: FileImage(File(userViewModel.imagePath)),
                            fit: BoxFit.contain,
                          )
                        : authenticationViewModel.currentUser.profilePicture !=
                                null
                            ? DecorationImage(
                                image: NetworkImage(
                                  authenticationViewModel
                                      .currentUser.profilePicture!,
                                ),
                                fit: BoxFit.contain,
                              )
                            : const DecorationImage(
                                image: AssetImage(ImageAssets.placeholder),
                                fit: BoxFit.contain,
                              ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s40),
            Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              child: DefaultTextForm(
                hint: AppStrings.fullName,
                controller: _fullNameController,
                keyboardType: TextInputType.name,
                validate: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(height: AppSize.s10),
            Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              child: DefaultTextForm(
                hint: AppStrings.email,
                controller: _emailController,
                keyboardType: TextInputType.none,
                readOnly: true,
                validate: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(height: AppSize.s10),
            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(AppMargin.m8),
                    child: DefaultTextForm(
                      hint: AppStrings.weight,
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      validate: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.all(AppMargin.m8),
                    child: DefaultTextForm(
                      hint: AppStrings.height,
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      validate: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s10),
            Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              child: DefaultTextForm(
                hint: AppStrings.birthDate,
                controller: _birthDateController,
                readOnly: true,
                onTap: () => selectBirthDate(
                    context, selectedDate, _birthDateController),
                keyboardType: TextInputType.none,
                validate: (value) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DefaultButton(
        child: Consumer<UserViewModel>(
          builder: (context, value, child) =>
              value.requestStatus == RequestStatus.loading
                  ? CircularProgressIndicator(color: ColorManager.secondary)
                  : Text(
                      AppStrings.updateInformation,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
        ),
        onPressed: () async {
          await userViewModel.updateUser(
            userId: authenticationViewModel.getCurrentFirebaseUser()!.uid,
            fullName: _fullNameController.text.trim(),
            birthDate: _birthDateController.text.trim(),
            weight: double.parse(_weightController.text.trim()),
            height: double.parse(_heightController.text.trim()),
          );
        },
      ),
    );
  }
}
