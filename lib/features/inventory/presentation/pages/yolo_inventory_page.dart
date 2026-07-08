import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/services/yolo_service.dart';
import '../../data/services/product_service.dart';
import '../../data/models/product_model.dart';
import '../widgets/edge_camera_view.dart';
import '../../data/services/inventory_service.dart';
import '../../data/services/inventory_detection_service.dart';

class YoloInventoryPage extends StatefulWidget {


  const YoloInventoryPage({
    super.key
  });


  @override
  State<YoloInventoryPage> createState()
      => _YoloInventoryPageState();

}





class _YoloInventoryPageState
extends State<YoloInventoryPage>{



final loteCtrl =
TextEditingController(
  text:"L-01"
);



final YoloService service =
YoloService();



final ProductService productService =
ProductService();

final InventoryDetectionService inventoryDetectionService =
    InventoryDetectionService();

String? streamUrl;



XFile? imagenSeleccionada;


Uint8List? imagenBytes;



bool loading=false;


bool detectando=false;




int cantidadDetectada=0;


int cantidadValidada=0;



List<Product> productos=[];



Product? productoSeleccionado;



int stockActual=0;



DateTime? fechaRecepcion;


DateTime? fechaVencimiento;






@override
void initState(){

super.initState();

cargarProductos();

}







// ==========================
// PRODUCTOS
// ==========================


Future<void> cargarProductos() async{


try{


final data =
await productService.getProducts();



if(!mounted)
return;



setState((){


productos=data;



if(productos.isNotEmpty){

productoSeleccionado =
productos.first;

}


});



if(productoSeleccionado!=null){

await cargarStock(
productoSeleccionado!.id
);

}



}catch(e){

print(
"Error productos $e"
);

}



}







Future<void> cargarStock(
int productId
) async{


final stock =
await productService
.getProductStock(productId);



if(!mounted)
return;



setState((){


stockActual=stock;



});



}









// ==========================
// CAMARA EDGE
// ==========================


Future<void> activarCamara() async{


try{


setState((){

loading=true;

});



final url =
await service.startCamera();



if(!mounted)
return;



setState((){


streamUrl=url;


loading=false;



});



}catch(e){



setState((){

loading=false;

});



ScaffoldMessenger.of(context)
.showSnackBar(

SnackBar(

content:
Text(
"Error cámara: $e"
)

)

);



}


}









// ==========================
// DETECCION IMAGEN
// ==========================


Future<void> subirImagen() async{


final picker =
ImagePicker();



final image =
await picker.pickImage(

source:
ImageSource.gallery

);



if(image==null)
return;




final bytes =
await image.readAsBytes();



setState((){


imagenSeleccionada=image;


imagenBytes=bytes;


detectando=true;


});




try{



final result =
await service.detectImage(
image
);



print(result);



if(!mounted)
return;



setState((){


cantidadDetectada =
result["total_count"] ?? 0;



cantidadValidada =
cantidadDetectada;



detectando=false;



});





}catch(e){



setState((){

detectando=false;

});



ScaffoldMessenger.of(context)
.showSnackBar(

SnackBar(

content:
Text(
"Error detección: $e"
)

)

);



}



}






// ==========================
// FECHAS
// ==========================


Future<void> selectDate(
bool recepcion
) async{


final date =
await showDatePicker(

context:context,


firstDate:
DateTime(2025),


lastDate:
DateTime(2030),


initialDate:
DateTime.now(),

);



if(date==null)
return;



setState((){


if(recepcion){

fechaRecepcion=date;

}

else{

fechaVencimiento=date;

}


});


}





String formatDate(DateTime? date){

if(date==null){

return "";

}


return
"${date.year}-"
"${date.month.toString().padLeft(2,'0')}-"
"${date.day.toString().padLeft(2,'0')}";

}
@override
Widget build(BuildContext context){


return Scaffold(


appBar:
AppBar(

title:
const Text(
"Inventario YOLO"
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






TextField(


controller:
loteCtrl,


decoration:
const InputDecoration(

labelText:
"Lote",

border:
OutlineInputBorder()

),


),







const SizedBox(
height:12
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
OutlineInputBorder()

),



child:
Text(

formatDate(
fechaRecepcion
)

),


),


)

),





const SizedBox(
width:10
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
OutlineInputBorder()

),



child:
Text(

formatDate(
fechaVencimiento
)

),



),


)

),


]


),







const SizedBox(
height:20
),








// ==========================
// VIDEO / IMAGEN
// ==========================


Container(


height:230,


width:
double.infinity,


decoration:
BoxDecoration(


color:
Colors.grey.shade200,


borderRadius:
BorderRadius.circular(15)


),




child:



streamUrl != null



?

EdgeCameraView(

url:
streamUrl!

)



:



imagenBytes != null



?

ClipRRect(

borderRadius:
BorderRadius.circular(15),


child:

Image.memory(

imagenBytes!,


width:
double.infinity,


height:
230,


fit:
BoxFit.cover,

),

)




:


const Center(

child:
Text(

"Sube una foto o activa la cámara"

)

),



),







