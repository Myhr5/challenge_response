import 'package:challenge_response/src/components/app_button.dart';
import 'package:challenge_response/src/components/app_textfield.dart';
import 'package:challenge_response/src/pages/home_page.dart';
import 'package:challenge_response/src/data/datasource/validate_impl_api.dart';
import 'package:challenge_response/src/model/validate_response_model.dart';
import 'package:flutter/material.dart';
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
  bool isCircularProgress = false;


  Future<void> _validate() async {
    final prefs = await SharedPreferences.getInstance();
    String message = '';
    List<String> errors = [''];

    validateResponse = await validate(passwordController.text);

    if (validateResponse != null) {
      message = validateResponse!.message;
      errors = validateResponse!.errors ?? [''];
    }

    await prefs.setString('message', message);
    await prefs.setStringList('errors', errors);
  }

  Widget changeButtonChild(bool value) {
    if (value) {
      return const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      );
    }

    return const Text(
      'Validar',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(183, 177, 226, 1),
      body: Center(
        child: SizedBox(
          width: 320,
          height: 300,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Validador de Senhas',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Verifique se você tem uma senha forte!',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
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
                        widget: changeButtonChild(isCircularProgress),
                        onTap: () async {
                          setState(() {
                            isCircularProgress = true;
                          });

                          if (_formKey.currentState!.validate()) {
                            await _validate();
                            Navigator.pushNamed(context, HomePage.routeName);

                            setState(() {
                              isCircularProgress = false;
                            });
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
