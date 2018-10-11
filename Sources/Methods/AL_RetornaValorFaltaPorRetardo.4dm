//%attributes = {}
  //Metodo: AL_RetornaValorFaltaPorRetardo
  //Por abachler
  //Creada el 29/05/2008, 10:39:29
  // ----------------------------------------------------
  // Descripción
  // Retorna el valor de la falta correspondiente a los minutos de atraso, de acuerdo a lo establecidom en la configuracion
  //
  // ----------------------------------------------------
  // Parámetros
  // $1: minutos de atrasos, &L
  // $2: lectura de prefencias desde la configuración, &B; opcional
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_LONGINT:C283($1;$minutos)
C_REAL:C285($valorFalta;$0)
$minutos:=$1
$leerPreferencias:=True:C214
If (Count parameters:C259=2)
	$leerPreferencias:=$2
End if 

  //CUERPO
If (<>vr_InasistenciasXatrasos>0)
	If ($leerPreferencias)
		STR_LeePreferenciasAtrasos2 
	End if 
	For ($i;1;Size of array:C274(ATSTRAL_FALTAMINUTOSDESDE))
		If (($minutos>=ATSTRAL_FALTAMINUTOSDESDE{$i}) & ($minutos<=ATSTRAL_FALTAMINUTOSHASTA{$i}) & ($minutos>0))
			j_tabla1:=Num:C11(PREF_fGet (0;"ConfiguracionTablaPrimaria";"1"))
			If (j_tabla1=1)
				
				Case of 
					: ($i=1)
						$valorFalta:=$valorFalta+0.25
					: ($i=2)
						$valorFalta:=$valorFalta+0.5
					: ($i=3)
						$valorFalta:=$valorFalta+0.75
					: ($i=4)
						$valorFalta:=$valorFalta+1
				End case 
				
			Else 
				Case of 
					: ($i=1)
						$valorFalta:=$valorFalta+0.166
					: ($i=2)
						$valorFalta:=$valorFalta+0.2
					: ($i=3)
						$valorFalta:=$valorFalta+0.25
					: ($i=4)
						$valorFalta:=$valorFalta+0.5
					: ($i=5)
						$valorFalta:=$valorFalta+0.75
					: ($i=6)
						$valorFalta:=$valorFalta+1
				End case 
				
			End if 
			$i:=Size of array:C274(ATSTRAL_FALTAMINUTOSDESDE)
		End if 
	End for 
	$0:=$valorFalta
End if 


  //LIMPIEZA




