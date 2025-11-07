import 'main_shared.dart' as shared;

Future<void> main() async {
  await shared.bootstrap(flavor: 'staging');
}
