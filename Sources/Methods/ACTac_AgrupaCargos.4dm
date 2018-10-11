//%attributes = {}
  //ACTac_AgrupaCargos

ARRAY TEXT:C222(atACT_GlosaImpAvisos;0)
ARRAY REAL:C219(arACT_MontosAvisos;0)
_O_ARRAY STRING:C218(2;asACT_AfectoAvisos;0)
ARRAY REAL:C219(arACT_MontosPagadosAvisos;0)
ARRAY REAL:C219(arACT_DesctosAviso;0)
ARRAY LONGINT:C221($aProcessedRefs;0)
ARRAY TEXT:C222($aProcessedGlosas;0)
  //20130626 RCH NF CANTIDAD
ARRAY LONGINT:C221(alACT_Cantidad;0)
  //ARRAY REAL(arACT_Cantidad;0)
ARRAY REAL:C219(arACT_Unitario;0)
ARRAY LONGINT:C221($alACT_MesCargo;0)
ARRAY TEXT:C222($atACT_MesCargo;0)
ARRAY TEXT:C222(atACT_RecNumsCargosAgr;0)
ARRAY TEXT:C222(atACT_AMonedaSimbolo;0)

  //20150912 RCH
ARRAY TEXT:C222($atACT_unidadCargo;0)
ARRAY REAL:C219($arACT_TasaIVA;0)

  //20151005
ARRAY REAL:C219($arACT_cantidadCargo;0)

  //20150727 RCH guardo datos que se podrian utilizar al imprimir dtenet
ARRAY TEXT:C222($atACTcat_Alumnos2;0)
ARRAY TEXT:C222($atACTcat_curso2;0)
ARRAY TEXT:C222($atACTcat_rut2;0)
ARRAY TEXT:C222($atACTcat_nivel2;0)
ARRAY TEXT:C222($atACT_yearMonth2;0)
ARRAY TEXT:C222($atACTcat_year2;0)
ARRAY TEXT:C222($atACTcat_mes2;0)

$vl_pref:=Num:C11(PREF_fGet (0;"ACTac_AgrupaCargo1";"1"))
  //$r_cantidad:=1

