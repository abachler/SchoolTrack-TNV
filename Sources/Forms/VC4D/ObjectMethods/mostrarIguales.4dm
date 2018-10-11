  // VC4D.mostrarIguales()
  //
  //
  // creado por: Alberto Bachler Klein: 07-03-16, 10:09:40
  // -----------------------------------------------------------
  //C_LONGINT($i)
  //C_POINTER($y_controlArray;$y_ruta;$y_statusServer)

  //$y_ruta:=OBJECT Get pointer(Object named;"ruta")
  //$y_statusServer:=OBJECT Get pointer(Object named;"statusServer")
  //$y_controlArray:=LISTBOX Get array(*;"lb_vc4d";Listbox control array)

  //If ((OBJECT Get pointer(Object named;"mostrarIguales"))->=0)
  //ARRAY LONGINT($y_controlArray->;Size of array($y_statusServer->))
  //For ($i;1;Size of array($y_statusServer->))
  //$y_controlArray->{$i}:=Listbox row is hidden*Num(ST Get plain text($y_statusServer->{$i})="Iguales")
  //End for 
  //Else 
  //ARRAY LONGINT($y_controlArray->;0)
  //ARRAY LONGINT($y_controlArray->;Size of array($y_statusServer->))
  //End if 

POST KEY:C465(F5 key:K12:5)
  //LISTBOX SET ARRAY(*;"lb_vc4d";Listbox control array;$y_controlArray)