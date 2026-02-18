import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/presentation/widgets/app_primary_button.dart';
import '../../../../shared/presentation/widgets/app_text_field.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Подтверждение"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Почта подтверждена! Теперь войдите в аккаунт."),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.entrance,
              (route) => false,
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Мы отправили код на вашу почту.\nВведите его ниже.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _codeController,
                  hintText: "Код подтверждения",
                  fillColor: AppColors.white,
                ),
                const SizedBox(height: 24),
                if (state is RegisterLoading)
                  const CircularProgressIndicator()
                else
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: AppPrimaryButton(
                          text: "Подтвердить",
                          onPressed: () {
                            context.read<RegisterBloc>().add(
                              SubmitVerificationCodeEvent(_codeController.text),
                            );
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<RegisterBloc>().add(ResendCodeEvent());
                        },
                        child: const Text("Отправить код повторно"),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
