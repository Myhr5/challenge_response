import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = '';
  List<String> errors = [''];

  Future<void> _getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      message = prefs.getString('message') ?? '';
      errors = prefs.getStringList('errors') ?? [''];
    });
  }

  Future<void> _removePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('message');
    await prefs.remove('errors');
  }

  @override
  void initState() {
    super.initState();

    _getSharedPreferences();
  }
  
  Future<bool?> _showBackDialog() => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            content: Text(AppLocalizations.of(context)!.alertDialogContent),
            contentPadding: const EdgeInsets.only(top: 25.0, left: 25),
            actionsPadding: const EdgeInsets.only(bottom: 12),
            actions: [
              TextButton(
                child:
                    Text(AppLocalizations.of(context)!.alertDialogCancelButton),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child:
                    Text(AppLocalizations.of(context)!.alertDialogGoOutButton),
                onPressed: () {
                  _removePreferences();
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
            height: 220,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                child: Column(
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 26),
                      child: Text(message,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    if (errors.isNotEmpty)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: errors
                              .map((e) => Text(
                                    e.isNotEmpty && e != ''
                                        ? '• ${AppLocalizations.of(context)!.error(e)}.'
                                        : AppLocalizations.of(context)!.goodJob,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ))
                              .toList(),
                        ),
                      )
                    else
                      Container()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
