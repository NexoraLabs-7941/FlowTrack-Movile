import 'package:flutter/material.dart';

class YoloInventoryPage extends StatefulWidget {
  const YoloInventoryPage({super.key});

  @override
  State<YoloInventoryPage> createState() =>
      _YoloInventoryPageState();
}


class _YoloInventoryPageState 
    extends State<YoloInventoryPage> {


  final loteCtrl =
      TextEditingController(text: "L-01");


  DateTime? fechaRecepcion;
  DateTime? fechaVencimiento;



  int cantidadValidada = 3;


  final int stockActual = 11;

  final int cantidadDetectada = 3;



  Future<void> selectDate(
      bool recepcion
  ) async {


    final date =
        await showDatePicker(

      context: context,

      firstDate:
          DateTime(2025),

      lastDate:
          DateTime(2030),

      initialDate:
          DateTime.now(),

    );


    if(date == null) return;


    setState((){


      if(recepcion){

        fechaRecepcion = date;

      }else{

        fechaVencimiento = date;

      }


    });


  }





  String formatDate(DateTime? date){

    if(date == null){

      return "dd/mm/aaaa";

    }


    return
      "${date.day}/${date.month}/${date.year}";

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "Inventario YOLO",
          style:
          TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),

        backgroundColor:
        Colors.orange,

      ),



      body:


      SingleChildScrollView(


        padding:
        const EdgeInsets.all(16),


        child:
        Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children:[



            // DATOS GENERALES

            Row(

              children:[


                Expanded(

                  child:
                  TextField(

                    controller:
                    loteCtrl,

                    decoration:
                    const InputDecoration(

                      labelText:
                      "Lote",

                      border:
                      OutlineInputBorder(),

                    ),

                  ),

                ),


              ],


            ),



            const SizedBox(
              height:12,
            ),




            Row(

              children:[


                Expanded(

                  child:
                  InkWell(

                    onTap:(){

                      selectDate(true);

                    },


                    child:
                    InputDecorator(

                      decoration:
                      const InputDecoration(

                        labelText:
                        "Fecha recepción",

                        border:
                        OutlineInputBorder(),

                      ),


                      child:
                      Text(
                        formatDate(
                          fechaRecepcion
                        ),
                      ),

                    ),

                  ),

                ),




                const SizedBox(
                  width:10,
                ),




                Expanded(

                  child:
                  InkWell(

                    onTap:(){

                      selectDate(false);

                    },


                    child:
                    InputDecorator(

                      decoration:
                      const InputDecoration(

                        labelText:
                        "Fecha vencimiento",

                        border:
                        OutlineInputBorder(),

                      ),


                      child:
                      Text(
                        formatDate(
                          fechaVencimiento
                        ),
                      ),

                    ),

                  ),

                ),


              ],

            ),




            const SizedBox(
              height:20,
            ),






            // AREA CAMARA


            Container(

              height:230,


              width:
              double.infinity,


              decoration:
              BoxDecoration(

                color:
                Colors.grey.shade200,


                borderRadius:
                BorderRadius.circular(15),


                border:
                Border.all(
                  color:
                  Colors.grey.shade400,
                ),

              ),



              child:
              Column(

                mainAxisAlignment:
                MainAxisAlignment.center,


                children:[


                  Icon(

                    Icons.camera_alt,

                    size:60,

                    color:
                    Colors.grey,

                  ),



                  const SizedBox(
                    height:10,
                  ),



                  const Text(

                    "Sube una foto o activa la cámara",

                    style:
                    TextStyle(
                      color:
                      Colors.grey,
                    ),

                  )


                ],

              ),


            ),





            const SizedBox(
              height:15,
            ),





            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton.icon(


                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.orange,

                  padding:
                  const EdgeInsets.all(15),

                ),



                onPressed:(){},


                icon:
                const Icon(
                  Icons.camera_alt,
                  color:
                  Colors.white,
                ),



                label:
                const Text(

                  "Activar cámara",

                  style:
                  TextStyle(
                    color:
                    Colors.white,
                  ),

                ),


              ),

            ),





            const SizedBox(
              height:10,
            ),





            SizedBox(

              width:
              double.infinity,


              child:
              OutlinedButton.icon(


                onPressed:(){},


                icon:
                const Icon(
                  Icons.upload,
                ),


                label:
                const Text(
                  "+ Subir foto",
                ),


              ),

            ),





            const SizedBox(
              height:25,
            ),






            const Text(

              "Productos detectados",

              style:
              TextStyle(

                fontSize:18,

                fontWeight:
                FontWeight.bold,

              ),

            ),





            const SizedBox(
              height:10,
            ),





            // CARD PRODUCTO DETECTADO


            Card(

              elevation:2,


              shape:
              RoundedRectangleBorder(

                borderRadius:
                BorderRadius.circular(15),

              ),



              child:
              Padding(

                padding:
                const EdgeInsets.all(15),


                child:
                Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,


                  children:[


                    const Text(

                      "Gaseosa 600ml",

                      style:
                      TextStyle(

                        fontSize:17,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),




                    const SizedBox(
                      height:10,
                    ),



                    Text(
                      "Stock actual: $stockActual",
                    ),



                    Text(
                      "Cantidad detectada: $cantidadDetectada",
                    ),




                    const SizedBox(
                      height:15,
                    ),




                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,


                      children:[


                        const Text(
                          "Cantidad validada",
                        ),



                        Row(

                          children:[


                            IconButton(

                              onPressed:(){

                                if(cantidadValidada>0){

                                  setState((){

                                    cantidadValidada--;

                                  });

                                }

                              },

                              icon:
                              const Icon(
                                Icons.remove,
                              ),

                            ),




                            Text(

                              "$cantidadValidada",

                              style:
                              const TextStyle(

                                fontSize:18,

                                fontWeight:
                                FontWeight.bold,

                              ),

                            ),




                            IconButton(

                              onPressed:(){

                                setState((){

                                  cantidadValidada++;

                                });

                              },


                              icon:
                              const Icon(
                                Icons.add,
                              ),

                            ),


                          ],

                        )



                      ],

                    ),




                    const Divider(),




                    Align(

                      alignment:
                      Alignment.centerRight,


                      child:
                      Text(

                        "Total: ${stockActual + cantidadValidada}",


                        style:
                        const TextStyle(

                          color:
                          Colors.green,

                          fontWeight:
                          FontWeight.bold,

                          fontSize:18,

                        ),

                      ),

                    )



                  ],


                ),


              ),


            ),






            const SizedBox(
              height:20,
            ),





            SizedBox(

              width:
              double.infinity,


              child:
              ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.green,

                  padding:
                  const EdgeInsets.all(15),

                ),


                onPressed:(){},


                child:
                const Text(

                  "GUARDAR",

                  style:
                  TextStyle(

                    color:
                    Colors.white,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),

              ),

            )





          ],


        ),


      ),



    );


  }


}