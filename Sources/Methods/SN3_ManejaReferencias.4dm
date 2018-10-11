//%attributes = {}
  // SN3_ManejaReferencias
  // Por: Alberto Bachler: 14/08/13, 06:31:42
  // --------------------------------------------- //
  //
  // ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_POINTER:C301($5)
C_LONGINT:C283($l_accion;$l_IdRegistro;$l_IdRegistroVacio;$l_recNum;$l_tipoDeDato)
C_POINTER:C301($y_arreglo)
C_TEXT:C284($t_evento;$t_llave;$t_llaveRegistro)
If (False:C215)
	C_TEXT:C284(SN3_ManejaReferencias ;$1)
	C_LONGINT:C283(SN3_ManejaReferencias ;$2)
	C_LONGINT:C283(SN3_ManejaReferencias ;$3)
	C_LONGINT:C283(SN3_ManejaReferencias ;$4)
	C_POINTER:C301(SN3_ManejaReferencias ;$5)
End if 
$t_evento:=$1
$l_tipoDeDato:=$2
$l_IdRegistro:=$3
$l_accion:=$4
If (Count parameters:C259=5)
	$y_arreglo:=$5
End if 
Case of 
	: ($t_evento="actualizar")
		$t_llaveRegistro:=String:C10($l_tipoDeDato)+"."+String:C10($l_IdRegistro)
		$l_IdRegistroVacio:=0
		$l_recNum:=Find in field:C653([xxSN3_RegistrosXEnviar:143]llave:4;$t_llaveRegistro)
		If ($l_recNum<0)
			  // no hay registro correspondiente a la llave, busco un registro vacío
			$l_recNum:=Find in field:C653([xxSN3_RegistrosXEnviar:143]ID:2;$l_IdRegistroVacio)
			If ($l_recNum<0)
				  // no hay ningún registro vacío, lo creo
				CREATE RECORD:C68([xxSN3_RegistrosXEnviar:143])
			Else 
				  // reutilizo el primer registro vacío encontrado
				KRL_GotoRecord (->[xxSN3_RegistrosXEnviar:143];$l_recNum;True:C214)
			End if 
			  // asigno los valores
			[xxSN3_RegistrosXEnviar:143]tipoDato:1:=$l_tipoDeDato
			[xxSN3_RegistrosXEnviar:143]ID:2:=$l_IdRegistro
			[xxSN3_RegistrosXEnviar:143]accion:3:=$l_accion
			[xxSN3_RegistrosXEnviar:143]llave:4:=$t_llaveRegistro
			[xxSN3_RegistrosXEnviar:143]DTS_Local:5:=Timestamp:C1445
			SAVE RECORD:C53([xxSN3_RegistrosXEnviar:143])
			UNLOAD RECORD:C212([xxSN3_RegistrosXEnviar:143])
		Else 
			  // hay un registro correspondiente a la llave, actualizo la acción
			KRL_GotoRecord (->[xxSN3_RegistrosXEnviar:143];$l_recNum;True:C214)
			If ([xxSN3_RegistrosXEnviar:143]accion:3#$l_accion)
				[xxSN3_RegistrosXEnviar:143]accion:3:=$l_accion
				[xxSN3_RegistrosXEnviar:143]DTS_Local:5:=Timestamp:C1445
				SAVE RECORD:C53([xxSN3_RegistrosXEnviar:143])
			End if 
			KRL_UnloadReadOnly (->[xxSN3_RegistrosXEnviar:143])
		End if 
	: ($t_evento="eliminar")
		READ WRITE:C146([xxSN3_RegistrosXEnviar:143])
		QUERY:C277([xxSN3_RegistrosXEnviar:143];[xxSN3_RegistrosXEnviar:143]tipoDato:1=$l_tipoDeDato;*)
		QUERY:C277([xxSN3_RegistrosXEnviar:143]; & ;[xxSN3_RegistrosXEnviar:143]accion:3=$l_accion)
		If (Count parameters:C259=5)
			QRY_QueryWithArray (->[xxSN3_RegistrosXEnviar:143]ID:2;$y_arreglo;True:C214)
		End if 
		If (Records in selection:C76([xxSN3_RegistrosXEnviar:143])>0)
			SN3_LiberaRegistrosXEnviar 
		End if 
	: ($t_evento="buscar")
		READ ONLY:C145([xxSN3_RegistrosXEnviar:143])
		QUERY:C277([xxSN3_RegistrosXEnviar:143];[xxSN3_RegistrosXEnviar:143]tipoDato:1=$l_tipoDeDato;*)
		QUERY:C277([xxSN3_RegistrosXEnviar:143]; & ;[xxSN3_RegistrosXEnviar:143]accion:3=$l_accion)
		SELECTION TO ARRAY:C260([xxSN3_RegistrosXEnviar:143]ID:2;$y_arreglo->)
		UNLOAD RECORD:C212([xxSN3_RegistrosXEnviar:143])
End case 

  //  //SN3_ManejaReferencias ` MÉTODO: SN3_ManejaReferencias
  //  // ----------------------------------------------------
  //  // Usuario (OS): Alberto Bachler
  //  // Fecha de creación: 08/03/12, 15:05:05
  //  // ----------------------------------------------------
  //  // DESCRIPCIÓN
  //  //
  //  //
  //  // PARÁMETROS
  //  // SN3_ManejaReferencias()
  //  // ----------------------------------------------------
  //C_TEXT($1)
  //C_LONGINT($2)
  //C_LONGINT($3)
  //C_LONGINT($4)
  //C_POINTER($5)
  //
  //C_LONGINT($l_accion;$l_IdRegistro;$l_tipoDeDato;;$l_recNum)
  //C_POINTER($y_arreglo)
  //C_TEXT($t_evento;$t_llaveRegistro)
  //
  //If (False)
  //C_TEXT(SN3_ManejaReferencias ;$1)
  //C_LONGINT(SN3_ManejaReferencias ;$2)
  //C_LONGINT(SN3_ManejaReferencias ;$3)
  //C_LONGINT(SN3_ManejaReferencias ;$4)
  //C_POINTER(SN3_ManejaReferencias ;$5)
  //End if 
  //
  //
  //
  //
  //  // CODIGO PRINCIPAL
  //$t_evento:=$1
  //$l_tipoDeDato:=$2
  //$l_IdRegistro:=$3
  //$l_accion:=$4
  //
  //If (Count parameters=5)
  //$y_arreglo:=$5
  //End if 
  //
  //READ ONLY([xxSN3_RegistrosXEnviar])
  //Case of 
  //: ($t_evento="actualizar")
  //$t_llaveRegistro:=String($l_tipoDeDato)+"."+String($l_IdRegistro)
  //$l_recNum:=Find in field([xxSN3_RegistrosXEnviar]llave;$t_llaveRegistro)
  //If ($l_recNum<0)
  //CREATE RECORD([xxSN3_RegistrosXEnviar])
  //[xxSN3_RegistrosXEnviar]tipoDato:=$l_tipoDeDato
  //[xxSN3_RegistrosXEnviar]ID:=$l_IdRegistro
  //[xxSN3_RegistrosXEnviar]accion:=$l_accion
  //[xxSN3_RegistrosXEnviar]llave:=$t_llaveRegistro
  //SAVE RECORD([xxSN3_RegistrosXEnviar])
  //UNLOAD RECORD([xxSN3_RegistrosXEnviar])
  //Else 
  //KRL_GotoRecord (->[xxSN3_RegistrosXEnviar];$l_recNum;True)
  //If ([xxSN3_RegistrosXEnviar]accion#$l_accion)
  //[xxSN3_RegistrosXEnviar]accion:=$l_accion
  //SAVE RECORD([xxSN3_RegistrosXEnviar])
  //End if 
  //KRL_UnloadReadOnly (->[xxSN3_RegistrosXEnviar])
  //End if 
  //: ($t_evento="eliminar")
  //READ WRITE([xxSN3_RegistrosXEnviar])
  //QUERY([xxSN3_RegistrosXEnviar];[xxSN3_RegistrosXEnviar]tipoDato=$l_tipoDeDato;*)
  //QUERY([xxSN3_RegistrosXEnviar]; & ;[xxSN3_RegistrosXEnviar]accion=$l_accion)
  //If (Count parameters=5)
  //QRY_QueryWithArray (->[xxSN3_RegistrosXEnviar]ID;$y_arreglo;True)
  //End if 
  //DELETE SELECTION([xxSN3_RegistrosXEnviar])
  //KRL_UnloadReadOnly (->[xxSN3_RegistrosXEnviar])
  //: ($t_evento="buscar")
  //READ ONLY([xxSN3_RegistrosXEnviar])
  //QUERY([xxSN3_RegistrosXEnviar];[xxSN3_RegistrosXEnviar]tipoDato=$l_tipoDeDato;*)
  //QUERY([xxSN3_RegistrosXEnviar]; & ;[xxSN3_RegistrosXEnviar]accion=$l_accion)
  //SELECTION TO ARRAY([xxSN3_RegistrosXEnviar]ID;$y_arreglo->)
  //UNLOAD RECORD([xxSN3_RegistrosXEnviar])
  //End case 
  //
