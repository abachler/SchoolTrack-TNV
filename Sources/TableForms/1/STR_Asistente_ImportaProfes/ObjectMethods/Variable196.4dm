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
		
		$text:=ST_GetWord (aRecordLine{$sourceRow};2;":")
		
		
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
		
		If (aRecordFieldNames{$dstRow}="Alumno:Curso@")
			CD_Dlog (0;__ ("Asegúrese que los datos a importar sólo contengan la letra del curso en este campo.\r\rEjemplo: \r\r'A' para 4° Medio A\r'D' para Octavo D\r\r(si hay sólo un curso puede dejarlo blanco)"))
		End if 
		If (aRecordFieldNames{$dstRow}="Alumno:Nivel...Numero@")
			CD_Dlog (0;__ ("Asegúrese que el número del nivel este expresado de la siguiente manera: \r\r-2 = Jardín Infantil\r-1 = Prekinder\r 0 = Kinder\r 1 a 12 = Primero básico a 4° Medio"))
		End if 
		If (aRecordFieldNames{$dstRow}="Alumno:Apoderado acad@")
			  //$msg:="El contenido de este campo determina cual de los padres es el apoderado "+"académico"+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado académico."+◊cr+ "'P, F, Padre, Father, Père'"+" = El padre será considapoderado académico."
			  //$msg:=$msg+◊cr+◊cr+ "'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado académico."+◊cr
			  //$msg:=$msg+ "'P, F, Padre, Father, Père'"+" = El padre será considerado el apoderado académico."+◊cr
			CD_Dlog (0;__ ("El contenido de este campo determina cual de los padres es el apoderado académico\r\r'M, Madre, Mère, Mother' = La madre será considerada el apoderado académico.\r'P, F, Padre, Father, Père' = El padre será considerado el apoderado académico."))
		End if 
		If (aRecordFieldNames{$dstRow}="Alumno:Apoderado de cuen@")
			  //$msg:="El contenido de este campo determina cual de los padres es el apoderado "+"de cuentas"+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado de cuentas."+◊cr+ "'P, F, Padre, Father, Père'"+" = El padre será considl apoderado cuentas."
			  //$msg:=$msg+◊cr+◊cr+ "'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado de cuentas."+◊cr
			  //$msg:=$msg+ "'P, F, Padre, Father, Père'"+" = El padre será considerado el apoderado cuentas."+◊cr
			CD_Dlog (0;__ ("El contenido de este campo determina cual de los padres es el apoderado de cuentas\r\r'M, Madre, Mère, Mother' = La madre será considerada el apoderado de cuentas.\r'P, F, Padre, Father, Père' = El padre será considerado el apoderado cuentas."))
		End if 
		
		AL_UpdateArrays (xalP_FieldNames;-1)
End case 