const SizedBox(
height:15
),









// CAMARA


SizedBox(

width:
double.infinity,


child:
ElevatedButton.icon(


style:
ElevatedButton.styleFrom(

backgroundColor:
Colors.orange

),



onPressed:

loading
?
null
:
activarCamara,



icon:
const Icon(

Icons.camera_alt,

color:
Colors.white

),



label:
const Text(

"Activar cámara",

style:
TextStyle(

color:
Colors.white

)

),


),


),







const SizedBox(
height:10
),









// SUBIR FOTO


SizedBox(

width:
double.infinity,


child:
OutlinedButton.icon(


onPressed:

detectando
?
null
:
subirImagen,



icon:

detectando

?

const SizedBox(

width:18,

height:18,

child:
CircularProgressIndicator(

strokeWidth:2

)

)



:

const Icon(
Icons.upload
),



label:

Text(

detectando

?

"Detectando..."

:

"+ Subir foto"

),


),


),







const SizedBox(
height:25
),









const Text(

"Items por validar",

style:
TextStyle(

fontSize:18,

fontWeight:
FontWeight.bold

),

),







const SizedBox(
height:10
),







// ==========================
// CARD INVENTARIO
// ==========================


Card(

child:
Padding(


padding:
const EdgeInsets.all(12),



child:
Column(


crossAxisAlignment:
CrossAxisAlignment.start,


children:[





const Text(

"Producto",

style:
TextStyle(

fontWeight:
FontWeight.bold

)

),






const SizedBox(
height:8
),








DropdownButton<Product>(


isExpanded:true,


value:
productoSeleccionado,



items:

productos.map((producto){


return DropdownMenuItem<Product>(


value:
producto,


child:
Text(

producto.name

),


);


}).toList(),





onChanged:(producto) async{


if(producto==null)
return;



setState((){


productoSeleccionado =
producto;


});



await cargarStock(

producto.id

);



},



),







const Divider(),







Row(

mainAxisAlignment:
MainAxisAlignment.spaceBetween,


children:[


const Text(
"Stock actual"
),


Text(

"$stockActual",

style:
const TextStyle(

fontWeight:
FontWeight.bold

)

)


],


),







const SizedBox(
height:8
),






Row(

mainAxisAlignment:
MainAxisAlignment.spaceBetween,


children:[


const Text(
"Cant. detectada"
),



Text(

"$cantidadDetectada",

style:
const TextStyle(

color:
Colors.orange,

fontWeight:
FontWeight.bold

)

)



],


),







const SizedBox(
height:8
),









Row(

mainAxisAlignment:
MainAxisAlignment.spaceBetween,


children:[


const Text(
"Cant. validada"
),






Row(

children:[



IconButton(

icon:
const Icon(
Icons.remove
),



onPressed:
(){

if(cantidadValidada>0){


setState((){

cantidadValidada--;

});


}


},



),






Text(

"$cantidadValidada",

style:
const TextStyle(

fontSize:18,

fontWeight:
FontWeight.bold

)

),






IconButton(

icon:
const Icon(
Icons.add
),



onPressed:
(){


setState((){


cantidadValidada++;


});


},



),




]

)



],


),








const Divider(),









Row(

mainAxisAlignment:
MainAxisAlignment.spaceBetween,


children:[


const Text(

"TOTAL",

style:
TextStyle(

fontWeight:
FontWeight.bold

)

),




Text(

"${stockActual + cantidadValidada}",


style:
const TextStyle(

color:
Colors.green,

fontSize:18,

fontWeight:
FontWeight.bold

)

)



],


)





],


)


),


),







const SizedBox(
height:20
),









// GUARDAR


SizedBox(

width:
double.infinity,


child:
ElevatedButton(



style:
ElevatedButton.styleFrom(

backgroundColor:
Colors.green

),





onPressed:
() async {
if(imagenSeleccionada == null){

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text(
"Debe subir una imagen"
)

)

);

return;

}



if(productoSeleccionado == null){

ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text(
"Seleccione un producto"
)

)

);

return;

}

try{

await inventoryDetectionService.registrarDeteccion(

lote:
loteCtrl.text,


receptionDate:
formatDate(fechaRecepcion),


expirationDate:
formatDate(fechaVencimiento),


productId:
productoSeleccionado!.id,


detectedQuantity:
cantidadDetectada,


verifiedQuantity:
cantidadValidada,


image:
imagenSeleccionada!,


);



ScaffoldMessenger.of(context)
.showSnackBar(

const SnackBar(

content:
Text(
"Inventario registrado correctamente"
)

)

);



}catch(e){



ScaffoldMessenger.of(context)
.showSnackBar(

SnackBar(

content:
Text(
"Error guardando: $e"
)

)

);



}



},





child:
const Text(

"GUARDAR",

style:
TextStyle(

color:
Colors.white

)

),


),


)





],


),


),


);


}



}