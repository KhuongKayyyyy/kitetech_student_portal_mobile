import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:kitetech_student_portal/core/constant/app_color.dart';
import 'package:kitetech_student_portal/core/constant/app_image.dart';
import 'package:kitetech_student_portal/core/router/app_router.dart';
import 'package:kitetech_student_portal/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:kitetech_student_portal/presentation/widget/app/login_with_google_button.dart';
import 'package:kitetech_student_portal/presentation/widget/app/main_button.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = '52100973';
    _passwordController.text = '52100973';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      listener: (context, authenState) {
        if (authenState is AuthenticationStateLoggedIn) {
          context.go(AppRouter.home);
          EasyLoading.showSuccess("Đăng nhập thành công");
        }
        if (authenState is AuthenticationStateError) {
          EasyLoading.showError(authenState.message);
        }
        if (authenState is AuthenticationStateLoading) {
          EasyLoading.showInfo("Đang đăng nhập...");
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "Cổng thông tin sinh viên",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Image.asset(AppImage.authenBackground, width: 200, height: 200),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _emailController,
                  cursorColor: AppColors.primaryColor,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: AppColors.primaryColor),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: AppColors.primaryColor),
                    labelText: 'Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MainButton(
                text: "Đăng nhập",
                onPressed: () => context.read<AuthenticationBloc>().add(
                      AuthenticationEventLogin(
                        name: _emailController.text,
                        password: _passwordController.text,
                      ),
                    ),
              ),
              const SizedBox(height: 16),
              const Text(
                "hoặc",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              const LoginWithGoogleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
