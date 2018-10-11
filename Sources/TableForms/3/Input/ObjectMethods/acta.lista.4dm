  // [Cursos].Input.lb_acta()
  // Por: Alberto Bachler K.: 02-03-14, 09:37:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)



$l_posicionPromedioFinal:=Find in array:C230(atActas_Subsectores;"Promedio Final")


Case of 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_origen;$l_posicionOrigen;$l_proceso)
		$l_posicionDestino:=Drop position:C608
		
		Case of 
			: ($l_posicionDestino>=$l_posicionPromedioFinal)
				  // nada, la posición de las columnas a partir del promedfio final no puede ser modificada
			: ($l_posicionOrigen>=$l_posicionPromedioFinal)
				  // nada, la posición de las columnas a partir del promedfio final no puede ser modificada
				  //TICKET 187928ABC
				$t_asignatura:=atActas_Subsectores{$l_posicionOrigen}
				atActas_Subsectores{$l_posicionOrigen}:="*moved*"
				INSERT IN ARRAY:C227(atActas_Subsectores;$l_posicionDestino)
				INSERT IN ARRAY:C227(alActas_ColumnNumber;$l_posicionDestino)
				atActas_Subsectores{$l_posicionDestino}:=$t_asignatura
				
				$l_posicionOrigen:=Find in array:C230(atActas_Subsectores;"*moved*")
				DELETE FROM ARRAY:C228(atActas_Subsectores;$l_posicionOrigen)
				DELETE FROM ARRAY:C228(alActas_ColumnNumber;$l_posicionOrigen)
				
				For ($i;1;Size of array:C274(alActas_ColumnNumber))
					alActas_ColumnNumber{$i}:=$i
				End for 
				ACTAS_GuardaConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
				
			Else 
				
				
				If ($l_posicionDestino#-1)
					$t_asignatura:=atActas_Subsectores{$l_posicionOrigen}
					atActas_Subsectores{$l_posicionOrigen}:="*moved*"
					INSERT IN ARRAY:C227(atActas_Subsectores;$l_posicionDestino)
					INSERT IN ARRAY:C227(alActas_ColumnNumber;$l_posicionDestino)
					atActas_Subsectores{$l_posicionDestino}:=$t_asignatura
					
					$l_posicionOrigen:=Find in array:C230(atActas_Subsectores;"*moved*")
					DELETE FROM ARRAY:C228(atActas_Subsectores;$l_posicionOrigen)
					DELETE FROM ARRAY:C228(alActas_ColumnNumber;$l_posicionOrigen)
					
					For ($i;1;Size of array:C274(alActas_ColumnNumber))
						alActas_ColumnNumber{$i}:=$i
					End for 
					ACTAS_GuardaConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
					
					
				End if 
				
		End case 
		ACTAS_EstiloFilasConfiguracion 
End case 