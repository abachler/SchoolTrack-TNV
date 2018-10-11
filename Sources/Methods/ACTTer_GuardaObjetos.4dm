//%attributes = {}
  //ACTTer_GuardaObjetos

  //C_TEXT($vt_accion;$1)
  //C_POINTER(${2})
  //C_POINTER($ptr1;$ptr2;$ptr3)
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
  //TRACE
  //Case of 
  //: ($vt_accion="GuardaItems")
  //If ($ptr1->>0)
  //READ WRITE([ACT_Terceros])
  //QUERY([ACT_Terceros];[ACT_Terceros]Id=$ptr1->)
  //If (Records in selection([ACT_Terceros])=1)
  //C_BLOB($xBlob)
  //$otRef:=OT New 
  //OT PutArray ($otRef;"ID_items";$ptr2->)
  //$xBlob:=OT ObjectToNewBLOB ($otRef)
  //OT Clear ($otRef)
  //[ACT_Terceros]Montos_Emitidos:=$xBlob
  //SAVE RECORD([ACT_Terceros])
  //  `ACTTer_GuardaObjetos ("ValidaRegistros";$ptr1;$ptr2)
  //End if 
  //End if 
  //
  //: ($vt_accion="GuardaCargas")
  //If ($ptr1->>0)
  //READ WRITE([ACT_Terceros])
  //QUERY([ACT_Terceros];[ACT_Terceros]Id=$ptr1->)
  //If (Records in selection([ACT_Terceros])=1)
  //C_BLOB($xBlob)
  //$otRef:=OT New 
  //OT PutArray ($otRef;"ID_Cargas";$ptr2->)
  //$xBlob:=OT ObjectToNewBLOB ($otRef)
  //OT Clear ($otRef)
  //[ACT_Terceros]Montos_Proyectados:=$xBlob
  //SAVE RECORD([ACT_Terceros])
  //End if 
  //End if 
  //
  //
  //End case 