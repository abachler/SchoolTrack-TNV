//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 30-01-18, 10:48:37
  // ----------------------------------------------------
  // Método: STWA2_ValidaFechaPeriodo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


READ ONLY:C145([xxSTR_Niveles:6])
READ ONLY:C145([xxSTR_Periodos:100])

C_BOOLEAN:C305($b_antesInicioPeriodo;$b_salir)
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_mensaje;$l_nivelNumero)
C_TEXT:C284($t_antesInicioPeriodo;$t_mensajeFecha;$t_nivel)

C_OBJECT:C1216(o_raiz)

$l_nivelNumero:=$1
$d_fecha:=$2
$l_mensaje:=0

$b_antesInicioPeriodo:=False:C215
$t_antesInicioPeriodo:=""
$t_mensajeFecha:=""

If (Count parameters:C259=3)
	$l_mensaje:=$3
End if 

Case of 
	: ($l_mensaje=1)
		$t_nivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelNumero;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
		$t_mensajeFecha:="¡Atención!  Periodos no configurados. Revise la configuración de periodos para el nivel "+$t_nivel+" ."
		
	: ($l_mensaje=2)
		$t_mensajeFecha:=__ ("¡Atención! No se encuentra dentro del periodo escolar.")
		
	: ($l_mensaje=3)
		$t_mensajeFecha:=__ ("El año escolar aún no ha iniciado.")
		
End case 

PERIODOS_LoadData ($l_nivelNumero)
If (($d_fecha>=adSTR_Periodos_Desde{1}) & ($d_fecha<=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}))
	$t_mensajeFecha:=""
	$b_antesInicioPeriodo:=False:C215
Else 
	
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
	SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_noNivel)
	
	For ($i;1;Size of array:C274($al_noNivel))
		PERIODOS_LoadData ($al_noNivel{$i})
		If (($d_fecha>=adSTR_Periodos_Desde{1}) & ($d_fecha<=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}))
			$t_mensajeFecha:=""
			$b_antesInicioPeriodo:=False:C215
			$i:=Size of array:C274($al_noNivel)+1
		End if 
	End for 
	
End if 

If (Size of array:C274(adSTR_Periodos_Desde)>0)
	If ($d_fecha>=adSTR_Periodos_Desde{1})
		  //$t_mensajeFecha:=""
		If (Not:C34(DateIsValid ($d_fecha;0)))
			$b_salir:=True:C214
			$l_contador:=0
			$d_fechaWhile:=$d_fecha
			While (($b_salir) & ($l_contador<=30) & ($d_fechaWhile>=adSTR_Periodos_Desde{1}))
				$d_fechaWhile:=$d_fechaWhile-1
				If (DateIsValid ($d_fechaWhile;0))
					$b_salir:=False:C215
					$d_fecha:=$d_fechaWhile
				End if 
				$l_contador:=$l_contador+1
			End while 
			If ($b_salir)
				$b_antesInicioPeriodo:=True:C214
				$t_antesInicioPeriodo:=$t_mensajeFecha
			Else 
				$t_mensajeFecha:=""
			End if 
		Else 
			$t_mensajeFecha:=""
		End if 
	Else 
		$b_antesInicioPeriodo:=True:C214
		$t_antesInicioPeriodo:=$t_mensajeFecha
	End if 
Else 
	  //$b_antesInicioPeriodo:=True
	  //$t_antesInicioPeriodo:=$t_mensajeFecha
End if 

OB SET:C1220(o_raiz;"antesInicioPeriodo";$b_antesInicioPeriodo)
OB SET:C1220(o_raiz;"antesInicioPeriodoMsj";$t_antesInicioPeriodo)
OB SET:C1220(o_raiz;"mensajeFecha";$t_mensajeFecha)
OB SET:C1220(o_raiz;"fecha";String:C10($d_fecha))


$0:=o_raiz



