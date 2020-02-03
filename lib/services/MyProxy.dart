


 import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
  return super.createHttpClient(context)
       ..findProxy = (uri) {

         return "PROXY 45.129.39.188:8118;DIRECT";
       }
       ..badCertificateCallback =
         (X509Certificate cert, String host, int port) => true;

}
} 