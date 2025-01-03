import 'package:flutter/material.dart';
import 'package:tb_clinic/ui/auth/components/build_register_body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, surfaceTintColor: Colors.transparent),
      body: buildRegisterBody(
        firstNameController,
        lastNameController,
        emailController,
        passwordController,
        confirmPasswordController,
      ),
    );
  }
}
