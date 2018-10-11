//%attributes = {}
  //ACTter_LeeObjectos

  //C_TEXT($vt_accion;$1)
  //C_POINTER(${2})
  //C_POINTER($ptr1;$ptr2;$ptr3;$ptr4)
  //C_LONGINT($vl_idItem)
  //C_LONGINT($vl_idCuenta;$vl_idCtaCte)
  //$vt_accion:=$1
  //
  //If (Count parameters>=2)
  //$ptr1:=$2
  //End if 
  //
  //If (Count parameters>=3)
  //$ptr2:=$3
  //End if 
  //
  //If (Count parameters>=4)
  //$ptr3:=$4
  //End if 
  //
  //If (Count parameters>=5)
  //$ptr4:=$5
  //End if 
  //TRACE
  //Case of 
  //: ($vt_accion="LeeItems")
  //If ($ptr1->>0)
  //READ WRITE([ACT_Terceros])
  //QUERY([ACT_Terceros];[ACT_Terceros]Id=$ptr1->)
  //If (BLOB size([ACT_Terceros]Montos_Emitidos)>0)
  //$xBlob:=[ACT_Terceros]Montos_Emitidos
  //$otRef:=OT BLOBToObject ($xBlob)
  //OT GetArray ($otRef;"ID_items";$ptr2->)
  //OT Clear ($otRef)
  //ACTter_LeeObjectos ("ValidaIdsItems";$ptr2;$ptr3)
  //End if 
  //End if 
  //: ($vt_accion="ValidaIdsItems")
  //READ ONLY([xxACT_Items])
  //For ($i;Size of array($ptr1->);1;-1)
  //$vl_idItem:=$ptr1->{$i}
  //KRL_FindAndLoadRecordByIndex (->[xxACT_Items]ID;->$vl_idItem)
  //If (Records in selection([xxACT_Items])=0)
  //AT_Delete ($i;1;$ptr1)
  //ACTTer_GuardaObjetos ("Items";->[ACT_Terceros]Id;$ptr1)
  //Else 
  //If (Not(Nil($ptr2)))
  //APPEND TO ARRAY($ptr2->;[xxACT_Items]Glosa)
  //End if 
  //End if 
  //End for 
  //
  //: ($vt_accion="LeeCargas")
  //If ($ptr1->>0)
  //READ WRITE([ACT_Terceros])
  //QUERY([ACT_Terceros];[ACT_Terceros]Id=$ptr1->)
  //If (BLOB size([ACT_Terceros]Montos_Proyectados)>0)
  //$xBlob:=[ACT_Terceros]Montos_Proyectados
  //$otRef:=OT BLOBToObject ($xBlob)
  //OT GetArray ($otRef;"ID_Cargas";$ptr2->)
  //OT Clear ($otRef)
  //ACTter_LeeObjectos ("ValidaIdsCargas";$ptr1;$ptr2;$ptr3;$ptr4)
  //End if 
  //End if 
  //
  //: ($vt_accion="ValidaIdsCargas")
  //READ ONLY([ACT_CuentasCorrientes])
  //For ($i;Size of array($ptr2->);1;-1)
  //$vl_idCuenta:=$ptr2->{$i}
  //KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes]ID;->$vl_idCuenta)
  //If (Records in selection([ACT_CuentasCorrientes])=0)
  //AT_Delete ($i;1;$ptr2)
  //ACTTer_GuardaObjetos ("Cargas";->[ACT_Terceros]Id;$ptr2)
  //Else 
  //If ((Not(Nil($ptr3))) & (Not(Nil($ptr4))))
  //ARRAY LONGINT($al_nivelNumero;0)
  //For ($x;1;Size of array($ptr2->))
  //READ ONLY([ACT_CuentasCorrientes])
  //READ ONLY([Alumnos])
  //$vl_idCtaCte:=$ptr2->{$x}
  //KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes]ID;->$vl_idCtaCte)
  //APPEND TO ARRAY($al_nivelNumero;KRL_GetNumericFieldData (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno;->[Alumnos]Nivel_Número))
  //APPEND TO ARRAY($ptr3->;KRL_GetTextFieldData (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno;->[Alumnos]Curso))
  //APPEND TO ARRAY($ptr4->;KRL_GetTextFieldData (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno;->[Alumnos]Apellidos_y_Nombres))
  //End for 
  //SORT ARRAY($al_nivelNumero;$ptr3->;$ptr4->;$ptr2->;>)
  //End if 
  //End if 
  //End for 
  //
  //Else 
  //TRACE
  //
  //End case 