import 'package:challenge_response/src/components/app_button.dart';
import 'package:challenge_response/src/components/app_textfield.dart';
import 'package:challenge_response/src/pages/home_page.dart';
import 'package:challenge_response/src/sample_feature/network.dart';
import 'package:challenge_response/src/sample_feature/validate_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  late ValidateResponse? validateResponse;

  Future<void> _validate() async {
    final prefs = await SharedPreferences.getInstance();
    String message = '';
    List<dynamic> errors = [''];

    validateResponse = await validate(passwordController.text);

    if (validateResponse != null) {
      message = validateResponse!.message;
      errors = validateResponse!.errors ?? [''];
    }

    await prefs.setString('message', message);
    await prefs.setStringList('erros', errors as List<String>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(183, 177, 226, 1),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Login',
                    style: GoogleFonts.dmSerifText(fontSize: 30),
                  ),
                ),
                const Divider(),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 6),
                        child: AppTextfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Digite uma senha.';
                              }
                              return null;
                            },
                            controller: passwordController,
                            hintText: 'Senha',
                          obscureText: false,
                        ),
                      ),
                      AppButton(
                        text: 'Entrar',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _validate();
                            });
                            Navigator.of(context).pushNamed(HomePage.routeName);
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
