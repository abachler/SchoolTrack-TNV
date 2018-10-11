//%attributes = {}
  // ModernUI_Peticion(titulo:&T; mensaje:&T; pregunta:&T; respuestaPredefinida:&T; botonValidacion:&T {;boton2:&T {;boton3:&T}})
  // Por: Alberto Bachler K.: 02-09-14, 10:43:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)

C_LONGINT:C283($l_tipoVentana;$l_tipoVentanaAnterior)
C_POINTER:C301($y_nil)



If (False:C215)
	C_TEXT:C284(ModernUI_Peticion ;$0)
	C_TEXT:C284(ModernUI_Peticion ;$1)
	C_TEXT:C284(ModernUI_Peticion ;$2)
	C_TEXT:C284(ModernUI_Peticion ;$3)
	C_TEXT:C284(ModernUI_Peticion ;$4)
	C_TEXT:C284(ModernUI_Peticion ;$5)
End if 

C_TEXT:C284(vsBWR_CurrentModule)
C_TEXT:C284(vt_mensaje;cdS_btn1;cdS_btn2;cdS_btn3)
C_PICTURE:C286(vpXS_IconModule)


vt_Titulo:=""
vt_mensaje:=""
vt_Pregunta:=""
vt_Respuesta:=""
cdS_btn1:=""
cdS_btn2:=""
cdS_btn3:=""
vt_listaValores:=""

If ((<>vb_MsgON) & (Application type:C494#4D Server:K5:6))
	$l_tipoVentana:=Movable dialog box:K34:7
	
	Case of 
		: (Count parameters:C259=4)
			vt_Titulo:=$1
			vt_mensaje:=$2
			cdS_btn1:=$3
			cdS_btn2:=$4
			cdS_btn3:=""
			
		: (Count parameters:C259=6)
			vt_Titulo:=$1
			vt_mensaje:=$2
			vt_pregunta:=$3
			vt_respuesta:=$4
			cdS_btn1:=$5
			cdS_btn2:=$6
			
		: (Count parameters:C259=6)
			vt_Titulo:=$1
			vt_mensaje:=$2
			vt_pregunta:=$3
			vt_respuesta:=$4
			cdS_btn1:=$5
			cdS_btn2:=$6
			
		: (Count parameters:C259=7)
			vt_Titulo:=$1
			vt_mensaje:=$2
			vt_pregunta:=$3
			vt_respuesta:=$4
			cdS_btn1:=$5
			cdS_btn2:=$6
			cdS_btn3:=$7
			
			
		: (Count parameters:C259=8)
			vt_Titulo:=$1
			vt_mensaje:=$2
			vt_pregunta:=$3
			vt_respuesta:=$4
			cdS_btn1:=$5
			cdS_btn2:=$6
			cdS_btn3:=$7
			vt_ListaValores:=$8
	End case 
	
	
	WDW_OpenFormWindow ($y_nil;"Peticion";-1;$l_tipoVentana)
	DIALOG:C40("Peticion")
	CLOSE WINDOW:C154
	If (OK=1)
		$0:=vt_respuesta
	End if 
	
End if 

