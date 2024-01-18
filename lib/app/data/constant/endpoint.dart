import 'package:peminjam/app/data/provider/storange_provider.dart';

class Endpoint {
  static const String baseUrlApi = "https://api-perpustakaan.abadjayasenantiasa.com/api/v1/user/";


  static const String register = "${baseUrlApi}register";
  static const String login = "${baseUrlApi}login";
  static const String book = "${baseUrlApi}book";
  static String pinjam = "${baseUrlApi}pinjam/${int.parse(StorageProvider.read(StorageKey.idUser))}";
}