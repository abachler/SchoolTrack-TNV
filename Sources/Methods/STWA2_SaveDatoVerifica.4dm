//%attributes = {}

  //  // ----------------------------------------------------
  //  // Usuario (SO): Adrian Sepulveda 
  //  // Fecha y hora: 06/10/16, 10:44:55
  //  // ----------------------------------------------------
  //  // Método: STWA2_SaveDatoVerifica
  //  // Descripción
  //  // 
  //  //
  //  // Parámetros
  //  // ----------------------------------------------------



  //C_POINTER($1;$2;$3;$json)
  //C_POINTER($field_literal_Ptr;$field_real_Ptr;$field_nota_Ptr;$field_puntos_Ptr;$field_simbolo_Ptr;$ppPtr;$arrPtr)
  //C_BOOLEAN($0)
  //C_REAL($real)

  //$y_Names:=$1
  //$y_data:=$2

  //$json:=$3

  //$b_continuar:=False
  //$dataType:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipo")
  //$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
  //$userID:=STWA2_Session_GetUserSTID ($uuid)
  //$profID:=STWA2_Session_GetProfID ($uuid)
  //$userName:=USR_GetUserName ($userID)

  //Case of 
  //: ($dataType="grabarinasistenciahora")
  //$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
  //$userID:=STWA2_Session_GetUserSTID ($uuid)
  //$profID:=STWA2_Session_GetProfID ($uuid)
  //$idalumno:=Num(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idalumno"))
  //$idsesion:=Num(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idsesion"))
  //$dd:=Num(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
  //$md:=Num(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
  //$ad:=Num(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
  //$fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
  //$fAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas]Numero;->[Asignaturas_RegistroSesiones]ID_Asignatura)
  //If ($fAsignatura>-1)
  //  //verifico si existe licencia para el día que se registra la inasistencia
  //QUERY([Asignaturas_Inasistencias];[Asignaturas_Inasistencias]ID_Sesión=$idsesion;*)
  //QUERY([Asignaturas_Inasistencias]; & ;[Asignaturas_Inasistencias]ID_Alumno=$idalumno)
  //If ([Asignaturas_Inasistencias]ID_Licencia#0)
  //$b_continuar:=True
  //OB_SET_Text ($y_refjson->;"justificada";"ERR")
  //End if 

  //End if 
  //End case 
  //$0:=$b_continuar