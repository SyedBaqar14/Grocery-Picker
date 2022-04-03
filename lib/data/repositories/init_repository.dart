

import 'package:flutter_picker_app/data/provider/init_provider.dart';

class InitRepository {
  final provider = InitProvider();

  // initProvider() {
  //   provider = InitProvider();
  // }

  get getClient => provider.client;
}
