import 'package:http/http.dart' as http;

String _read = 'https://api.imgflip.com/get_memes';

class ImageService {
  static Future read() async {
    var request = http.Request('GET', Uri.parse(_read));
    request.headers.addAll({});

    http.StreamedResponse response = await request.send();
    var jsonData = await response.stream.bytesToString();

    return jsonData;
  }
}
