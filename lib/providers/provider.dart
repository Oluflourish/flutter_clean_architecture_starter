import 'package:flutter_clean_architecture/providers/account_provider.dart';
import 'package:flutter_clean_architecture/providers/app_nav_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodProvider {
  static final appNavNotifier =
      ChangeNotifierProvider.autoDispose<AppNavNotifier>(
    (ref) => AppNavNotifier(),
  );

  static final accountProvider = ChangeNotifierProvider<AccountProvider>(
    (ref) => AccountProvider(),
  );
}
