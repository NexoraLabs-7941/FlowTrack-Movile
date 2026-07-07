import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/storage/token_storage.dart';



class BatchService {


  final String baseUrl =
      "https://test-ru6s.onrender.com";





  Future<Map<String,String>> _headers() async {


    final token =
        await TokenStorage.getToken();



    return {


      "Authorization":
          "Bearer $token",


      "Content-Type":
          "application/json",


      "Accept":
          "application/json",


    };


  }






  // =====================================
  // CREAR BATCH
  // INGRESAR STOCK INICIAL
  // =====================================


  Future<void> createBatch(
      Map<String,dynamic> body
  ) async {



    debugPrint(
      "ENVIANDO BATCH:"
    );


    debugPrint(
      jsonEncode(body)
    );





    final response =
        await http.post(


      Uri.parse(
        "$baseUrl/api/v1/batches"
      ),


      headers:
          await _headers(),


      body:
          jsonEncode(body),


    );





    debugPrint(
      "RESPUESTA BATCH:"
    );


    debugPrint(
      response.body
    );






    if(response.statusCode != 200 &&
       response.statusCode != 201){



      throw Exception(

        "Error creando batch: ${response.body}"

      );


    }



  }









  // =====================================
  // OBTENER STOCK REAL DEL PRODUCTO
  // =====================================



  Future<int> getProductStock(
      int productId
  ) async {



    final response =
        await http.get(



      Uri.parse(

        "$baseUrl/api/v1/products/$productId/batches"

      ),



      headers:

          await _headers(),



    );





    if(response.statusCode != 200){


      debugPrint(
        "Error obteniendo batches: ${response.body}"
      );


      return 0;


    }







    final List data =
        jsonDecode(response.body);





    int total = 0;





    for(var batch in data){



      total += int.tryParse(

        batch["quantity"]
            .toString()

      ) ?? 0;



    }






    return total;



  }







}