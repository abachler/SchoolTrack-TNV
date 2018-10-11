//%attributes = {}
  // STWA2_AJAX_SendInfoCal()
  //
  //
  // modificado y normalizado por: Alberto Bachler Klein: 27-11-15, 12:19:31
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($l_Campo;$l_periodo;$l_recNum;$l_tabla)
C_TEXT:C284($t_json;$t_llave;$t_infoAdicional)  //MONO TICKET 186392
C_OBJECT:C1216($ob_json)


If (False:C215)
	C_TEXT:C284(STWA2_AJAX_SendInfoCal ;$0)
	C_LONGINT:C283(STWA2_AJAX_SendInfoCal ;$1)
	C_LONGINT:C283(STWA2_AJAX_SendInfoCal ;$2)
	C_LONGINT:C283(STWA2_AJAX_SendInfoCal ;$3)
	C_LONGINT:C283(STWA2_AJAX_SendInfoCal ;$4)
End if 

$l_tabla:=$1
$l_Campo:=$2
$l_recNum:=$3
$l_periodo:=$4
KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNum;False:C215)

If (OK=1)
	PERIODOS_Init 
	PERIODOS_LoadData ([Alumnos_Calificaciones:208]NIvel_Numero:4)
	If ($l_periodo=0)
		$l_periodo:=viSTR_PeriodoActual_Numero
	End if 
	If ($l_periodo>aiSTR_Periodos_Numero{Size of array:C274(aiSTR_Periodos_Numero)})
		$l_periodo:=Size of array:C274(aiSTR_Periodos_Numero)
	End if 
	
	$t_llave:=[Alumnos_Calificaciones:208]Llave_principal:1+"."+String:C10($l_Campo)
	$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_InfoCalificaciones:142]Llave:1;->$t_llave;False:C215)
	$ob_json:=OB_Create 
	If ($l_recNum<0)
		$t_norec:="norec"
		OB_SET ($ob_json;->$t_norec;"norec")
	Else 
		  //MONO TICKET 186392
		$y_infoExtra:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Control_Literal")
		If (Field:C253($y_infoExtra)=$l_Campo)
			$y_infoExtra:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P"+String:C10($l_periodo;"00")+"_Presentacion_Literal")
			$t_infoAdicional:=__ ("Información Relacionada: ")+__ ("Periodo ")+String:C10($l_periodo)+__ (" promedio de presentación: ")+$y_infoExtra->
		End if 
		
		OB_SET ($ob_json;->$t_infoAdicional;"infoAdicional")  //MONO TICKET 186392
		OB_SET ($ob_json;->[xxSTR_InfoCalificaciones:142]Info1:5;"info1")
		OB_SET ($ob_json;->[xxSTR_InfoCalificaciones:142]Info2:6;"info2")
		OB_SET ($ob_json;->[xxSTR_InfoCalificaciones:142]Info3:7;"info3")
		OB_SET ($ob_json;->[xxSTR_InfoCalificaciones:142]Log:8;"log")
		OB_SET ($ob_json;->[xxSTR_InfoCalificaciones:142]Registro_Autor:4;"autor")
		OB_SET ($ob_json;->[xxSTR_InfoCalificaciones:142]Registro_Fecha:3;"fecha";String:C10(Internal date short:K1:7))
		OB_SET ($ob_json;->[xxSTR_InfoCalificaciones:142]Registro_hora:2;"hora";String:C10(HH MM SS:K7:1))
		OB_SET ($ob_json;->$l_recNum;"recnum")
	End if 
	$t_json:=OB_Object2Json ($ob_json)
	$0:=$t_json
Else 
	$0:=STWA2_JSON_SendError (-40000)
End if 