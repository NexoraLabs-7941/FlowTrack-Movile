import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/storage/token_storage.dart';



class InventoryService {


final String baseUrl =
"https://test-ru6s.onrender.com";



Future<void> registrarDeteccion({

required String lote,

required String receptionDate,

required String expirationDate,

required int productId,

required int detectedQuantity,

required int verifiedQuantity,

}) async {



final token =
await TokenStorage.getToken();



var request =
http.MultipartRequest(

"POST",

Uri.parse(
"$baseUrl/api/v1/inventario/deteccion/registro"
)

);



request.headers.addAll({

"Authorization":
"Bearer $token"

});



request.fields.addAll({


"lote":
lote,


"receptionDate":
receptionDate,


"expirationDate":
expirationDate,


"productId":
productId.toString(),


"detectedQuantity":
detectedQuantity.toString(),


"verifiedQuantity":
verifiedQuantity.toString(),


});



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