  // [Cursos].Input.lb_acta()
  // Por: Alberto Bachler K.: 02-03-14, 09:37:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($i;$l_posicionDestino;$l_posicionOrigen;$l_posicionPromedioFinal;$l_proceso)
C_POINTER:C301($y_origen)
C_TEXT:C284($t_asignatura)

$l_posicionPromedioFinal:=Find in array:C230(atActas_Subsectores;"Promedio Final")


Case of 
	: ((Form event:C388=On Begin Drag Over:K2:44) | (Form event:C388=On Drag Over:K2:13))
		DRAG AND DROP PROPERTIES:C607($y_origen;$l_posicionOrigen;$l_proceso)
		
		
	: (Form event:C388=On Drop:K2:12)
		Case of 
			: ($l_posicionDestino>=$l_posicionPromedioFinal)
				$0:=-1  // la posición de las columnas a partir del promedfio final no puede ser modificada
			: ($l_posicionOrigen>=$l_posicionPromedioFinal)
				  //$0:=-1  // la posición de las columnas a partir del promedfio final no puede ser modificada
				  //ABC187928 05/09/2017
				DRAG AND DROP PROPERTIES:C607($y_origen;$l_posicionOrigen;$l_proceso)
				$l_posicionDestino:=Drop position:C608
				If ($l_posicionDestino#-1)
					$t_asignatura:=atActas_Subsectores{$l_posicionOrigen}
					DELETE FROM ARRAY:C228(atActas_Subsectores;$l_posicionOrigen)
					DELETE FROM ARRAY:C228(alActas_ColumnNumber;$l_posicionOrigen)
					INSERT IN ARRAY:C227(atActas_Subsectores;$l_posicionDestino)
					INSERT IN ARRAY:C227(alActas_ColumnNumber;$l_posicionDestino)
					atActas_Subsectores{$l_posicionDestino}:=$t_asignatura
					
					For ($i;1;Size of array:C274(alActas_ColumnNumber))
						alActas_ColumnNumber{$i}:=$i
					End for 
				End if 
			Else 
				
				If ($l_posicionOrigen#-1)
					DRAG AND DROP PROPERTIES:C607($y_origen;$l_posicionOrigen;$l_proceso)
					$l_posicionDestino:=Drop position:C608
					If ($l_posicionDestino#-1)
						$t_asignatura:=atActas_Subsectores{$l_posicionOrigen}
						DELETE FROM ARRAY:C228(atActas_Subsectores;$l_posicionOrigen)
						DELETE FROM ARRAY:C228(alActas_ColumnNumber;$l_posicionOrigen)
						INSERT IN ARRAY:C227(atActas_Subsectores;$l_posicionDestino)
						INSERT IN ARRAY:C227(alActas_ColumnNumber;$l_posicionDestino)
						atActas_Subsectores{$l_posicionDestino}:=$t_asignatura
						
						For ($i;1;Size of array:C274(alActas_ColumnNumber))
							alActas_ColumnNumber{$i}:=$i
						End for 
					End if 
					
				End if 
		End case 
		ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)  //ABC187928
		ACTAS_EstiloFilasConfiguracion 
End case 

