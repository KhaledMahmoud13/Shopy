import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/default_button.dart';
import 'package:shopy/app/view/widgets/default_text_from.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/core/resources/assets_manager.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/enums.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
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
            Text(
              textAlign: TextAlign.center,
              AppStrings.forgotPassword.replaceAll('?', ''),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSize.s30),
            SvgPicture.asset(ImageAssets.forgotPassword),
            const SizedBox(height: AppSize.s30),
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
          ],
        ),
      ),
      bottomNavigationBar: DefaultButton(
        child: Consumer<AuthenticationViewModel>(
          builder: (context, value, child) => value.requestStatus ==
                  RequestStatus.loading
              ? const CircularProgressIndicator(color: ColorManager.secondary)
              : Text(
                  AppStrings.sendEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
        ),
        onPressed: () async {
          await authenticationViewModel.resetPassword(
            _emailController.text.trim(),
            () => Navigator.pop(context),
          );
        },
      ),
    );
  }
}
