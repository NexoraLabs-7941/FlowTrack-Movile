import 'package:flutter/material.dart';

import '../../data/services/product_service.dart';
import '../../data/services/category_service.dart';
import '../../data/services/supplier_service.dart';

import '../../data/models/category_model.dart';
import '../../data/models/provider_model.dart';
import '../../data/services/batch_service.dart';


class ProductModal extends StatefulWidget {


  final VoidCallback onSaved;



  const ProductModal({

    super.key,

    required this.onSaved,

  });



  @override
  State<ProductModal> createState()
      => _ProductModalState();


}







class _ProductModalState 
    extends State<ProductModal> {



  final nameCtrl =
      TextEditingController();


  final descCtrl =
      TextEditingController();


  final priceCtrl =
      TextEditingController();


  final stockCtrl =
      TextEditingController();


  final minStockCtrl =
      TextEditingController();




  final productService =
      ProductService();


  final categoryService =
      CategoryService();


  final providerService =
      ProviderService();
      

  final batchService =
        BatchService();




  List<Category> categories=[];

  List<Provider> providers=[];



  Category? selectedCategory;

  Provider? selectedProvider;




  bool loadingDropdowns=true;

  bool saving=false;







  @override

  void initState(){

    super.initState();

    loadData();

  }








  Future<void> loadData() async {



    try{


      final cats =
          await categoryService.getCategories();


      final provs =
          await providerService.getProviders();




      if(!mounted)return;



      setState((){


        categories=cats;

        providers=provs;

        loadingDropdowns=false;


      });



    }

    catch(e){


      setState((){

        loadingDropdowns=false;

      });


    }


  }




  Future<void> save() async {


    if(selectedCategory == null ||
      selectedProvider == null){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
            "Seleccione categoría y proveedor"
          ),

        ),

      );


      return;

    }





    setState((){

      saving=true;

    });





    try {



      // 1. CREAR PRODUCTO

      final product =
          await productService.createProduct({



        "name":
            nameCtrl.text.trim(),



        "description":
            descCtrl.text.trim(),




        "categoryId":
            selectedCategory!.id.toString(),



        "providerId":
            selectedProvider!.id.toString(),




        "minStock":
            int.tryParse(
              minStockCtrl.text
            ) ?? 0,



        "unitPrice":
            double.tryParse(
              priceCtrl.text
            ) ?? 0,



        "isActive":
            true,


      });






      // 2. CREAR STOCK INICIAL COMO BATCH


      final initialStock =
          int.tryParse(
            stockCtrl.text
          ) ?? 0;




      if(initialStock > 0){



        await batchService.createBatch({

          "productId":
              product.id,


          "quantity":
              initialStock,



          "receptionDate":
              DateTime.now()
                  .toIso8601String(),



          "expirationDate":
              DateTime.now()
                  .add(
                    const Duration(
                      days:365
                    )
                  )
                  .toIso8601String(),


        });



      }







      widget.onSaved();




      if(mounted){

        Navigator.pop(context);

      }






    } catch(e){



      ScaffoldMessenger.of(context)
          .showSnackBar(


        SnackBar(

          content:
          Text(
            "Error: $e"
          ),

        ),


      );



    } finally {



      if(mounted){

        setState((){

          saving=false;

        });


      }


    }


  }






  @override

  Widget build(BuildContext context){


    return AlertDialog(


      title:
      const Text(
        "Nuevo producto"
      ),



      content:


      loadingDropdowns

      ?

      const SizedBox(

        height:100,

        child:
        Center(
          child:
          CircularProgressIndicator(),
        ),

      )

      :

      SingleChildScrollView(


        child:
        Column(

          children:[



            _field(
              nameCtrl,
              "Nombre"
            ),



            _field(
              descCtrl,
              "Descripción"
            ),




            DropdownButtonFormField<Category>(


              value:
              selectedCategory,



              decoration:
              const InputDecoration(

                labelText:
                "Categoría"

              ),



              items:

              categories.map(

                    (c)=>

                DropdownMenuItem(

                  value:c,

                  child:
                  Text(c.name),

                ),

              ).toList(),



              onChanged:(v){

                setState((){

                  selectedCategory=v;

                });

              },



            ),





            DropdownButtonFormField<Provider>(


              value:
              selectedProvider,



              decoration:
              const InputDecoration(

                labelText:
                "Proveedor"

              ),




              items:

              providers.map(

                    (p)=>

                DropdownMenuItem(

                  value:p,

                  child:
                  Text(p.fullName),

                ),

              ).toList(),




              onChanged:(v){

                setState((){

                  selectedProvider=v;

                });

              },


            ),





            _numberField(
                stockCtrl,
                "Stock"
            ),



            _numberField(
                minStockCtrl,
                "Stock mínimo"
            ),



            _numberField(
                priceCtrl,
                "Precio"
            ),



          ],

        ),

      ),





      actions:[



        TextButton(

          onPressed:

          saving
          ? null
          : ()=>Navigator.pop(context),


          child:
          const Text(
            "Cancelar"
          ),

        ),




        ElevatedButton(


          onPressed:
          saving
          ? null
          : save,



          child:

          saving

          ?

          const SizedBox(

            width:18,

            height:18,

            child:
            CircularProgressIndicator(
              strokeWidth:2,
            ),

          )

          :

          const Text(
            "Guardar"
          ),


        )


      ],


    );


  }







  Widget _field(
      TextEditingController c,
      String label
      ){

    return TextField(

      controller:c,

      decoration:
      InputDecoration(
        labelText:label,
      ),

    );

  }







  Widget _numberField(
      TextEditingController c,
      String label
      ){

    return TextField(

      controller:c,

      keyboardType:
      TextInputType.number,


      decoration:
      InputDecoration(

        labelText:label,

      ),


    );


  }



}