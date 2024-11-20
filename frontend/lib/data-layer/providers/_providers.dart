import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sandbox/data-layer/providers/account_provider.dart';
import 'package:sandbox/data-layer/providers/messages_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AccountProvider>(
    create: (context) => AccountProvider(),
    lazy: false,
  ),
  ChangeNotifierProvider<MessagesProvider>(
    create: (context) => MessagesProvider(),
    lazy: false,
  ),
];
