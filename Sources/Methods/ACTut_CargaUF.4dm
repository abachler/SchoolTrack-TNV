//%attributes = {}
  //  `ACTut_CargaUF
  //
  //  `método que carga la uf en un arreglo para evitar leer y cargar tantas veces. La UF cargada es la del presente año.
  //C_TEXT($accion)
  //If (Count parameters>=1)
  //$accion:=$1
  //End if 
  //If ($accion="")
  //$accion:="CargaUF"
  //End if 
  //
  //Case of 
  //: ($accion="CargaUF")
  //MESSAGES OFF
  //If (Application type#4D Remote Mode )
  //  `ACTcfg_AddRemoveUF 
  //ARRAY TEXT(<>atACTUF_RefAndVal;0)
  //C_TEXT($UFTableRef)
  //C_BLOB(xBlob)
  //ARRAY INTEGER(aiACT_DiaUF;0)
  //ARRAY REAL(arACT_ValorUFstored;0)
  //C_LONGINT($mes;$dia)
  //
  //For ($mes;1;12)
  //$UFTableRef:="ACT_UF"+String(Year of(Current date(*));"/0000")+"/"+String($mes;"00")
  //SET BLOB SIZE(xBlob;0)
  //xBlob:=PREF_fGetBlob (0;$UFTableRef;xBlob)
  //BLOB_Blob2Vars (->xBlob;0;->aiACT_DiaUF;->arACT_ValorUFstored)
  //COPY ARRAY(arACT_ValorUFstored;arACT_ValorUF)
  //For ($i;1;Size of array(arACT_ValorUF))
  //arACT_ValorUF{$i}:=Round(arACT_ValorUFstored{$i};2)
  //End for 
  //SET BLOB SIZE(xBlob;0)
  //For ($dia;1;Size of array(aiACT_DiaUF))
  //$el:=Find in array(aiACT_DiaUF;$dia)
  //If ($el#-1)
  //APPEND TO ARRAY(<>atACTUF_RefAndVal;String(Year of(Current date(*));"0000")+";"+String($mes;"00")+";"+String($dia;"00")+";"+String(arACT_ValorUF{$el}))
  //End if 
  //End for 
  //End for 
  //Else 
  //$p:=Execute on server(Current method name;64000;"Lectura de valores de UF para el presente año.")
  //End if 
  //: ($accion="ActualizaUF")
  //$p:=Execute on server(Current method name;64000;"Lectura de valores de UF para el presente año.")
  //End case 
