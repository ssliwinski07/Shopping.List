import 'package:flutter/material.dart';
import 'core/core.dart';
import 'package:shopping_reminder/mobx/stores/shopping_items_store.dart';
import 'package:shopping_reminder/views/main_screen_view/main_screen_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator serviceLocator = ServiceLocator();
  await serviceLocator.serviceLocatorInit();

  HiveService hiveRepository = GetIt.instance<HiveService>();
  await hiveRepository.hiveInitialization();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ShoppingItemsStore>(create: (context) => ShoppingItemsStore())
      ],
      child: const MaterialApp(
        home: MainScreenView(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
