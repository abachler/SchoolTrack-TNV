//%attributes = {}
  //ACTcc_OrderCtasCtes

C_POINTER:C301($fieldPtr)
C_LONGINT:C283($existe)
C_BLOB:C604(xBlob)
C_BOOLEAN:C305($0)
C_BOOLEAN:C305(<>ACT_OrdenandoCtas)
<>ACT_OrdenandoCtas:=True:C214

  // 20110819 RCH Se cambia llamado para optimizar tiempo de respuesta para no cargar innecesariamente otras variables...
  //ACTcfg_LoadConfigData (1)

If (ACT_AccountTrackInicializado )
	
	ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
	ACTcfgdes_OpcionesGenerales ("LeeBlob")
	If (Count parameters:C259=1)
		$idCta:=$1
	Else 
		$idCta:=0
	End if 
	
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	
	$0:=True:C214
	
	Case of 
		: (gGroupByFamily=1)
			$fieldPtr:=->[ACT_CuentasCorrientes:175]ID_Familia:2
		: (gGroupByGardian=1)
			$fieldPtr:=->[ACT_CuentasCorrientes:175]ID_Apoderado:9
		Else 
			$fieldPtr:=->[ACT_CuentasCorrientes:175]ID_Familia:2
	End case 
	
	ARRAY LONGINT:C221(aLong1;0)
	If ($idCta=0)
		ALL RECORDS:C47([ACT_CuentasCorrientes:175])
	Else 
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$idCta)
	End if 
	AT_DistinctsFieldValues ($fieldPtr;->aLong1)
	For ($i;Size of array:C274(aLong1);1;-1)
		If (aLong1{$i}=0)
			DELETE FROM ARRAY:C228(aLong1;$i;1)
		End if 
	End for 
	If ($idCta=0)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando número de carga..."))
	End if 
	For ($i;1;Size of array:C274(aLong1))
		QUERY:C277([ACT_CuentasCorrientes:175];$fieldPtr->=aLong1{$i})
		Case of 
			: ((nOrdenAscendiente=1) & (oOrderByClass=1))
				ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]Fecha_de_nacimiento:7;>;[Alumnos:2]apellidos_y_nombres:40;>)
			: ((nOrdenAscendiente=1) & (oOrderbyBirthDate=1))
				ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]Fecha_de_nacimiento:7;<;[Alumnos:2]nivel_numero:29;>;[Alumnos:2]apellidos_y_nombres:40;>)
			: ((nOrdenDescendiente=1) & (oOrderbyBirthDate=1))
				ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]Fecha_de_nacimiento:7;>;[Alumnos:2]nivel_numero:29;>;[Alumnos:2]apellidos_y_nombres:40;>)
			: ((nOrdenDescendiente=1) & (oOrderbyClass=1))
				ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]Fecha_de_nacimiento:7;>;[Alumnos:2]apellidos_y_nombres:40;>)
		End case 
		SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];$aRecNums)
		$rango:=0
		For ($recnumIndex;1;Size of array:C274($aRecNums))
			KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$aRecNums{$recNumIndex};True:C214)
			If (ok=1)
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				If ([Alumnos:2]nivel_numero:29<Nivel_Egresados)
					$existe:=Find in array:C230(ai_nivelesConsideradoNoHijo;[Alumnos:2]nivel_numero:29)
					If ($existe#-1)
						If ([ACT_CuentasCorrientes:175]Estado:4=True:C214)
							$rango:=$rango+1
							[ACT_CuentasCorrientes:175]Numero_Hijo:10:=$rango
						Else 
							[ACT_CuentasCorrientes:175]Numero_Hijo:10:=0
						End if 
					Else 
						[ACT_CuentasCorrientes:175]Numero_Hijo:10:=0
					End if 
				Else 
					[ACT_CuentasCorrientes:175]Numero_Hijo:10:=0
				End if 
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
			Else 
				$0:=False:C215
			End if 
			KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
		End for 
		If ($idCta=0)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aLong1);__ ("Asignando número de carga..."))
		End if 
		
	End for 
	If ($idCta=0)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	KRL_UnloadReadOnly (->[Alumnos:2])
Else 
	$0:=True:C214
End if 
<>ACT_OrdenandoCtas:=False:C215
ACTcfgdes_OpcionesGenerales ("DeclaraArraysPref")