For ($i;1;Size of array:C274(alACT_CRefs))
	$Processed:=Find in array:C230($aProcessedRefs;alACT_CRefs{$i})
	If ($Processed=-1)
		
		  //  //20130813 RCH para manejar la cantidad
		  //KRL_GotoRecord (->[ACT_Cargos];alACT_RecNumsCargos{$i})
		  //$r_cantidad:=[ACT_Cargos]cantidad
		
		INSERT IN ARRAY:C227($aProcessedRefs;1;1)
		$aProcessedRefs{1}:=alACT_CRefs{$i}
		alACT_CRefs{0}:=alACT_CRefs{$i}
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->alACT_CRefs;"=";->$DA_Return)
		$aProcessedRefs{1}:=alACT_CRefs{$i}
		ARRAY REAL:C219($aDesctos;0)
		ARRAY LONGINT:C221($aPositions;0)
		$next:=Size of array:C274(atACT_GlosaImpAvisos)
		For ($j;1;Size of array:C274($DA_Return))
			$foundDescto:=Find in array:C230($aDesctos;arACT_CTotalDesctos{$DA_Return{$j}})
			If ($foundDescto=-1)
				AT_Initialize (->$alACT_MesCargo)
				INSERT IN ARRAY:C227($aPositions;Size of array:C274($aPositions)+1;1)
				$aPositions{Size of array:C274($aPositions)}:=$DA_Return{$j}
				INSERT IN ARRAY:C227($aDesctos;Size of array:C274($aDesctos)+1;1)
				$aDesctos{Size of array:C274($aDesctos)}:=arACT_CTotalDesctos{$DA_Return{$j}}
				AT_Insert (0;1;->atACT_GlosaImpAvisos;->arACT_MontosAvisos;->asACT_AfectoAvisos;->arACT_MontosPagadosAvisos;->arACT_Unitario;->arACT_DesctosAviso;->$atACT_MesCargo;->atACT_AMonedaSimbolo;->$arACT_cantidadCargo)
				atACT_GlosaImpAvisos{Size of array:C274(atACT_GlosaImpAvisos)}:=atACT_CGlosaImpresion{$DA_Return{$j}}
				arACT_MontosAvisos{Size of array:C274(arACT_MontosAvisos)}:=arACT_MontosAvisos{Size of array:C274(arACT_MontosAvisos)}+arACT_CMontoNeto{$DA_Return{$j}}
				asACT_AfectoAvisos{Size of array:C274(asACT_AfectoAvisos)}:=asACT_AfectoAvisos{Size of array:C274(asACT_AfectoAvisos)}+asACT_Afecto{$DA_Return{$j}}
				arACT_MontosPagadosAvisos{Size of array:C274(arACT_MontosPagadosAvisos)}:=arACT_MontosPagadosAvisos{Size of array:C274(arACT_MontosPagadosAvisos)}+arACT_MontoPagado{$DA_Return{$j}}
				  //arACT_Cantidad{Size of array(arACT_Cantidad)}:=arACT_Cantidad{Size of array(arACT_Cantidad)}+1
				$arACT_cantidadCargo{Size of array:C274($arACT_cantidadCargo)}:=$arACT_cantidadCargo{Size of array:C274($arACT_cantidadCargo)}+arACT_Cantidad{$DA_Return{$j}}
				arACT_Unitario{Size of array:C274(arACT_Unitario)}:=arACT_CMontoNeto{$DA_Return{$j}}
				arACT_DesctosAviso{Size of array:C274(arACT_DesctosAviso)}:=arACT_DesctosAviso{Size of array:C274(arACT_DesctosAviso)}+arACT_CTotalDesctos{$DA_Return{$j}}
				APPEND TO ARRAY:C911($alACT_MesCargo;alACT_MesCargo{$DA_Return{$j}})
				$atACT_MesCargo{Size of array:C274($atACT_MesCargo)}:=AT_array2text (->$alACT_MesCargo;"-";"##")
				atACT_AMonedaSimbolo{Size of array:C274(arACT_DesctosAviso)}:=atACT_MonedaSimbolo{$DA_Return{$j}}
				APPEND TO ARRAY:C911(atACT_RecNumsCargosAgr;String:C10(alACT_RecNumsCargosT{$DA_Return{$j}}))
				
				
				  //20150727 RCH guardo datos que se podrian utilizar al imprimir dtenet
				APPEND TO ARRAY:C911($atACTcat_Alumnos2;atACT_CAlumno{$DA_Return{$j}})
				APPEND TO ARRAY:C911($atACTcat_curso2;atACT_CAlumnoCurso{$DA_Return{$j}})
				APPEND TO ARRAY:C911($atACTcat_rut2;atACT_CAlumnoRUT{$DA_Return{$j}})
				APPEND TO ARRAY:C911($atACTcat_nivel2;atACT_CAlumnoNivelNombre{$DA_Return{$j}})
				
				$t_yearMonth:=atACT_AñoCargo{$DA_Return{$j}}+<>atXS_MonthNames{alACT_MesCargo{$DA_Return{$j}}}
				APPEND TO ARRAY:C911($atACT_yearMonth2;$t_yearMonth)
				
				APPEND TO ARRAY:C911($atACTcat_year2;atACT_AñoCargo{$DA_Return{$j}})
				APPEND TO ARRAY:C911($atACTcat_mes2;<>atXS_MonthNames{alACT_MesCargo{$DA_Return{$j}}})
				
				  //20150912 RCH 
				APPEND TO ARRAY:C911($atACT_unidadCargo;atACT_unidadCargo{$DA_Return{$j}})
				APPEND TO ARRAY:C911($arACT_TasaIVA;arACT_TasaIVA{$DA_Return{$j}})
				
			Else 
				$found:=False:C215
				If (arACT_CTotalDesctos{$DA_Return{$j}}#0)
					For ($xx;1;Size of array:C274($aPositions))
						If (arACT_CMontoNeto{$aPositions{$xx}}=arACT_CMontoNeto{$DA_Return{$j}})
							$found:=True:C214
							$xx:=Size of array:C274($aPositions)+1
						End if 
					End for 
				Else 
					For ($xx;1;Size of array:C274($aPositions))
						If (atACT_CGlosaImpresion{$aPositions{$xx}}=atACT_CGlosaImpresion{$DA_Return{$j}})
							$found:=True:C214
							$xx:=Size of array:C274($aPositions)+1
						End if 
					End for 
				End if 
				If ($found)
					arACT_MontosAvisos{$next+$foundDescto}:=arACT_MontosAvisos{$next+$foundDescto}+arACT_CMontoNeto{$DA_Return{$j}}
					arACT_MontosPagadosAvisos{$next+$foundDescto}:=arACT_MontosPagadosAvisos{$next+$foundDescto}+arACT_MontoPagado{$DA_Return{$j}}
					  //arACT_Cantidad{$next+$foundDescto}:=arACT_Cantidad{$next+$foundDescto}+1
					$arACT_cantidadCargo{$next+$foundDescto}:=$arACT_cantidadCargo{$next+$foundDescto}+arACT_Cantidad{$DA_Return{$j}}
					arACT_DesctosAviso{$next+$foundDescto}:=arACT_DesctosAviso{$next+$foundDescto}+arACT_CTotalDesctos{$DA_Return{$j}}
					APPEND TO ARRAY:C911($alACT_MesCargo;alACT_MesCargo{$DA_Return{$j}})
					$atACT_MesCargo{$next+$foundDescto}:=AT_array2text (->$alACT_MesCargo;"-";"##")
					
					atACT_RecNumsCargosAgr{$next+$foundDescto}:=atACT_RecNumsCargosAgr{$next+$foundDescto}+ST_Boolean2Str (atACT_RecNumsCargosAgr{$next+$foundDescto}="";"";";")+String:C10(alACT_RecNumsCargosT{$DA_Return{$j}})
					
					
					  //20150727 RCH guardo datos que se podrian utilizar al imprimir dtenet
					If (Position:C15(atACT_CAlumno{$DA_Return{$j}};$atACTcat_Alumnos2{$next+$foundDescto})=0)
						$atACTcat_Alumnos2{$next+$foundDescto}:=Choose:C955($atACTcat_Alumnos2{$next+$foundDescto}="";"";$atACTcat_Alumnos2{$next+$foundDescto}+",")+atACT_CAlumno{$DA_Return{$j}}
						$atACTcat_curso2{$next+$foundDescto}:=Choose:C955($atACTcat_curso2{$next+$foundDescto}="";"";$atACTcat_curso2{$next+$foundDescto}+",")+atACT_CAlumnoCurso{$DA_Return{$j}}
						$atACTcat_rut2{$next+$foundDescto}:=Choose:C955($atACTcat_rut2{$next+$foundDescto}="";"";$atACTcat_rut2{$next+$foundDescto}+",")+atACT_CAlumnoRUT{$DA_Return{$j}}
						$atACTcat_nivel2{$next+$foundDescto}:=Choose:C955($atACTcat_nivel2{$next+$foundDescto}="";"";$atACTcat_nivel2{$next+$foundDescto}+",")+atACT_CAlumnoNivelNombre{$DA_Return{$j}}
					End if 
					
					$t_yearMonth:=atACT_AñoCargo{$DA_Return{$j}}+<>atXS_MonthNames{alACT_MesCargo{$DA_Return{$j}}}
					If (Position:C15($t_yearMonth;$atACT_yearMonth2{$next+$foundDescto})=0)
						  //$atACT_yearMonth2{$next+$foundDescto}:=Choose($atACT_yearMonth2{$next+$foundDescto}="";"";"-")+$t_yearMonth
						$atACT_yearMonth2{$next+$foundDescto}:=Choose:C955($atACT_yearMonth2{$next+$foundDescto}="";"";$atACT_yearMonth2{$next+$foundDescto}+"-")+$t_yearMonth  //20170527 RCH. No se detectaban correctamente los meses únicos
						
						$atACTcat_year2{$next+$foundDescto}:=Choose:C955($atACTcat_year2{$next+$foundDescto}="";"";$atACTcat_year2{$next+$foundDescto}+",")+atACT_AñoCargo{$DA_Return{$j}}
						$atACTcat_mes2{$next+$foundDescto}:=Choose:C955($atACTcat_mes2{$next+$foundDescto}="";"";$atACTcat_mes2{$next+$foundDescto}+",")+<>atXS_MonthNames{alACT_MesCargo{$DA_Return{$j}}}
					End if 
					
					  //20150912 RCH 
					$atACT_unidadCargo{$next+$foundDescto}:=atACT_unidadCargo{$DA_Return{$j}}
					$arACT_TasaIVA{$next+$foundDescto}:=arACT_TasaIVA{$DA_Return{$j}}
					
				Else 
					AT_Initialize (->$alACT_MesCargo)
					INSERT IN ARRAY:C227($aDesctos;Size of array:C274($aDesctos)+1;1)
					INSERT IN ARRAY:C227($aPositions;Size of array:C274($aPositions)+1;1)
					$aDesctos{Size of array:C274($aDesctos)}:=arACT_CTotalDesctos{$DA_Return{$j}}
					$aPositions{Size of array:C274($aPositions)}:=$DA_Return{$j}
					AT_Insert (0;1;->atACT_GlosaImpAvisos;->arACT_MontosAvisos;->asACT_AfectoAvisos;->arACT_MontosPagadosAvisos;->arACT_Unitario;->$atACT_MesCargo;->arACT_DesctosAviso;->atACT_AMonedaSimbolo;->$arACT_cantidadCargo)
					atACT_GlosaImpAvisos{Size of array:C274(atACT_GlosaImpAvisos)}:=atACT_CGlosaImpresion{$DA_Return{$j}}
					arACT_MontosAvisos{Size of array:C274(arACT_MontosAvisos)}:=arACT_MontosAvisos{Size of array:C274(arACT_MontosAvisos)}+arACT_CMontoNeto{$DA_Return{$j}}
					asACT_AfectoAvisos{Size of array:C274(asACT_AfectoAvisos)}:=asACT_AfectoAvisos{Size of array:C274(asACT_AfectoAvisos)}+asACT_Afecto{$DA_Return{$j}}
					arACT_MontosPagadosAvisos{Size of array:C274(arACT_MontosPagadosAvisos)}:=arACT_MontosPagadosAvisos{Size of array:C274(arACT_MontosPagadosAvisos)}+arACT_MontoPagado{$DA_Return{$j}}
					  //arACT_Cantidad{Size of array(arACT_Cantidad)}:=arACT_Cantidad{Size of array(arACT_Cantidad)}+1
					$arACT_cantidadCargo{Size of array:C274($arACT_cantidadCargo)}:=$arACT_cantidadCargo{Size of array:C274($arACT_cantidadCargo)}+arACT_Cantidad{$DA_Return{$j}}
					arACT_Unitario{Size of array:C274(arACT_Unitario)}:=arACT_CMontoNeto{$DA_Return{$j}}
					arACT_DesctosAviso{Size of array:C274(arACT_DesctosAviso)}:=arACT_DesctosAviso{Size of array:C274(arACT_DesctosAviso)}+arACT_CTotalDesctos{$DA_Return{$j}}
					APPEND TO ARRAY:C911($alACT_MesCargo;alACT_MesCargo{$DA_Return{$j}})
					$atACT_MesCargo{Size of array:C274($atACT_MesCargo)}:=AT_array2text (->$alACT_MesCargo;"-";"##")
					
					APPEND TO ARRAY:C911(atACT_RecNumsCargosAgr;atACT_RecNumsCargosAgr{$next+$foundDescto}+ST_Boolean2Str (atACT_RecNumsCargosAgr{$next+$foundDescto}="";"";";")+String:C10(alACT_RecNumsCargosT{$DA_Return{$j}}))
					
					atACT_AMonedaSimbolo{Size of array:C274(arACT_DesctosAviso)}:=atACT_MonedaSimbolo{$DA_Return{$j}}
					
					
					  //20150727 RCH guardo datos que se podrian utilizar al imprimir dtenet
					APPEND TO ARRAY:C911($atACTcat_Alumnos2;atACT_CAlumno{$DA_Return{$j}})
					APPEND TO ARRAY:C911($atACTcat_curso2;atACT_CAlumnoCurso{$DA_Return{$j}})
					APPEND TO ARRAY:C911($atACTcat_rut2;atACT_CAlumnoRUT{$DA_Return{$j}})
					APPEND TO ARRAY:C911($atACTcat_nivel2;atACT_CAlumnoNivelNombre{$DA_Return{$j}})
					
					
					$t_yearMonth:=atACT_AñoCargo{$DA_Return{$j}}+<>atXS_MonthNames{alACT_MesCargo{$DA_Return{$j}}}
					APPEND TO ARRAY:C911($atACT_yearMonth2;$t_yearMonth)
					
					APPEND TO ARRAY:C911($atACTcat_year2;atACT_AñoCargo{$DA_Return{$j}})
					APPEND TO ARRAY:C911($atACTcat_mes2;<>atXS_MonthNames{alACT_MesCargo{$DA_Return{$j}}})
					
					  //20150912 RCH 
					APPEND TO ARRAY:C911($atACT_unidadCargo;atACT_unidadCargo{$DA_Return{$j}})
					APPEND TO ARRAY:C911($arACT_TasaIVA;arACT_TasaIVA{$DA_Return{$j}})
					
					  //20091229 momentáneamente se deja esta nueva línea dentro de una preferencia por si en algún caso esto provoca error. Si no se producen errores se quitará.
					If ($vl_pref=1)
						  //$next:=$next+1 ASM 20170810 Ticket 186592 provocaba que se produjera un error de largo de arreglo. (si produce problema descomentar.)
					End if 
					
				End if 
			End if 
		End for 
	End if 
End for 
For ($i;1;Size of array:C274($atACT_MesCargo))
	AT_Initialize (->$alACT_MesCargo)
	AT_Text2Array (->$alACT_MesCargo;$atACT_MesCargo{$i};"-")
	AT_DistinctsArrayValues (->$alACT_MesCargo)
	SORT ARRAY:C229($alACT_MesCargo;>)
	$atACT_MesCargo{$i}:=SRACT_AgrupaMeses (->$alACT_MesCargo;1)
End for 
  //20130405 RCH El monto moneda no estaba siendo bien llenado
  //AT_Initialize (->atACT_CGlosaImpresion;->arACT_CMontoNeto;->asACT_Afecto;->arACT_MontoPagado;->arACT_CTotalDesctos;->atACT_MesCargo)
  //AT_Initialize (->atACT_CGlosaImpresion;->arACT_CMontoNeto;->asACT_Afecto;->arACT_MontoPagado;->arACT_CTotalDesctos;->atACT_MesCargo;->atACT_MonedaSimbolo)
AT_Initialize (->atACT_CGlosaImpresion;->arACT_CMontoNeto;->asACT_Afecto;->arACT_MontoPagado;->arACT_CTotalDesctos;->atACT_MesCargo;->atACT_MonedaSimbolo;->arACT_Cantidad)
COPY ARRAY:C226(atACT_GlosaImpAvisos;atACT_CGlosaImpresion)
COPY ARRAY:C226(arACT_MontosAvisos;arACT_CMontoNeto)
COPY ARRAY:C226(asACT_AfectoAvisos;asACT_Afecto)
COPY ARRAY:C226(arACT_MontosPagadosAvisos;arACT_MontoPagado)
COPY ARRAY:C226(arACT_DesctosAviso;arACT_CTotalDesctos)
COPY ARRAY:C226($atACT_MesCargo;atACT_MesCargo)
  //20130405 RCH El monto moneda no estaba siendo bien llenado
COPY ARRAY:C226(atACT_AMonedaSimbolo;atACT_MonedaSimbolo)

COPY ARRAY:C226($arACT_cantidadCargo;arACT_Cantidad)

  //
  //AT_Initialize (->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoRUT;->atACT_CAlumnoNivelNombre;->atACT_AñoCargo;->atACT_MesCargo)
AT_Initialize (->atACT_CAlumno;->atACT_CAlumnoCurso;->atACT_CAlumnoRUT;->atACT_CAlumnoNivelNombre;->atACT_AñoCargo;->atACT_MesCargo;->atACT_unidadCargo;->arACT_TasaIVA)
COPY ARRAY:C226($atACTcat_Alumnos2;atACT_CAlumno)
COPY ARRAY:C226($atACTcat_curso2;atACT_CAlumnoCurso)
COPY ARRAY:C226($atACTcat_rut2;atACT_CAlumnoRUT)
COPY ARRAY:C226($atACTcat_nivel2;atACT_CAlumnoNivelNombre)
COPY ARRAY:C226($atACTcat_year2;atACT_AñoCargo)
COPY ARRAY:C226($atACTcat_mes2;atACT_MesCargo)

  //20150912 RCH 
COPY ARRAY:C226($atACT_unidadCargo;atACT_unidadCargo)
COPY ARRAY:C226($arACT_TasaIVA;arACT_TasaIVA)

AT_Initialize (->alACT_RecNumsCargosT)