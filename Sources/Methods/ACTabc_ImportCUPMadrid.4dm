//%attributes = {}
  //INICIO documento creado en ticket 77340

  //vVerifier:="ColegiumTransferFile"
  //vType:="importer"
  //
  //
  //C_TIME($ref)
  //C_TEXT($text;$vt_line;$vt_clave)
  //C_LONGINT($vl_numeroLinea;$i)
  //C_BLOB($xBlob)
  //
  //$ref:=Open document($1;"";Read Mode )
  //If (ok=1)
  //CLOSE DOCUMENT($ref)
  //DOCUMENT TO BLOB(document;$xBlob)
  //
  //$vt_line:=BLOB to text($xBlob;Text without length )
  //$vl_numeroLinea:=0
  //ARRAY TEXT(aQR_Text1;0)
  //If (Length($vt_line)<32000)
  //Repeat 
  //APPEND TO ARRAY(aQR_Text1;"")
  //For ($i;1;6)
  //aQR_Text1{Size of array(aQR_Text1)}:=aQR_Text1{Size of array(aQR_Text1)}+ST_GetWord ($vt_line;$i+(6*$vl_numeroLinea);<>tb)
  //If (aQR_Text1{Size of array(aQR_Text1)}#"")
  //aQR_Text1{Size of array(aQR_Text1)}:=aQR_Text1{Size of array(aQR_Text1)}+<>tb
  //End if 
  //End for 
  //$vl_numeroLinea:=$vl_numeroLinea+1
  //Until (aQR_Text1{Size of array(aQR_Text1)}="")
  //AT_Delete (Size of array(aQR_Text1);1;->aQR_Text1)
  //
  //ARRAY REAL(aMonto;0)
  //ARRAY TEXT(aRUT;0)
  //ARRAY TEXT(aDescCodigo;0)
  //ARRAY TEXT(aCodAprobacion;0)
  //ARRAY TEXT(aNumTarjeta;0)
  //ARRAY TEXT(aNombre;0)
  //ARRAY REAL(aMontoMora;0)
  //ARRAY DATE(ad_fechaVcto;0)
  //ARRAY DATE(aFechaPagos;0)
  //ARRAY LONGINT(al_idAvisoAPagar;0)
  //
  //C_LONGINT($vl_idCta;$vl_idAl)
  //C_DATE($vd_fechaAC;$vd_fechaV)
  //C_TEXT($vt_referencia;$vt_msj)
  //
  //READ ONLY([Alumnos])
  //
  //READ ONLY([xxACT_ItemsCategorias])
  //READ ONLY([xxACT_Items])
  //READ ONLY([ACT_Cargos])
  //READ ONLY([ACT_Transacciones])
  //READ ONLY([ACT_CuentasCorrientes])
  //READ ONLY([ACT_Documentos_de_Cargo])
  //READ ONLY([ACT_Avisos_de_Cobranza])
  //
  //$text:=""
  //For ($i;1;Size of array(aQR_Text1))
  //$text:=aQR_Text1{$i}
  //AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto;->aFechaPagos;->al_idAvisoAPagar)
  //aMonto{Size of array(aMonto)}:=Num(ST_GetWord ($text;6;<>tb))
  //$vt_clave:=ST_GetWord ($text;4;<>tb)
  //aRUT{Size of array(aRUT)}:=String(Num(Substring($vt_clave;3;8)))
  //
  //  `aDescCodigo{Size of array(aDescCodigo)}:=Substring($text;53;2)
  //If (aDescCodigo{Size of array(aDescCodigo)}="")
  //aCodAprobacion{Size of array(aCodAprobacion)}:="0"
  //Else 
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //aNumTarjeta{Size of array(aNumTarjeta)}:=""
  //aNombre{Size of array(aNombre)}:=""
  //aMontoMora{Size of array(aMontoMora)}:=0
  //
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=Num(aRUT{Size of array(aRUT)}))
  //ad_fechaVcto{Size of array(ad_fechaVcto)}:=[ACT_Avisos_de_Cobranza]Fecha_Vencimiento
  //$vt_clave:=ST_GetWord ($text;1;<>tb)
  //aFechaPagos{Size of array(aFechaPagos)}:=DT_GetDateFromDayMonthYear (Num(Substring($vt_clave;1;Length($vt_clave)-4));Num(Substring($vt_clave;Length($vt_clave)-3;2));Num(Substring($vt_clave;Length($vt_clave)-1;2)))
  //aRUT{Size of array(aRUT)}:=String([ACT_Avisos_de_Cobranza]ID_Apoderado)
  //al_idAvisoAPagar{Size of array(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza]ID_Aviso
  //
  //If (Records in selection([ACT_Avisos_de_Cobranza])=1)
  //If ([ACT_Avisos_de_Cobranza]Monto_a_Pagar#0)
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente)
  //If (Records in selection([ACT_CuentasCorrientes])=1)
  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=[ACT_Avisos_de_Cobranza]ID_Aviso)
  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
  //If (Records in selection([ACT_Cargos])>0)
  //
  //  `********** INICIO  **********
  //  `borrar cargos de multa automatica
  //If (al_idAvisoAPagar{Size of array(al_idAvisoAPagar)}#0)
  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=al_idAvisoAPagar{Size of array(al_idAvisoAPagar)})
  //$vl_idCta:=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente
  //$vl_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes]ID;->$vl_idCta;->[ACT_CuentasCorrientes]ID_Alumno)
  //$vt_msj:=" Aviso de Cobranza número: "+String([ACT_Avisos_de_Cobranza]ID_Aviso)+"."
  //$vt_msj:=ST_Boolean2Str (($vl_idAl#0);$vt_msj+" Alumno: "+KRL_GetTextFieldData (->[Alumnos]Número;->$vl_idAl;->[Alumnos]Apellidos_y_Nombres)+".";$vt_msj+" Apoderado: "+KRL_GetTextFieldData (->[Personas]No;->[ACT_Avisos_de_Cobranza]ID_Apoderado;->[Personas]Apellidos_y_nombres)+".")
  //If (aFechaPagos{Size of array(aFechaPagos)}>[ACT_Avisos_de_Cobranza]Fecha_Vencimiento)
  //$vd_fechaV:=[ACT_Avisos_de_Cobranza]Fecha_Vencimiento
  //$vd_fechaV:=Add to date($vd_fechaV;0;1;0)
  //$vd_fechaV:=DT_GetDateFromDayMonthYear (1;Month of($vd_fechaV);Year of($vd_fechaV))
  //If (aFechaPagos{Size of array(aFechaPagos)}<=$vd_fechaV)
  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Comprobante=[ACT_Avisos_de_Cobranza]ID_Aviso)
  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
  //READ WRITE([ACT_Cargos])
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_AvisoMulta#"")
  //If (Records in selection([ACT_Cargos])>1)
  //ORDER BY([ACT_Cargos];[ACT_Cargos]Ref_AvisoMulta;<)
  //REDUCE SELECTION([ACT_Cargos];1)
  //KRL_RelateSelection (->[ACT_Transacciones]ID_Item;->[ACT_Cargos]ID;"")
  //C_LONGINT($vl_records)
  //SET QUERY DESTINATION(Into variable ;$vl_records)
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta#0)
  //SET QUERY DESTINATION(Into current selection )
  //If ((Sum([ACT_Cargos]MontosPagados)=0) & ($vl_records=0))
  //ACTcc_EliminaCargosLoop 
  //LOG_RegisterEvt ("Eliminación de cargo generado como multa automática durante el proceso de importa"+"ción de pagos."+$vt_msj)
  //Else 
  //aDescCodigo{Size of array(aDescCodigo)}:="Cargo de multa no puede ser eliminado porque está pagado o está en Documento Trib"+"utario. Referencia número "+$vt_referencia+"."
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //End if 
  //KRL_UnloadReadOnly (->[ACT_Cargos])
  //End if 
  //Else 
  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Comprobante=[ACT_Avisos_de_Cobranza]ID_Aviso)
  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
  //READ WRITE([ACT_Cargos])
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_AvisoMulta#"")
  //If (Records in selection([ACT_Cargos])>0)
  //KRL_RelateSelection (->[ACT_Transacciones]ID_Item;->[ACT_Cargos]ID;"")
  //C_LONGINT($vl_records)
  //SET QUERY DESTINATION(Into variable ;$vl_records)
  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta#0)
  //SET QUERY DESTINATION(Into current selection )
  //If ((Sum([ACT_Cargos]MontosPagados)=0) & ($vl_records=0))
  //ACTcc_EliminaCargosLoop 
  //LOG_RegisterEvt ("Eliminación de cargos generados como multa automática durante el proceso de impor"+"tación de pagos."+$vt_msj)
  //Else 
  //aDescCodigo{Size of array(aDescCodigo)}:="Cargos de multa no pueden ser eliminados porque están pagados o están en Document"+"os Tributarios. Referencia número "+$vt_referencia+"."
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //End if 
  //KRL_UnloadReadOnly (->[ACT_Cargos])
  //End if 
  //End if 
  //  `********** FIN **********
  //
  //If (Abs(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza]ID_Aviso;->[ACT_Cargos]Saldo;Current date(*)))#aMonto{Size of array(aMonto)})
  //al_idAvisoAPagar{Size of array(al_idAvisoAPagar)}:=0
  //aDescCodigo{Size of array(aDescCodigo)}:="EL AVISO QUE DESEA PAGAR ESTA PAGADO PARCIALMENTE O TOTALMENTE. AVISO DE COBRANZA"+" NÚMERO: "+String(Num(aRUT{Size of array(aRUT)}))
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //Else 
  //aDescCodigo{Size of array(aDescCodigo)}:="CARGOS NO ENCONTRADOS PARA EL AVISO DE COBRANZA NÚMERO "+String(Num(aRUT{Size of array(aRUT)}))
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //
  //Else 
  //aDescCodigo{Size of array(aDescCodigo)}:="EL ALUMNO ASOCIADO AL AVISO DE COBRANZA NÚMERO "+String(Num(aRUT{Size of array(aRUT)}))+" NO FUE ENCONTRADO."
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //
  //Else 
  //aDescCodigo{Size of array(aDescCodigo)}:="TODOS LOS AVISOS DE COBRANZA DE ESTE ALUMNO ESTAN PAGADOS. AVISO NÚMERO: "+String(Num(aRUT{Size of array(aRUT)}))
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //Else 
  //aDescCodigo{Size of array(aDescCodigo)}:="EL AVISO DE COBRANZA NÚMERO "+String(Num(aRUT{Size of array(aRUT)}))+" NO FUE ENCONTRADO."
  //aCodAprobacion{Size of array(aCodAprobacion)}:="-1"
  //End if 
  //End for 
  //  `AT_Delete (Size of array(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto)
  //<>vRUTField:=Field(->[Personas]No)
  //<>vRUTTable:=Table(->[Personas])
  //<>vLabelLink:="ID"
  //Else 
  //CD_Dlog (0;"El archivo no puede ser procesado.")
  //End if 
  //Else 
  //CD_Dlog (0;"El archivo no puede ser leído.")
  //End if 

  //FIN documento creado en ticket 77340