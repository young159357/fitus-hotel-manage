import 'package:hotel_app/model/hotel_list.dart';
import 'package:http/http.dart' as http;

class RemotesService {
  Future<List<HotelList>?> getRoomList() async {
    var client = http.Client();
    var uri = Uri.parse('http://localhost:8000/hotels_info');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return hotelListFromJson(json);
    }
  }
}
