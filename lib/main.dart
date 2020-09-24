import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'lang_view.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'generated/locale_keys.g.dart';

void main() {
  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'DZ'),
      ],
      path: 'resources/langs/langs.csv',
      assetLoader: CsvAssetLoader()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log(context.locale.toString(), name: '${this} # locale Context');
    log('title'.tr().toString(), name: '${this} # locale');
    return MaterialApp(
      title: 'title'.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Easy localization'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  bool _gender = true;

  void switchGender(bool val) {
    setState(() {
      _gender = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.title).tr(context: context),
        //Text(AppLocalizations.of(context).tr('title')),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.language),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => LanguageView(), fullscreenDialog: true),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleKeys.gender_with_arg,
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ).tr(args: ['aissat'], gender: _gender ? 'female' : 'male'),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(FontAwesome.male),
                Switch(value: _gender, onChanged: switchGender),
                Icon(FontAwesome.female),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Text(LocaleKeys.msg).tr(args: ['aissat', 'Flutter']),
            Text(LocaleKeys.msg_named)
                .tr(namedArgs: {'lang': 'Dart'}, args: ['Easy localization']),
            Text(LocaleKeys.clicked).plural(counter),
            SizedBox(
              height: 15,
            ),
            Text(
                plural(LocaleKeys.amount, counter,
                    format: NumberFormat.currency(
                        locale: Intl.defaultLocale, symbol: '€')),
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                context.deleteSaveLocale();
              },
              child: Text(LocaleKeys.reset_locale).tr(),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPreloaderWidget extends StatelessWidget {
  const CustomPreloaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('Loading custom preloder widget');
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
