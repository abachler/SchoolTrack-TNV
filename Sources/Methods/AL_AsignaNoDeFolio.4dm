//%attributes = {}
  //AL_AsignaNoDeFolio


If (<>vtXS_CountryCode="co")
	QUERY:C277([Alumnos:2];[Alumnos:2]NumeroDeFolio:103#"")
	ARRAY TEXT:C222($aText;Records in selection:C76([Alumnos:2]))
	
	READ WRITE:C146([Alumnos:2])
	CREATE EMPTY SET:C140([Alumnos:2];"lockedSet")  //`just in case
	ARRAY TO SELECTION:C261($aText;[Alumnos:2]NumeroDeFolio:103)
	
	If (Records in set:C195("lockedSet")>0)
		  //BM_CreateRequest ("co-AsignaNumerosDeFolio")
		$result:=0
	Else 
		$result:=1
	End if 
	
	If ($result=1)
		START TRANSACTION:C239
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$nivel)
		
		$lastSection:=""
		$toGrade:=-999
		$fromGrade:=-2
		
		$executed:=True:C214
		
		  //$pID:=IT_UThermometer (1;0;"Asignando Nº de folio")
		While (Not:C34(End selection:C36([xxSTR_Niveles:6])))
			If (($lastSection#[xxSTR_Niveles:6]Sección:9) & ($lastSection#""))
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=$fromGrade;*)
				QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<[xxSTR_Niveles:6]NoNivel:5)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
				QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="En trámite";*)
				QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Promovido@")
				
				ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]apellidos_y_nombres:40;>)
				ARRAY LONGINT:C221($aRecNums;0)
				LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
				For ($i;1;Size of array:C274($aRecNums))
					READ WRITE:C146([Alumnos:2])
					GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
					If (Not:C34(Locked:C147([Alumnos:2])))
						[Alumnos:2]NumeroDeFolio:103:=String:C10($i;"0000")
						SAVE RECORD:C53([Alumnos:2])
					Else 
						$i:=Size of array:C274($aRecNums)+1
						LAST RECORD:C200([xxSTR_Niveles:6])
						$executed:=False:C215
					End if 
				End for 
				$fromGrade:=[xxSTR_Niveles:6]NoNivel:5
			End if 
			$lastSection:=[xxSTR_Niveles:6]Sección:9
			NEXT RECORD:C51([xxSTR_Niveles:6])
		End while 
		
		
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=$fromGrade;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<Nivel_Egresados)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
		QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="En trámite";*)
		QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Promovido@")
		
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]apellidos_y_nombres:40;>)
		ARRAY LONGINT:C221($aRecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums;"")
		For ($i;1;Size of array:C274($aRecNums))
			READ WRITE:C146([Alumnos:2])
			GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
			If (Not:C34(Locked:C147([Alumnos:2])))
				[Alumnos:2]NumeroDeFolio:103:=String:C10($i;"0000")
				SAVE RECORD:C53([Alumnos:2])
			Else 
				$i:=Size of array:C274($aRecNums)+1
				LAST RECORD:C200([xxSTR_Niveles:6])
				$executed:=False:C215
			End if 
		End for 
		
		If ($executed)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
		
		UNLOAD RECORD:C212([Alumnos:2])
		READ ONLY:C145([Alumnos:2])
	Else 
		$executed:=False:C215
	End if 
	
	  //If ($executed)
	  //VALIDATE TRANSACTION
	  //Else 
	  //CANCEL TRANSACTION
	  //End if 
	
	$0:=$executed
Else 
	$0:=True:C214
End if 
