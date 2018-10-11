//%attributes = {}
  // ModernUI_Notificacion(titulo:T {; mensaje:T {; boton1:T {; boton2:T {; boton3:T {; mostrarEnServidor:B ; {opcionNoRepetir}}}})
  // - si se pasan 1 o 2 argumentos muestra una alerta sin botones, cierra automáticamente con un clic en cualquier parte
  // - si se pasan 3 argumentos se muestra una alerta con un boton titulado con el tercer argumento
  // - en los demás casos se muestra un cuadro de diálogo de confirmación con 2 o 3 botones dependiendo del úmero de parámetros válidos (no vacíos)
  // - True en mostrarEnServidor muestra el diálogo en el servidor
  // - True en opcionNoRepetir, muestra un checkbox "No volver a Preguntar", si usuario activa la variable vl_NoRepetirNotificacion tomoa valor 1
  // 
  // creado por: Alberto Bachler Klein: 30-12-16, 10:26:22
  // -----------------------------------------------------------

C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_BOOLEAN:C305($6)
C_BOOLEAN:C305($7)

C_BOOLEAN:C305($b_MostrarEnServidor)
C_LONGINT:C283($l_tipoVentana;$l_tipoVentanaAnterior)
C_POINTER:C301($y_nil)



If (False:C215)
	C_LONGINT:C283(ModernUI_Notificacion ;$0)
	C_TEXT:C284(ModernUI_Notificacion ;$1)
	C_TEXT:C284(ModernUI_Notificacion ;$2)
	C_TEXT:C284(ModernUI_Notificacion ;$3)
	C_TEXT:C284(ModernUI_Notificacion ;$4)
	C_TEXT:C284(ModernUI_Notificacion ;$5)
	C_BOOLEAN:C305(ModernUI_Notificacion ;$6)
	C_BOOLEAN:C305(ModernUI_Notificacion ;$7)
End if 

C_LONGINT:C283(iResult)
C_TEXT:C284(vsBWR_CurrentModule)
C_TEXT:C284(vt_mensaje;cdS_btn1;cdS_btn2;cdS_btn3)
C_PICTURE:C286(vpXS_IconModule)

$l_tipoVentanaAnterior:=Window kind:C445
vt_Titulo:=""
vt_mensaje:=""
cdS_btn1:=""
cdS_btn2:=""
cdS_btn3:=""

vl_NoRepetirNotificacion:=0
vb_OpcionNoRepetir:=False:C215
$l_tipoVentana:=Movable dialog box:K34:7
Case of 
	: (Count parameters:C259=1)
		vt_Titulo:=$1
		cdS_btn1:="OK"
		  //$l_tipoVentana:=Pop up window
		
	: (Count parameters:C259=2)
		vt_Titulo:=$1
		vt_mensaje:=$2
		cdS_btn1:="OK"
		  //$l_tipoVentana:=Pop up window
		
	: (Count parameters:C259=2)
		vt_Titulo:=$1
		vt_mensaje:=$2
		cdS_btn1:="OK"
		cdS_btn2:=""
		cdS_btn3:=""
		
	: (Count parameters:C259=3)
		vt_Titulo:=$1
		vt_mensaje:=$2
		cdS_btn1:=$3
		cdS_btn2:=""
		cdS_btn3:=""
		
	: (Count parameters:C259=4)
		vt_Titulo:=$1
		vt_mensaje:=$2
		cdS_btn1:=$3
		cdS_btn2:=$4
		cdS_btn3:=""
		
	: (Count parameters:C259=5)
		vt_Titulo:=$1
		vt_mensaje:=$2
		cdS_btn1:=$3
		cdS_btn2:=$4
		cdS_btn3:=$5
		
	: (Count parameters:C259=6)
		vt_Titulo:=$1
		vt_mensaje:=$2
		cdS_btn1:=$3
		cdS_btn2:=$4
		cdS_btn3:=$5
		$b_MostrarEnServidor:=$6
		
	: (Count parameters:C259=7)
		vt_Titulo:=$1
		vt_mensaje:=$2
		cdS_btn1:=$3
		cdS_btn2:=$4
		cdS_btn3:=$5
		$b_MostrarEnServidor:=$6
		vb_OpcionNoRepetir:=$7
End case 


If (((<>vb_MsgON) & (Application type:C494#4D Server:K5:6)) | ($b_MostrarEnServidor))
	If ($l_tipoVentanaAnterior=0)
		$l_tipoVentana:=Pop up form window:K39:11
	End if 
	
	
	WDW_OpenFormWindow ($y_nil;"Notificacion";-1;$l_tipoVentana)
	DIALOG:C40("Notificacion")
	CLOSE WINDOW:C154
	$0:=iResult
End if 


