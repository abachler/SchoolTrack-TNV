Case of 
	: (Form event:C388=On Load:K2:1)
		READ ONLY:C145([xxSTR_MetaReligionDef:165])
		READ ONLY:C145([xxSTR_MetaReligionValues:164])
		Case of 
			: (vTipo="ALU")
				QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=[Alumnos:2]Religion:9)
			: (vTipo="PER")
				QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=[Personas:7]Religión:9)
			: (vTipo="PRO")
				QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=[Profesores:4]Religion:73)
		End case 
		ARRAY TEXT:C222(aEfemeride;0)
		ARRAY LONGINT:C221(aIDEfemeride;0)
		ARRAY LONGINT:C221(aIndexEfemeride;0)
		ARRAY DATE:C224(aFechaEfemeride;0)
		ARRAY LONGINT:C221(aRecNums;0)
		SELECTION TO ARRAY:C260([xxSTR_MetaReligionDef:165]Efemeride:3;aEfemeride;[xxSTR_MetaReligionDef:165]ID:1;aIDEfemeride;[xxSTR_MetaReligionDef:165]Index:4;aIndexEfemeride)
		SORT ARRAY:C229(aIndexEfemeride;aIDEfemeride;aEfemeride;>)
		For ($i;1;Size of array:C274(aIDEfemeride))
			QUERY:C277([xxSTR_MetaReligionValues:164];[xxSTR_MetaReligionValues:164]ID_Efemeride:1=aIDEfemeride{$i};*)
			Case of 
				: (vTipo="ALU")
					QUERY:C277([xxSTR_MetaReligionValues:164]; & ;[xxSTR_MetaReligionValues:164]ID_Alumno:2=[Alumnos:2]numero:1)
				: (vTipo="PER")
					QUERY:C277([xxSTR_MetaReligionValues:164]; & ;[xxSTR_MetaReligionValues:164]ID_Persona:3=[Personas:7]No:1)
				: (vTipo="PRO")
					QUERY:C277([xxSTR_MetaReligionValues:164]; & ;[xxSTR_MetaReligionValues:164]ID_Profesor:4=[Profesores:4]Numero:1)
			End case 
			APPEND TO ARRAY:C911(aFechaEfemeride;[xxSTR_MetaReligionValues:164]Fecha:5)
			APPEND TO ARRAY:C911(aRecNums;Record number:C243([xxSTR_MetaReligionValues:164]))
		End for 
End case 