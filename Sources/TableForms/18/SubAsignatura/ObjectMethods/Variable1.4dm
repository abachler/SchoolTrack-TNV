  //Modificado por AS el 12-08-2010 13:43

$columna:=vRow
ARRAY TEXT:C222($name;0)
SELECTION TO ARRAY:C260([xxSTR_Subasignaturas:83]Name:2;$name)

For ($j;1;Size of array:C274($name))
	$name{$j}:=ST_CleanString ($name{$j})
End for 

vs_SubAsig:=ST_CleanString (vs_SubAsig)
$el:=Find in array:C230($name;vs_SubAsig)

If ($el<0)
	If (vs_SubAsig#"")
		If (r1=1)
			For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
				CREATE RECORD:C68([xxSTR_Subasignaturas:83])
				[xxSTR_Subasignaturas:83]LongID:7:=SQ_SeqNumber (->[xxSTR_Subasignaturas:83]LongID:7;True:C214)
				[xxSTR_Subasignaturas:83]Name:2:=vs_SubAsig
				[xxSTR_Subasignaturas:83]ID_SubAsignatura:1:=String:C10([xxSTR_Subasignaturas:83]LongID:7)+"/"+String:C10($i)
				[xxSTR_Subasignaturas:83]ID_Mother:6:=lConsID
				[xxSTR_Subasignaturas:83]Periodo:12:=$i
				[xxSTR_Subasignaturas:83]Columna:13:=$columna
				SAVE RECORD:C53([xxSTR_Subasignaturas:83])
			End for 
		Else 
			CREATE RECORD:C68([xxSTR_Subasignaturas:83])
			[xxSTR_Subasignaturas:83]LongID:7:=SQ_SeqNumber (->[xxSTR_Subasignaturas:83]LongID:7;True:C214)
			[xxSTR_Subasignaturas:83]Name:2:=vs_SubAsig
			[xxSTR_Subasignaturas:83]ID_Mother:6:=lConsID
			[xxSTR_Subasignaturas:83]ID_SubAsignatura:1:=String:C10([xxSTR_Subasignaturas:83]LongID:7)+"/"+String:C10(atSTR_Periodos_Nombre)
			[xxSTR_Subasignaturas:83]Periodo:12:=atSTR_Periodos_Nombre
			[xxSTR_Subasignaturas:83]Columna:13:=$columna
			SAVE RECORD:C53([xxSTR_Subasignaturas:83])
		End if 
		ACCEPT:C269
	End if 
Else 
	CD_Dlog (0;__ ("La Sub-asignatura que intenta crear ya existe, Intente crearla con otro nombre"))
End if 