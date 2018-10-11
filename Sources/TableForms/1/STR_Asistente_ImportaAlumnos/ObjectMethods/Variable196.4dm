Case of 
	: (alProEvt=-5)
		
		
		AL_GetDrgArea (Self:C308->;$area;$process)
		AL_GetDrgSrcRow (Self:C308->;$sourceRow)
		AL_GetDrgDstRow ($area;$dstRow)
		
		$4DObject:=aRecordFieldPointers{$dstRow}
		If (Not:C34(Is nil pointer:C315($4DObject)))
			$type:=Type:C295($4DObject->)
		Else 
			$type:=0
		End if 
		
		$text:=ST_GetWord (aRecordLine{$sourceRow};2;"]")
		
		If ($text#"")
			Case of 
				: ($type=Is boolean:K8:9)
					If (($text="1") | ($text="0") | ($text="Y") | ($text="N") | ($text="S") | ($text="Si") | ($text="No") | ($text="Yes") | ($text="Oui") | ($text="Non") | ($text="Verdadero") | ($text="Falso") | ($text="True") | ($text="False") | ($text="Vrai") | ($text="Faux") | ($text="V") | ($text="F"))
					Else 
						CD_Dlog (0;__ ("El dato a importar no parece estar en el formato correcto\rLos campos booleanos solo aceptan las expresiones siguientes\r1, 0, S, N, Y, V, F, Si, No, Yes, Oui, Non, Verdadero, Falso, True, False, Vrai, Faux"))
					End if 
				: (($type=Is text:K8:3) | ($type=Is string var:K8:2) | ($type=Is alpha field:K8:1))
					  //
				: ($type=Is date:K8:7)
					If (Date:C102($text)=!00-00-00!)
						CD_Dlog (0;__ ("El dato a importar no parece estar en el formato correcto\rLas fechas deben ser expresadas en formato 00/00/00 o 00/00/0000"))
					End if 
				: (($type=Is real:K8:4) | ($type=Is integer:K8:5) | ($type=Is longint:K8:6))
					If (Num:C11($text)=0)
						CD_Dlog (0;__ ("El dato a importar no parece estar en el formato correcto\rLos campos numéricos solo aceptan cifras"))
					End if 
				: ($type=Is time:K8:8)
					If (Time:C179($text)#?00:00:00?)
						CD_Dlog (0;__ ("El dato a importar no parece estar en el formato correcto\rLas horas deben ser expresadas en formato 00:00 o 00:00:0000"))
					End if 
			End case 
		End if 
		
		aSourceDataName{$dstRow}:=aRecordLine{$sourceRow}
		aSourceDataElement{$dstRow}:=aRecordLineElement{$sourceRow}
		RESOLVE POINTER:C394(aRecordFieldPointers{$dstRow};$varName;$table;$field)
		
		Case of 
			: (aRecordFieldPointers{$dstRow}=Field:C253(Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]curso:20)))
				CD_Dlog (0;__ ("Asegúrese que los datos a importar sólo contengan la letra del curso en este campo.\r\rEjemplo: \r\r'A' para 4° Medio A\r'D' para Octavo D\r\r(si hay sólo un curso puede dejarlo blanco)"))
				
			: (aRecordFieldPointers{$dstRow}=Field:C253(Table:C252(->[Alumnos:2]);Field:C253(->[Alumnos:2]nivel_numero:29)))
				$text:=""
				For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
					$text:=$text+"\r"+ST_CharsBefore (String:C10(<>al_NumeroNivelesActivos{$i});" ";6)+": "+<>at_NombreNivelesActivos{$i}
				End for 
				READ ONLY:C145([xxSTR_Niveles:6])
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNivelSistema:10=True:C214;*)
				QUERY:C277([xxSTR_Niveles:6]; & [xxSTR_Niveles:6]NoNivel:5#-1003)
				$TEXT:=$TEXT+Char:C90(Carriage return:K15:38)
				While (Not:C34(End selection:C36([xxSTR_Niveles:6])))
					$text:=$text+"\r"+ST_CharsBefore (String:C10([xxSTR_Niveles:6]NoNivel:5);" ";6)+": "+[xxSTR_Niveles:6]Nivel:1
					NEXT RECORD:C51([xxSTR_Niveles:6])
				End while 
				CD_Dlog (0;__ ("Asegúrese que el número del nivel este entre los siguientes valores: \r\r")+$text)
			: ($varName="vt_apoderadoAcadémico")
				  //$msg:="El contenido de este campo determina cual de los padres es el apoderado "+"académico"+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado académico."+◊cr+"'P, F, Padre, Father, Père'"+" = El padre será considepoderado académico."
				  //$msg:=$msg+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado académico."+◊cr
				  //$msg:=$msg+"'P, F, Padre, Father, Père'"+" = El padre será considerado el apoderado académico."+◊cr
				CD_Dlog (0;__ ("El contenido de este campo determina cual de los padres es el apoderado académico\r\r'M, Madre, Mère, Mother' = La madre será considerada el apoderado académico.\r'P, F, Padre, Father, Père' = El padre será considerado el apoderado académico."))
			: ($varName="vt_apoderadoCuentas")
				  //$msg:="El contenido de este campo determina cual de los padres es el apoderado "+"de cuentas"+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado de cuentas."+◊cr+"'P, F, Padre, Father, Père'"+" = El padre será conside apoderado cuentas."
				  //$msg:=$msg+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado de cuentas."+◊cr
				  //$msg:=$msg+"'P, F, Padre, Father, Père'"+" = El padre será considerado el apoderado cuentas."+◊cr
				CD_Dlog (0;__ ("El contenido de este campo determina cual de los padres es el apoderado de cuentas\r\r'M, Madre, Mère, Mother' = La madre será considerada el apoderado de cuentas.\r'P, F, Padre, Father, Père' = El padre será considerado el apoderado cuentas."))
		End case 
		
		AL_UpdateArrays (xalP_FieldNames;-1)
End case 