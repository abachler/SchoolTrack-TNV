Case of 
	: (alProEvt=1)
		
		$col:=AL_GetColumn (Self:C308->)
		$line:=AL_GetLine (Self:C308->)
		Case of 
			: ($col=1)
				GET PICTURE FROM LIBRARY:C565(24456;$pen)
				GET PICTURE FROM LIBRARY:C565(5381;$barredPen)
				GET PICTURE FROM LIBRARY:C565(30215;$pict)
				If (Picture size:C356(aRecordFieldKey{$line})>0)
					aRecordFieldKey{$line}:=aRecordFieldKey{$line}*0
					If (aRecordFieldModAtt{$line}=0)
						aRecordFieldModAtt{$line}:=1
						aRecordFieldModifiable{$line}:=$pen
					End if 
				Else 
					aRecordFieldKey{$line}:=$pict
					aRecordFieldModAtt{$line}:=0
					aRecordFieldModifiable{$line}:=$barredPen
				End if 
			: ($col=2)
				GET PICTURE FROM LIBRARY:C565(24456;$pen)
				GET PICTURE FROM LIBRARY:C565(5381;$barredPen)
				Case of 
					: (aRecordFieldModAtt{$line}=-1)
						BEEP:C151
					: ((aRecordFieldModAtt{$line}=0) & (Picture size:C356(aRecordFieldKey{$line})>0))
						BEEP:C151
					: (aRecordFieldModAtt{$line}=1)
						aRecordFieldModAtt{$line}:=0
						aRecordFieldModifiable{$line}:=$barredPen
					: (aRecordFieldModAtt{$line}=0)
						aRecordFieldModAtt{$line}:=1
						aRecordFieldModifiable{$line}:=$pen
				End case 
		End case 
		AL_UpdateArrays (xalP_FieldNames;-1)
	: (alProEvt=-5)
		AL_GetDrgArea (Self:C308->;$area;$process)
		AL_GetDrgSrcRow (Self:C308->;$sourceRow)
		AL_GetDrgDstRow ($area;$dstRow)
		If ($area#Self:C308->)
			aSourceDataName{$sourceRow}:=""
			aSourceDataElement{$sourceRow}:=0
		Else 
			aSourceDataName{$dstRow}:=aSourceDataName{$sourceRow}
			aSourceDataElement{$dstRow}:=aSourceDataElement{$sourceRow}
			aSourceDataName{$sourceRow}:=""
			aSourceDataElement{$sourceRow}:=0
			If (aRecordFieldNames{$dstRow}="Alumno:Curso@")
				CD_Dlog (0;__ ("Asegúrese que los datos a importar sólo contengan la letra del curso en este campo.\r\rEjemplo: \r\r'A' para 4° Medio A\r'D' para Octavo D\r\r(si hay sólo un curso puede dejarlo blanco)"))
			End if 
			If (aRecordFieldNames{$dstRow}="Alumno:Nivel...Numero@")
				CD_Dlog (0;__ ("Asegúrese que el número del nivel este expresado de la siguiente manera: \r\r-3 = Admisión\r-2 = Jardín Infantil\r-1 = Prekinder\r 0 = Kinder\r 1 a 12 = Primero básico a 4° Medio"))
			End if 
			If (aRecordFieldNames{$dstRow}="Alumno:Apoderado acad@")
				  //$msg:="El contenido de este campo determina cual de los padres es el apoderado "+"académico"+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado académico."+◊cr+"'P, F, Padre, Father, Père'"+" = El padre será considepoderado académico."
				  //$msg:=$msg+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado académico."+◊cr
				  //$msg:=$msg+"'P, F, Padre, Father, Père'"+" = El padre será considerado el apoderado académico."+◊cr
				CD_Dlog (0;__ ("El contenido de este campo determina cual de los padres es el apoderado académico\r\r'M, Madre, Mère, Mother' = La madre será considerada el apoderado académico.\r'P, F, Padre, Father, Père' = El padre será considerado el apoderado académico."))
			End if 
			If (aRecordFieldNames{$dstRow}="Alumno:Apoderado de cuen@")
				  //$msg:="El contenido de este campo determina cual de los padres es el apoderado "+"de cuentas"+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado de cuentas."+◊cr+"'P, F, Padre, Father, Père'"+" = El padre será conside apoderado cuentas."
				  //$msg:=$msg+◊cr+◊cr+"'M, Madre, Mère, Mother'"+" = La madre será considerada el apoderado de cuentas."+◊cr
				  //$msg:=$msg+"'P, F, Padre, Father, Père'"+" = El padre será considerado el apoderado cuentas."+◊cr
				CD_Dlog (0;__ ("El contenido de este campo determina cual de los padres es el apoderado de cuentas\r\r'M, Madre, Mère, Mother' = La madre será considerada el apoderado de cuentas.\r'P, F, Padre, Father, Père' = El padre será considerado el apoderado cuentas."))
			End if 
		End if 
		AL_UpdateArrays (xalP_FieldNames;-1)
End case 