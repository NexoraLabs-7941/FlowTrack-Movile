
import 'package:http/http.dart' as http;

import '../../../../core/storage/token_storage.dart';

import 'package:image_picker/image_picker.dart';

class InventoryDetectionService {


  final String baseUrl =
      "https://test-ru6s.onrender.com";




Future<void> registrarDeteccion({

required String lote,

required String receptionDate,

required String expirationDate,

required int productId,

required int detectedQuantity,

required int verifiedQuantity,

required XFile image,

}) async {



final token =
await TokenStorage.getToken();



final uri =
Uri.parse(
"$baseUrl/api/v1/inventario/deteccion/registro"
).replace(

queryParameters:{


"lote":lote,

"receptionDate":receptionDate,

"expirationDate":expirationDate,

"productId":productId.toString(),

"detectedQuantity":detectedQuantity.toString(),

"verifiedQuantity":verifiedQuantity.toString(),


}

);




var request =
http.MultipartRequest(
"POST",
uri
);



request.headers.addAll({

"Authorization":
"Bearer $token"

});





final bytes =
await image.readAsBytes();



request.files.add(

http.MultipartFile.fromBytes(

"image",

bytes,

filename:
image.name,

)

);





final response =
await request.send();



final body =
await response.stream.bytesToString();



print(
"STATUS ${response.statusCode}"
);

print(body);



if(response.statusCode != 200 &&
response.statusCode != 201){

throw Exception(body);

}


}
}