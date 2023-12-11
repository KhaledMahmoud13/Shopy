import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopy/app/view/widgets/default_button.dart';
import 'package:shopy/app/view/widgets/default_text_from.dart';
import 'package:shopy/app/view/widgets/image_dialog.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/core/resources/assets_manager.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:provider/provider.dart';
import 'package:shopy/core/util/enums.dart';
import 'package:shopy/core/util/utils.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p8),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: AppSize.s60),
            Text(
              textAlign: TextAlign.center,
              AppStrings.signUp,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSize.s50),
            Consumer<AuthenticationViewModel>(
              builder: (context, value, child) => GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ImageDialog(authentication: true),
                  );
                },
                child: Container(
                  width: AppSize.s100,
                  height: AppSize.s100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.transparent,
                    image: value.imagePath == ''
                        ? const DecorationImage(
                            image: AssetImage(
                              ImageAssets.placeholder,
                            ),
                            fit: BoxFit.contain,
                          )
                        : DecorationImage(
                            image: FileImage(File(value.imagePath)),
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s10),
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
                keyboardType: TextInputType.emailAddress,
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
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        authenticationViewModel.changeGender(AppStrings.male),
                    child: Consumer<AuthenticationViewModel>(
                      builder: (context, value, child) => Container(
                        margin: const EdgeInsets.all(AppMargin.m8),
                        height: AppSize.s60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          color: value.gender == AppStrings.male
                              ? ColorManager.primary
                              : ColorManager.darkSlateGray,
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.men.toUpperCase(),
                            style: value.gender == AppStrings.male
                                ? Theme.of(context).textTheme.headlineMedium
                                : Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        authenticationViewModel.changeGender(AppStrings.female),
                    child: Consumer<AuthenticationViewModel>(
                      builder: (context, value, child) => Container(
                        margin: const EdgeInsets.all(AppMargin.m8),
                        height: AppSize.s60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          color: value.gender == AppStrings.male
                              ? ColorManager.darkSlateGray
                              : ColorManager.primary,
                        ),
                        child: Center(
                          child: Text(
                            AppStrings.women.toUpperCase(),
                            style: value.gender == AppStrings.male
                                ? Theme.of(context).textTheme.titleMedium
                                : Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
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
            const SizedBox(height: AppSize.s10),
            Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              child: DefaultTextForm(
                hint: AppStrings.password,
                controller: _passwordController,
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                validate: (value) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: AppSize.s135,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
                authenticationViewModel.setImagePath('');
              },
              child: Text(
                AppStrings.haveAccountQuestion,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: AppSize.s12),
            DefaultButton(
              child: Consumer<AuthenticationViewModel>(
                builder: (context, value, child) => value.requestStatus ==
                        RequestStatus.loading
                    ? const CircularProgressIndicator(color: ColorManager.secondary)
                    : Text(
                        AppStrings.signUp,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
              ),
              onPressed: () async {
                await authenticationViewModel.signUp(
                  fullName: _fullNameController.text.trim(),
                  email: _emailController.text.trim(),
                  birthDate: _birthDateController.text.trim(),
                  weight: double.parse(_weightController.text.trim()),
                  height: double.parse(_heightController.text.trim()),
                  password: _passwordController.text.trim(),
                );
                if (context.mounted &&
                    authenticationViewModel.requestStatus ==
                        RequestStatus.loaded) {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  authenticationViewModel.setImagePath('');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
