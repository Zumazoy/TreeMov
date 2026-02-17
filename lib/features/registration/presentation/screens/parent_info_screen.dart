import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treemov/app/di/di.config.dart';
import 'package:treemov/app/routes/app_routes.dart';
import 'package:treemov/core/widgets/auth/auth_header.dart';
import 'package:treemov/features/registration/domain/repositories/register_repository.dart';
import 'package:treemov/features/registration/presentation/bloc/register_bloc.dart';

import '../../../../../core/themes/app_colors.dart';

class ParentInfoScreen extends StatefulWidget {
  const ParentInfoScreen({super.key});

  @override
  State<ParentInfoScreen> createState() => _ParentInfoScreenState();
}

class _ParentInfoScreenState extends State<ParentInfoScreen> {
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();

  String? _nameError;
  String? _phoneError;
  Map<String, String>? _registrationData;

  @override
  void initState() {
    super.initState();
    _parentNameController.addListener(_validateName);
    _parentPhoneController.addListener(_validatePhone);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_registrationData == null) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String, String>) {
        _registrationData = args;
      }
    }
  }

  void _validateName() {
    setState(() {
      final name = _parentNameController.text.trim();
      if (name.isEmpty) {
        _nameError = 'Введите ФИО родителя';
      } else if (name.split(' ').length < 2) {
        _nameError = 'Введите полное ФИО (Имя Фамилия)';
      } else if (name.length < 5) {
        _nameError = 'Слишком короткое ФИО';
      } else {
        _nameError = null;
      }
    });
  }

  void _validatePhone() {
    setState(() {
      final phone = _parentPhoneController.text.trim();
      if (phone.isEmpty) {
        _phoneError = 'Введите номер телефона';
      } else if (!RegExp(
        r'^\+?[0-9]{10,15}$',
      ).hasMatch(phone.replaceAll(' ', '').replaceAll('-', ''))) {
        _phoneError = 'Введите корректный номер телефона';
      } else {
        _phoneError = null;
      }
    });
  }

  bool get _isFormValid {
    return _nameError == null &&
        _phoneError == null &&
        _parentNameController.text.isNotEmpty &&
        _parentPhoneController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _parentNameController.dispose();
    _parentPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_registrationData == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ошибка: данные регистрации не найдены'),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      });
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (context) => RegisterBloc(getIt<RegisterRepository>()),
      child: Scaffold(
        backgroundColor: AppColors.kidPrimary,
        body: Stack(
          children: [
            const AuthHeader(),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 180),
                      const Text(
                        'Регистрация',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                          fontFamily: 'TT Norms',
                        ),
                      ),
                      const SizedBox(height: 40),

                      _buildTextField(
                        'ФИО одного из родителей',
                        controller: _parentNameController,
                        errorText: _nameError,
                      ),
                      const SizedBox(height: 20),

                      _buildTextField(
                        'Номер телефона родителя',
                        controller: _parentPhoneController,
                        errorText: _phoneError,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),

                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            _navigateToMain(context);
                          } else if (state is RegisterError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: 316,
                            height: 44,
                            child: ElevatedButton(
                              onPressed:
                                  (state is RegisterLoading || !_isFormValid)
                                  ? null
                                  : () {
                                      context.read<RegisterBloc>().add(
                                        RegisterKid(
                                          username:
                                              _registrationData!['username']!,
                                          email: _registrationData!['email']!,
                                          password:
                                              _registrationData!['password']!,
                                          parentName: _parentNameController.text
                                              .trim(),
                                          parentPhone: _parentPhoneController
                                              .text
                                              .trim(),
                                        ),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isFormValid
                                    ? AppColors.kidButton
                                    : AppColors.grey,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                              child: state is RegisterLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Зарегистрироваться',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'TT Norms',
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hintText, {
    required TextEditingController controller,
    String? errorText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 316,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: errorText != null
                ? Border.all(color: Colors.red, width: 1)
                : null,
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.grey,
                fontSize: 16,
                fontFamily: 'TT Norms',
              ),
            ),
            style: const TextStyle(fontSize: 16, fontFamily: 'TT Norms'),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 15),
            child: Text(
              errorText,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontFamily: 'TT Norms',
              ),
            ),
          ),
      ],
    );
  }

  void _navigateToMain(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.entrance,
      (route) => false,
    );
  }
}
