import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/default_button.dart';
import 'package:shopy/app/view/widgets/default_text_from.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/enums.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              AppStrings.welcome,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSize.s4),
            Text(
              textAlign: TextAlign.center,
              AppStrings.enterData,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSize.s200),
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
            const SizedBox(height: AppSize.s8),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                },
                child: Text(
                  AppStrings.forgotPassword,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
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
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, Routes.registerRoute),
              child: Text(
                AppStrings.registerQuestion,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: AppSize.s12),
            DefaultButton(
              child: Consumer<AuthenticationViewModel>(
                builder: (context, value, child) => value.requestStatus ==
                        RequestStatus.loading
                    ? CircularProgressIndicator(color: ColorManager.secondary)
                    : Text(
                        AppStrings.login,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
              ),
              onPressed: () async {
                var status = await authenticationViewModel.signIn(
                  _emailController.text,
                  _passwordController.text,
                );
                if (context.mounted &&
                    authenticationViewModel.requestStatus ==
                        RequestStatus.loaded &&
                    status == AuthenticationStatus.authenticated) {
                  Navigator.pushReplacementNamed(context, Routes.splashRoute);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
