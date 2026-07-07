import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';
import '../../../../core/storage/token_storage.dart';


class ProductService {


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

    };

  }



  // =========================
  // GET PRODUCTS
  // =========================


  Future<List<Product>> getProducts() async {


    final response =
        await http.get(

      Uri.parse(
        "$baseUrl/api/v1/products"
      ),

      headers:
          await _headers(),

    );


    if(response.statusCode != 200){

      throw Exception(
        "Error cargando productos ${response.body}"
      );

    }


    final List data =
        jsonDecode(response.body);


    return data
        .map(
          (e)=>Product.fromJson(e)
        )
        .toList();

  }





  // =========================
  // CREATE PRODUCT
  // =========================


  Future<Product> createProduct(
      Map<String,dynamic> body
  ) async {


    final response =
        await http.post(

      Uri.parse(
        "$baseUrl/api/v1/products"
      ),

      headers:
          await _headers(),

      body:
          jsonEncode(body),

    );



    debugPrint(
      "CREATE PRODUCT:"
    );

    debugPrint(
      response.body
    );



    if(response.statusCode != 200 &&
       response.statusCode != 201){

      throw Exception(
        response.body
      );

    }



    return Product.fromJson(
      jsonDecode(response.body)
    );


  }




  // =========================
  // STOCK REAL
  // =========================


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

      return 0;

    }



    final List data =
        jsonDecode(response.body);



    int total = 0;


    for(var batch in data){

      total += int.tryParse(
        batch["quantity"].toString()
      ) ?? 0;

    }


    return total;

  }




  // =========================
  // GET PRODUCT BY ID
  // =========================


  Future<Product> getProductById(
      int id
  ) async {


    final response =
        await http.get(

      Uri.parse(
        "$baseUrl/api/v1/products/$id"
      ),

      headers:
          await _headers(),

    );



    if(response.statusCode != 200){

      throw Exception(
        "Producto no encontrado"
      );

    }


    return Product.fromJson(
      jsonDecode(response.body)
    );


  }


}