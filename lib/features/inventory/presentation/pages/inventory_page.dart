import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';

import '../../data/models/kit_model.dart';
import '../../data/services/kit_service.dart';

import '../widgets/kit_modal.dart';
import '../widgets/product_modal.dart';
import '../widgets/category_modal.dart';
import '../widgets/restock_modal.dart';
import '../../data/services/batch_service.dart';

class InventoryPage extends StatefulWidget {

  const InventoryPage({
    super.key,
  });


  @override
  State<InventoryPage> createState() =>
      _InventoryPageState();

}




class _InventoryPageState extends State<InventoryPage> {


  final productService = ProductService();

  final kitService = KitService();

  final batchService = BatchService();

  List<Product> products = [];

  List<Kit> kits = [];



  bool loading = true;



  @override
  void initState() {

    super.initState();

    loadData();

  }





  Future<void> loadData() async {

    try {

      final productsResponse =
          await productService.getProducts();


      for (final product in productsResponse) {

        product.stock =
            await batchService.getProductStock(
              product.id,
            );

      }


      final kitsResponse =
          await kitService.getKits();


      if (!mounted) return;


      setState(() {

        products = productsResponse;

        kits = kitsResponse;

        loading = false;

      });


    } catch(e) {


      debugPrint(
        "Inventory error: $e",
      );


      if (!mounted) return;


      setState(() {

        loading = false;

      });


    }

  }






  void refresh(){


    setState(() {

      loading = true;

    });


    loadData();


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
          const Color(0xFFF4F6FA),



      appBar: AppBar(

        backgroundColor:
            Colors.orange,

        elevation:
            0,

        title:
            const Text(
              "Inventario",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

      ),




      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )


          : SingleChildScrollView(

              padding:
                  const EdgeInsets.all(16),


              child:
                  Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [




                  const Text(

                    "Gestión de Inventario",

                    style:
                        TextStyle(

                      fontSize:20,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),



                  const SizedBox(
                    height:15,
                  ),




                  Wrap(

                    spacing:10,

                    runSpacing:10,


                    children:[



                      FilledButton.icon(

                        icon:
                            const Icon(
                              Icons.category,
                            ),

                        label:
                            const Text(
                              "Categoría",
                            ),


                        onPressed: (){


                          showDialog(

                            context:context,

                            builder:(_)=>
                                const CategoryModal(),

                          ).then(
                              (_)=>refresh()
                          );


                        },

                      ),





                      FilledButton.icon(

                        style:
                            FilledButton.styleFrom(
                              backgroundColor:
                                  Colors.purple,
                            ),


                        icon:
                            const Icon(
                              Icons.inventory_2,
                            ),


                        label:
                            const Text(
                              "Kit",
                            ),


                        onPressed:(){


                          showDialog(

                            context:context,

                            builder:(_)=>
                                const KitModal(),

                          ).then(
                              (_)=>refresh()
                          );


                        },


                      ),





                      FilledButton.icon(

                        style:
                            FilledButton.styleFrom(
                              backgroundColor:
                                  Colors.green,
                            ),


                        icon:
                            const Icon(
                              Icons.add_box,
                            ),


                        label:
                            const Text(
                              "Producto",
                            ),


                        onPressed:(){


                          showDialog(

                            context:context,

                            builder:(_)=>
                                ProductModal(
                                  onSaved:refresh,
                                ),

                          );


                        },


                      ),






                      FilledButton.icon(

                        style:
                            FilledButton.styleFrom(
                              backgroundColor:
                                  Colors.orange,
                            ),


                        icon:
                            const Icon(
                              Icons.sync,
                            ),


                        label:
                            const Text(
                              "Reposición",
                            ),



                        onPressed:(){


                          showDialog(

                            context:context,

                            builder:(_)=>

                                RestockModal(

                                  products:
                                      products,

                                  onSaved:
                                      refresh,

                                ),


                          );


                        },

                      ),



                    ],

                  ),





                  const SizedBox(
                    height:25,
                  ),





                  _title(
                    "Productos",
                  ),




                  const SizedBox(
                    height:10,
                  ),






                  ...products.map((p){



                    final lowStock =
                        p.stock <= p.minStock;




                    return Card(


                      elevation:
                          1,


                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(14),

                      ),




                      child:
                          ListTile(



                        leading:
                            CircleAvatar(

                          backgroundColor:
                              Colors.orange.shade100,


                          child:
                              const Icon(
                                Icons.inventory,
                                color:
                                    Colors.brown,
                              ),

                        ),




                        title:
                            Text(

                              p.name,

                              style:
                                  const TextStyle(

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),





                        subtitle:
                            Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children:[


                            Text(
                              "Precio: S/. ${p.unitPrice}",
                            ),


                            Text(
                              "Stock: ${p.stock}",
                            ),


                          ],

                        ),




                        trailing:
                            Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal:10,

                            vertical:6,

                          ),


                          decoration:
                              BoxDecoration(

                            color:
                                lowStock
                                ? Colors.red
                                : Colors.green,


                            borderRadius:
                                BorderRadius.circular(12),

                          ),


                          child:
                              Text(

                                lowStock
                                ? "BAJO"
                                : "OK",


                                style:
                                    const TextStyle(

                                  color:
                                      Colors.white,

                                  fontSize:
                                      12,

                                ),

                              ),

                        ),


                      ),


                    );



                  }),





                  const SizedBox(
                    height:25,
                  ),





                  _title(
                    "Kits",
                  ),





                  const SizedBox(
                    height:10,
                  ),





                  ...kits.map((k){


                    return Card(


                      child:
                          ListTile(


                        leading:
                            const Icon(
                              Icons.inventory_2,
                              color:
                                  Colors.purple,
                            ),



                        title:
                            Text(
                              k.name,
                            ),



                        trailing:
                            Text(
                              "S/. ${k.totalPrice}",
                            ),


                      ),


                    );


                  }),





                ],

              ),

            ),


    );


  }





  Widget _title(String text){


    return Text(

      text,

      style:
          const TextStyle(

        fontSize:
            17,

        fontWeight:
            FontWeight.bold,

      ),

    );


  }



}