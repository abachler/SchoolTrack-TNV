//%attributes = {}
  //ACTmatrices_AsignaNuevasMatrice
C_LONGINT:C283($bloqueadas;$bloqueadas2;$l_idMatriz;$1)
C_BOOLEAN:C305($b_muestraMensaje;$2;$b_mostrarConfirmacion;$3)
C_LONGINT:C283($l_retorno;$0)
C_TEXT:C284($t_nombreMatriz)

ARRAY LONGINT:C221($al_idCtasCtes;0)
ARRAY LONGINT:C221($alACT_idMatrixOld;0)
ARRAY LONGINT:C221($al_idCtasCtesAfectadas;0)
ARRAY LONGINT:C221($alACT_idMatrixOldAfect;0)
ARRAY LONGINT:C221($al_idCtasCtesBloqueadas;0)
ARRAY LONGINT:C221($alACT_idMatrizBloq;0)

$l_idMatriz:=$1
If (Count parameters:C259>=2)
	$b_muestraMensaje:=$2
End if 
If (Count parameters:C259>=3)
	$b_mostrarConfirmacion:=$3
End if 

SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_idCtasCtes;[ACT_CuentasCorrientes:175]ID_Matriz:7;$alACT_idMatrixOld)

ACTcc_OpcionesCalculoCtaCte ("InitArrays")
$t_nombreMatriz:=Choose:C955($l_idMatriz=0;"Ninguna";KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->$l_idMatriz;->[ACT_Matrices:177]Nombre_matriz:2))
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Asignando matriz de cargo "+ST_Qte ($t_nombreMatriz)+"...")
For ($x;1;Size of array:C274($al_idCtasCtes))
	$bloqueadas2:=$bloqueadas
	$l_retorno:=ACTmatrices_AsignaNuevaMatriz ($al_idCtasCtes{$x};$l_idMatriz;$b_mostrarConfirmacion;->$bloqueadas)
	If ($bloqueadas2=$bloqueadas)
		APPEND TO ARRAY:C911($al_idCtasCtesAfectadas;$al_idCtasCtes{$x})
		APPEND TO ARRAY:C911($alACT_idMatrixOldAfect;$alACT_idMatrixOld{$x})
	Else 
		APPEND TO ARRAY:C911($al_idCtasCtesBloqueadas;$al_idCtasCtes{$x})
		APPEND TO ARRAY:C911($alACT_idMatrizBloq;$alACT_idMatrixOld{$x})
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/Size of array:C274($al_idCtasCtes))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
If ($b_mostrarConfirmacion)  //Estamos en la ficha de la cuenta
	ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
Else 
	ACTcc_OpcionesCalculoCtaCte ("RecalcularCtasBash")
End if 

If ($b_muestraMensaje)
	If ($bloqueadas>0)
		CD_Dlog (0;__ ("Algunas cuentas estaban siendo utilizadas por otros procesos. Las matrices para dichas cuentas no fueron modificadas."))
	End if 
End if 

  //log cambio matriz
C_TEXT:C284($t_nombreMatrizVieja;$t_nombreMatrizNueva;$t_alumno)
C_LONGINT:C283($l_idAl)

If (Size of array:C274($alACT_idMatrixOldAfect)>0)
	$t_nombreMatrizNueva:=Choose:C955($l_idMatriz=0;"Ninguna";KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->$l_idMatriz;->[ACT_Matrices:177]Nombre_matriz:2))
	$t_log:="Cambio en configuración de matrices de cargo para las siguientes cuentas: "+"\r"
	For ($l_indice;1;Size of array:C274($alACT_idMatrixOldAfect))
		$t_nombreMatrizVieja:=Choose:C955($alACT_idMatrixOldAfect{$l_indice}=0;"Ninguna";KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->$alACT_idMatrixOldAfect{$l_indice};->[ACT_Matrices:177]Nombre_matriz:2))
		$l_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$al_idCtasCtesAfectadas{$l_indice};->[ACT_CuentasCorrientes:175]ID_Alumno:3)
		$t_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAl;->[Alumnos:2]apellidos_y_nombres:40)
		$t_log:=$t_log+"Alumno: "+$t_alumno+" (id cuenta: "+String:C10($al_idCtasCtesAfectadas{$l_indice})+"). Matriz antigua: "+$t_nombreMatrizVieja+" (id: "+String:C10($alACT_idMatrixOldAfect{$l_indice})+"). Matriz nueva: "+$t_nombreMatrizNueva+" (id: "+String:C10($l_idMatriz)+")."+"\r"
	End for 
	LOG_RegisterEvt ($t_log)
End if 

  //log cuentas bloqueadas
If (Size of array:C274($al_idCtasCtesBloqueadas)>0)
	$t_log:="El cambio en configuración de matrices de cargo no pudo ser realizado, debido a que los registros estaban en uso, para las siguientes cuentas: "+"\r"
	For ($l_indice;1;Size of array:C274($al_idCtasCtesBloqueadas))
		$t_nombreMatrizVieja:=Choose:C955($alACT_idMatrizBloq{$l_indice}=0;"Ninguna";KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->$alACT_idMatrizBloq{$l_indice};->[ACT_Matrices:177]Nombre_matriz:2))
		$l_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$al_idCtasCtesBloqueadas{$l_indice};->[ACT_CuentasCorrientes:175]ID_Alumno:3)
		$t_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAl;->[Alumnos:2]apellidos_y_nombres:40)
		$t_log:=$t_log+"Alumno: "+$t_alumno+" (id cuenta: "+String:C10($al_idCtasCtesBloqueadas{$l_indice})+"). Matriz: "+$t_nombreMatrizVieja+" (id: "+String:C10($alACT_idMatrizBloq{$l_indice})+")."+"\r"
	End for 
	LOG_RegisterEvt ($t_log)
End if 

$0:=$l_retorno