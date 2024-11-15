import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool?> _showBackDialog() => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            content: const Text('Tem certeza que deseja sair?'),
            contentPadding: const EdgeInsets.only(top: 25.0, left: 25),
            actionsPadding: const EdgeInsets.only(bottom: 12),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: const Text('Sair'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              )
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(183, 177, 226, 1),
      body: PopScope<Object?>(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await _showBackDialog() ?? false;
          if (context.mounted && shouldPop) {
            Navigator.pop(context);
          }
        },
        child: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                child: Text(
                  'Home',
                  style: GoogleFonts.dmSerifText(fontSize: 30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
