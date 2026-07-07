import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../data/services/batch_service.dart';



class RestockModal extends StatefulWidget {


  final List<Product> products;
  final VoidCallback onSaved;


  const RestockModal({
    super.key,
    required this.products,
    required this.onSaved,
  });



  @override
  State<RestockModal> createState() =>
      _RestockModalState();

}




class _RestockModalState extends State<RestockModal> {


  DateTime? receptionDate;

  DateTime? expirationDate;



  final batchService = BatchService();



  bool loading = false;



  List<RestockItem> items = [];




  @override
  void initState() {

    super.initState();

    items.add(
      RestockItem()
    );

  }





  Future<void> selectDate(bool reception) async {


    final date =
        await showDatePicker(

      context: context,

      firstDate:
          DateTime(2024),

      lastDate:
          DateTime(2035),

      initialDate:
          DateTime.now(),

    );



    if(date != null){


      setState((){


        if(reception){

          receptionDate = date;

        }

        else{

          expirationDate = date;

        }


      });


    }


  }





  Future<void> save() async {



    if(receptionDate == null ||
       expirationDate == null){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Seleccione las fechas"
          ),

        ),

      );


      return;

    }





    setState((){

      loading = true;

    });




    try {



      for(var item in items){



        if(item.product == null ||
            item.quantity <= 0){

          continue;

        }




        await batchService.createBatch({



          "productId":
              item.product!.id,



          "quantity":
              item.quantity,



          "expirationDate":
              expirationDate!
                  .toUtc()
                  .toIso8601String(),



          "receptionDate":
              receptionDate!
                  .toUtc()
                  .toIso8601String(),



        });



      }





      widget.onSaved();



      if(mounted){

        Navigator.pop(context);

      }




    }

    catch(e){



      debugPrint(
        "Error guardando reposicion: $e"
      );



      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content:
          Text(
            "Error: $e"
          ),

        ),

      );


    }



    if(mounted){

      setState((){

        loading = false;

      });

    }



  }







  @override
  Widget build(BuildContext context){



    return Dialog(


      child: Container(


        width:600,


        padding:
            const EdgeInsets.all(20),



        child:SingleChildScrollView(


          child:Column(


            mainAxisSize:
                MainAxisSize.min,



            children:[




              Row(


                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,



                children:[



                  const Text(

                    "Ingresar reposición",

                    style:
                    TextStyle(

                      fontSize:20,

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),




                  OutlinedButton.icon(


                    onPressed:(){},


                    icon:
                    const Icon(
                      Icons.center_focus_strong,
                    ),


                    label:
                    const Text(
                      "Usar YOLO",
                    ),


                  )



                ],


              ),





              const SizedBox(
                height:20,
              ),






              Row(


                children:[



                  Expanded(

                    child:
                    _dateButton(

                      "Fecha recepción",

                      receptionDate,

                          ()=>selectDate(true),

                    ),

                  ),




                  const SizedBox(
                    width:10,
                  ),





                  Expanded(

                    child:
                    _dateButton(

                      "Fecha vencimiento",

                      expirationDate,

                          ()=>selectDate(false),

                    ),

                  ),



                ],


              ),






              const SizedBox(
                height:20,
              ),





              ...items.map(
                    (e)=>_productRow(e),
              ),





              TextButton.icon(


                onPressed:(){


                  setState((){


                    items.add(
                        RestockItem()
                    );


                  });


                },



                icon:
                const Icon(
                    Icons.add
                ),



                label:
                const Text(
                  "Agregar producto",
                ),



              ),





              const SizedBox(
                height:20,
              ),






              Row(


                children:[



                  Expanded(

                    child:
                    OutlinedButton(


                      onPressed:
                      loading
                      ? null
                      : ()=>Navigator.pop(context),



                      child:
                      const Text(
                        "Cancelar",
                      ),


                    ),

                  ),




                  const SizedBox(
                    width:10,
                  ),





                  Expanded(


                    child:
                    FilledButton(


                      onPressed:
                      loading
                      ? null
                      : save,



                      child:
                      loading

                      ? const CircularProgressIndicator(
                          color:Colors.white,
                        )

                      :

                      const Text(
                        "Guardar",
                      ),


                    ),


                  ),



                ],


              )




            ],


          ),


        ),


      ),


    );


  }







  Widget _productRow(
      RestockItem item
      ){



    return Card(


      child:
      Padding(


        padding:
        const EdgeInsets.all(10),



        child:
        Row(



          children:[




            Expanded(


              flex:2,


              child:
              DropdownButton<Product>(



                value:
                item.product,



                hint:
                const Text(
                  "Seleccionar",
                ),



                isExpanded:true,



                items:

                widget.products.map(


                    (p)=>DropdownMenuItem(


                      value:p,


                      child:
                      Text(
                        p.name,
                      ),


                    )


                ).toList(),



                onChanged:(product){



                  setState((){


                    item.product =
                        product;


                  });



                },


              ),


            ),






            Expanded(


              child:
              Text(

                "${item.product?.stock ?? 0}",

                textAlign:
                TextAlign.center,

              ),


            ),





            IconButton(


              onPressed:(){


                if(item.quantity > 0){


                  setState((){

                    item.quantity--;

                  });


                }


              },


              icon:
              const Icon(
                Icons.remove,
              ),


            ),





            Text(
              "${item.quantity}",
            ),






            IconButton(


              onPressed:(){


                setState((){

                  item.quantity++;

                });


              },


              icon:
              const Icon(
                Icons.add,
              ),


            ),





            Text(

              "${(item.product?.stock ?? 0)
              +
              item.quantity}",

            ),




          ],


        ),


      ),


    );


  }







  Widget _dateButton(
      String title,
      DateTime? date,
      VoidCallback onTap
      ){


    return InkWell(


      onTap:onTap,



      child:
      InputDecorator(


        decoration:
        InputDecoration(

          labelText:title,

          border:
          const OutlineInputBorder(),

        ),



        child:
        Text(

          date == null

          ? ""

          :

          "${date.day}/${date.month}/${date.year}",


        ),


      ),


    );


  }



}







class RestockItem {


  Product? product;


  int quantity = 0;


}