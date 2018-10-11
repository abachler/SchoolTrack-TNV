//%attributes = {}
  //IOstr_linkStudentToFamily
C_LONGINT:C283($lpos)

If (Count parameters:C259=1)
	$recNum:=$1
Else 
	$recNum:=-1
End if 

If ($recNum>=0)
	GOTO RECORD:C242([Familia:78];$recNum)
Else 
	$familyName:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
	QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=$familyName)
	Case of 
		: (Records in selection:C76([Familia:78])=0)
			CREATE RECORD:C68([Familia:78])
			[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
			[Familia:78]Nombre_de_la_familia:3:=$familyName
			[Familia:78]Dirección:7:=[Alumnos:2]Direccion:12
			[Familia:78]Ciudad:9:=[Alumnos:2]Ciudad:15
			[Familia:78]Codigo_postal:19:=[Alumnos:2]Codigo_Postal:13
			[Familia:78]Comuna:8:=[Alumnos:2]Comuna:14
			[Familia:78]Telefono:10:=[Alumnos:2]Telefono:17
			[Familia:78]Numero_de_Alumnos:2:=1
			If (Find in array:C230(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)=-1)
				APPEND TO ARRAY:C911(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)  //20171122 RCH
			End if 
			
		: (Records in selection:C76([Familia:78])=1)
			[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2+1
			$logText:="Se actualizó el registro de la familia "+[Familia:78]Nombre_de_la_familia:3+"\r"
			SEND PACKET:C103(vH_logRef;$logText)
			APPEND TO ARRAY:C911(atIOstr_UUIDFamiliasA;[Familia:78]Auto_UUID:23)  //20171122 RCH
		: (Records in selection:C76([Familia:78])>1)
			QUERY SELECTION:C341([Familia:78];[Familia:78]Dirección:7=[Alumnos:2]Direccion:12)
			If (Records in selection:C76([Familia:78])=0)
				CREATE RECORD:C68([Familia:78])
				[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
				[Familia:78]Nombre_de_la_familia:3:=$familyName
				[Familia:78]Dirección:7:=[Alumnos:2]Direccion:12
				[Familia:78]Ciudad:9:=[Alumnos:2]Ciudad:15
				[Familia:78]Codigo_postal:19:=[Alumnos:2]Codigo_Postal:13
				[Familia:78]Comuna:8:=[Alumnos:2]Comuna:14
				[Familia:78]Telefono:10:=[Alumnos:2]Telefono:17
				[Familia:78]Numero_de_Alumnos:2:=1
				If (Find in array:C230(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)=-1)
					APPEND TO ARRAY:C911(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)  //20171122 RCH
				End if 
			Else 
				[Familia:78]Numero_de_Alumnos:2:=[Familia:78]Numero_de_Alumnos:2+1
				$logText:="Se actualizó el registro de la familia "+[Familia:78]Nombre_de_la_familia:3+"\r"
				SEND PACKET:C103(vH_logRef;$logText)
				
				If ((Find in array:C230(atIOstr_UUIDFamiliasN;[Familia:78]Auto_UUID:23)=-1) & (Find in array:C230(atIOstr_UUIDFamiliasA;[Familia:78]Auto_UUID:23)=-1))
					APPEND TO ARRAY:C911(atIOstr_UUIDFamiliasA;[Familia:78]Auto_UUID:23)  //20171122 RCH
				End if 
				
			End if 
	End case 
End if 
If (vl_MotherRecNum>=0)
	GOTO RECORD:C242([Personas:7];vl_MotherRecNum)
	[Familia:78]Madre_Número:6:=[Personas:7]No:1
	[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
	QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
	If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
		CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
		[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
		[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Madre_Número:6
	End if 
	[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
	[Familia_RelacionesFamiliares:77]Parentesco:6:="Madre"
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
End if 
If (vl_FatherRecNum>=0)
	GOTO RECORD:C242([Personas:7];vl_fatherRecNum)
	[Familia:78]Padre_Número:5:=[Personas:7]No:1
	[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
	QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
	If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
		CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
		[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
		[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Padre_Número:5
	End if 
	[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
	[Familia_RelacionesFamiliares:77]Parentesco:6:="Padre"
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
End if 
If (vl_apAcademicoRecNum>=0)
	GOTO RECORD:C242([Personas:7];vl_apAcademicoRecNum)
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
	QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
	If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
		CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
		[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
		[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
		
		$lpos:=Find in array:C230(<>aParentesco;vt_ParentescoApAcademico)  //monofix
		If ($lpos>0)
			[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=$lpos
			[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{$lpos}
		Else 
			[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=11  //id en la lista de parentesco de Otros
			[Familia_RelacionesFamiliares:77]Parentesco:6:=vt_ParentescoApAcademico
		End if 
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
	End if 
End if 
If (vl_apCuentasRecNum>=0)
	GOTO RECORD:C242([Personas:7];vl_apCuentasRecNum)
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
	QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
	If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
		CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
		[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
		[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
		$lpos:=Find in array:C230(<>aParentesco;vt_ParentescoApCuentas)  //monofix
		If ($lpos>0)
			[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=$lpos
			[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{$lpos}
		Else 
			[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=11  //id en la lista de parentesco de Otros
			[Familia_RelacionesFamiliares:77]Parentesco:6:=vt_ParentescoApCuentas
		End if 
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
	End if 
End if 
SAVE RECORD:C53([Familia:78])
vl_FamilyRecNum:=Record number:C243([Familia:78])
