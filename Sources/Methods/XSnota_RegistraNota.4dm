//%attributes = {}
  // XSnota_RegistraNota()
  // Por: Alberto Bachler K.: 11-03-15, 17:55:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3;$4;$5;$6)

C_LONGINT:C283($l_tabla)
C_POINTER:C301($y_campo;$y_campoUUID;$y_referencia)
C_TEXT:C284($t_mensaje)


If (False:C215)
	C_LONGINT:C283(XSnota_RegistraNota ;$0)
	C_POINTER:C301(XSnota_RegistraNota ;$1)
	C_POINTER:C301(XSnota_RegistraNota ;$2)
	C_TEXT:C284(XSnota_RegistraNota ;$3)
End if 

$y_campoUUID:=$1
$y_referencia:=$2
$t_descripcionEvento:=$3
$t_mensaje:=$4
$t_botonAceptar:=__ ("Aceptar")
$t_botonCancelar:=__ ("Cancelar")

Case of 
	: (Count parameters:C259=7)
		$t_tituloVentana:=$5
		$t_botonAceptar:=$6
		$t_botonCancelar:=$7
	: (Count parameters:C259=6)
		$t_tituloVentana:=$5
		$t_botonAceptar:=$6
	: (Count parameters:C259=5)
		$t_tituloVentana:=$5
End case 


  // Modificado por: Alexis Bustamante (16-06-2017)
  //Ticket 179869
C_OBJECT:C1216(ob_mensajeRegistroNota)
ob_mensajeRegistroNota:=OB_Create 
OB_SET (ob_mensajeRegistroNota;->$t_tituloVentana;"tituloVentana")
OB_SET (ob_mensajeRegistroNota;->$t_mensaje;"mensaje")
OB_SET (ob_mensajeRegistroNota;->$t_botonAceptar;"botonAceptar")
OB_SET (ob_mensajeRegistroNota;->$t_botonCancelar;"botonCancelar")
  //$t_textoJSon:=OB_Object2Json (ob_mensajeRegistroNota)

  //vt_jSonObjetosFormulario:=JSON New 
  //JSON_AgregaElemento (vt_jSonObjetosFormulario;->$t_tituloVentana;"tituloVentana")
  //JSON_AgregaElemento (vt_jSonObjetosFormulario;->$t_mensaje;"mensaje")
  //JSON_AgregaElemento (vt_jSonObjetosFormulario;->$t_botonAceptar;"botonAceptar")
  //JSON_AgregaElemento (vt_jSonObjetosFormulario;->$t_botonCancelar;"botonCancelar")
  //$t_textoJSon:=JSON Export to text (vt_jSonObjetosFormulario;JSON_WITH_WHITE_SPACE)

Case of 
	: (Not:C34(Asserted:C1132(Field:C253($y_campoUUID)>0;"El primer argumento debe ser un puntero sobre un campo")))
		
	: (Not:C34(Asserted:C1132(Util_isValidUUID ($y_campoUUID->);"El primer argumento debe ser un puntero sobre un campo de tipo UUID")))
		
	Else 
		START TRANSACTION:C239
		CREATE RECORD:C68([xShell_RecordNotes:283])
		[xShell_RecordNotes:283]ID_Tabla:1:=Table:C252($y_campoUUID)
		[xShell_RecordNotes:283]UUID_Registro:2:=$y_campoUUID->
		[xShell_RecordNotes:283]Referencia:3:=ST_Coerce_to_Text ($y_referencia)
		[xShell_RecordNotes:283]Usuario:5:=USR_GetUserName 
		[xShell_RecordNotes:283]DescripcionEvento:9:=$t_descripcionEvento
		SAVE RECORD:C53([xShell_RecordNotes:283])
		
		WDW_OpenFormWindow (->[xShell_RecordNotes:283];"Registro";-1;Plain form window:K39:10)
		KRL_ModifyRecord (->[xShell_RecordNotes:283];"Registro")
		CLOSE WINDOW:C154
		If (OK=0)
			CANCEL TRANSACTION:C241
		Else 
			VALIDATE TRANSACTION:C240
		End if 
		$0:=OK
		
		KRL_ReloadAsReadOnly (->[xShell_RecordNotes:283])
End case 

  //JSON CLOSE (vt_jSonObjetosFormulario)









