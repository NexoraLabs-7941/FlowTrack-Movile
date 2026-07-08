import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';



class YoloService {


  static const String baseUrl =
      "https://wound-tighten-mushy.ngrok-free.dev";





  Future<String> startCamera() async {


    final response =
        await http.post(

      Uri.parse(
        "$baseUrl/api/v1/vision/start?camera_id=0"
      ),

    );



    if(response.statusCode != 200){

      throw Exception(
        "Error iniciando cámara"
      );

    }



    final data =
        jsonDecode(response.body);



    return data["stream_url"];

  }

Future<Map<String,dynamic>> detectImage(
    XFile image
) async {


  var request =
      http.MultipartRequest(

    "POST",

    Uri.parse(
      "$baseUrl/api/v1/vision/detect-image"
    ),

  );



  final bytes =
      await image.readAsBytes();



  request.files.add(

    http.MultipartFile.fromBytes(

      "image",

      bytes,

      filename: image.name,

    ),

  );



  final response =
      await request.send();



  final body =
      await response.stream.bytesToString();



  if(response.statusCode != 200){

    throw Exception(body);

  }



  return jsonDecode(body);


}


}