

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/services/yolo_service.dart';
import '../widgets/edge_camera_view.dart';



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



String? streamUrl;



bool loading=false;


bool detectando=false;



int cantidadDetectada=0;


int cantidadValidada=0;



DateTime? fechaRecepcion;

DateTime? fechaVencimiento;





// ==========================
// ACTIVAR CAMARA EDGE
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


if(!mounted)
return;



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
// SUBIR IMAGEN
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



try{


setState((){

detectando=true;

});



final result =
await service.detectImage(

image

);



// DEBUG

print(result);
print(result.runtimeType);



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



if(!mounted)
return;



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






String formatDate(
DateTime? date
){


if(date==null)

return "dd/mm/aaaa";


return
"${date.day}/${date.month}/${date.year}";


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


streamUrl==null


?


const Center(

child:
Text(

"Sube una foto o activa la cámara"

)

)



:


EdgeCameraView(

url:
streamUrl!

),



),








const SizedBox(
height:15
),






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

"Productos detectados",


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

"Producto por validar",

style:
TextStyle(

fontSize:16,

fontWeight:
FontWeight.bold

),

),




const SizedBox(
height:8
),





Text(

"Cantidad detectada: $cantidadDetectada"

),





const SizedBox(
height:12
),






Wrap(

alignment:
WrapAlignment.center,


children:[


IconButton(

icon:
const Icon(
Icons.remove
),


onPressed:

(){

if(cantidadValidada > 0){

setState((){

cantidadValidada--;

});

}

},

),





Padding(

padding:
const EdgeInsets.symmetric(
horizontal:12
),


child:
Text(

"$cantidadValidada",

style:
const TextStyle(

fontSize:18,

fontWeight:
FontWeight.bold

),

),

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



],

)



]

),


)


),







const SizedBox(
height:20
),








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
(){


print(
"Lote: ${loteCtrl.text}"
);


print(
"Cantidad validada: $cantidadValidada"
);



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