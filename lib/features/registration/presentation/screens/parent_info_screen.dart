// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:treemov/app/di/di.config.dart';
// import 'package:treemov/app/routes/app_routes.dart';
// import 'package:treemov/core/widgets/auth/auth_header.dart';
// import 'package:treemov/features/registration/domain/repositories/register_repository.dart';
// import 'package:treemov/features/registration/presentation/bloc/register_bloc.dart';

// import '../../../../../core/themes/app_colors.dart';

// class ParentInfoScreen extends StatelessWidget {
//   final Map<String, String>? registrationData;

//   const ParentInfoScreen({super.key, this.registrationData});

//   @override
//   Widget build(BuildContext context) {
//     final parentNameController = TextEditingController();
//     final parentPhoneController = TextEditingController();

//     return BlocProvider(
//       create: (context) => RegisterBloc(getIt<RegisterRepository>()),
//       child: Scaffold(
//         backgroundColor: AppColors.kidPrimary,
//         body: Stack(
//           children: [
//             const AuthHeader(),
//             Center(
//               child: SingleChildScrollView(
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 60),
//                       const Text(
//                         'Регистрация',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w900,
//                           color: AppColors.white,
//                           fontFamily: 'TT Norms',
//                         ),
//                       ),
//                       const SizedBox(height: 40),

//                       _buildTextField(
//                         'ФИО одного из родителей',
//                         controller: parentNameController,
//                       ),
//                       const SizedBox(height: 20),

//                       _buildTextField(
//                         'Номер телефона родителя',
//                         controller: parentPhoneController,
//                       ),
//                       const SizedBox(height: 20),

//                       BlocConsumer<RegisterBloc, RegisterState>(
//                         listener: (context, state) {
//                           if (state is RegisterSuccess) {
//                             _navigateToMain(context);
//                           }
//                         },
//                         builder: (context, state) {
//                           return SizedBox(
//                             width: 316,
//                             height: 44,
//                             child: ElevatedButton(
//                               onPressed: state is RegisterLoading
//                                   ? null
//                                   : () {
//                                       if (registrationData != null) {
//                                         // Используем RegisterKid событие
//                                         context.read<RegisterBloc>().add(
//                                           RegisterKid(
//                                             username:
//                                                 registrationData!['username']!,
//                                             email: registrationData!['email']!,
//                                             password:
//                                                 registrationData!['password']!,
//                                             parentName: parentNameController
//                                                 .text
//                                                 .trim(),
//                                             parentPhone: parentPhoneController
//                                                 .text
//                                                 .trim(),
//                                           ),
//                                         );
//                                       } else {
//                                         ScaffoldMessenger.of(
//                                           context,
//                                         ).showSnackBar(
//                                           const SnackBar(
//                                             content: Text(
//                                               'Ошибка: данные регистрации не найдены',
//                                             ),
//                                             backgroundColor: Colors.red,
//                                           ),
//                                         );
//                                       }
//                                     },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.kidButton,
//                                 foregroundColor: AppColors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 elevation: 0,
//                                 shadowColor: Colors.transparent,
//                               ),
//                               child: state is RegisterLoading
//                                   ? const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         color: AppColors.white,
//                                         strokeWidth: 2,
//                                       ),
//                                     )
//                                   : const Text(
//                                       'Зарегистрироваться',
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w700,
//                                         fontFamily: 'TT Norms',
//                                       ),
//                                     ),
//                             ),
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String hintText, {
//     required TextEditingController controller,
//   }) {
//     return Container(
//       width: 316,
//       height: 44,
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 15,
//             vertical: 12,
//           ),
//           hintText: hintText,
//           hintStyle: const TextStyle(
//             color: AppColors.grey,
//             fontSize: 16,
//             fontFamily: 'TT Norms',
//           ),
//         ),
//         style: const TextStyle(fontSize: 16, fontFamily: 'TT Norms'),
//       ),
//     );
//   }

//   void _navigateToMain(BuildContext context) {
//     Navigator.pushNamedAndRemoveUntil(
//       context,
//       AppRoutes.entrance,
//       (route) => false,
//     );
//   }
// }
