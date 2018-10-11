//%attributes = {}
  //dbu_SeparaTelefonosCelulares

C_LONGINT:C283($i;$j;$k)
C_TEXT:C284($separador;$phones;$phone)

$separador:=CD_Request (__ ("Separador utilizado en números telefónicos:");__ ("OK");__ ("Cancelar");__ ("");__ ("/"))


ALL RECORDS:C47([Alumnos:2])
ARRAY LONGINT:C221(aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Separando celulares..."))
For ($i;1;Size of array:C274(aRecNums))
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];aRecNums{$i})
	[Alumnos:2]Telefono:17:=Replace string:C233([Alumnos:2]Telefono:17;" ";"")
	$phones:=[Alumnos:2]Telefono:17
	For ($k;1;ST_CountWords ($phones;0;$separador))
		$phone:=ST_GetWord ($phones;$k;$separador)
		If ((($phone="08@") | ($phone="09@") | ($phone="(08@") | ($phone="(09@")) & ((Old:C35([Alumnos:2]Celular:95)="") & (Length:C16($phone)>=9)))
			[Alumnos:2]Celular:95:=[Alumnos:2]Celular:95+$phone+$separador
			[Alumnos:2]Telefono:17:=Replace string:C233([Alumnos:2]Telefono:17;$separador+$phone;"")
			[Alumnos:2]Telefono:17:=Replace string:C233([Alumnos:2]Telefono:17;$phone+$separador;"")
			[Alumnos:2]Telefono:17:=Replace string:C233([Alumnos:2]Telefono:17;$phone;"")
		End if 
	End for 
	[Alumnos:2]Telefono:17:=Replace string:C233([Alumnos:2]Telefono:17;$separador+$separador;$separador)
	If ([Alumnos:2]Telefono:17[[Length:C16([Alumnos:2]Telefono:17)]]=$separador)
		[Alumnos:2]Telefono:17:=Substring:C12([Alumnos:2]Telefono:17;1;Length:C16([Alumnos:2]Telefono:17)-1)
	End if 
	[Alumnos:2]Celular:95:=Replace string:C233([Alumnos:2]Celular:95;$separador+$separador;$separador)
	If ([Alumnos:2]Celular:95[[Length:C16([Alumnos:2]Celular:95)]]=$separador)
		[Alumnos:2]Celular:95:=Substring:C12([Alumnos:2]Celular:95;1;Length:C16([Alumnos:2]Celular:95)-1)
	End if 
	SAVE RECORD:C53([Alumnos:2])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRecNums);__ ("Separando celulares..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

C_LONGINT:C283($i;$j;$k)
C_TEXT:C284($separador;$phones;$phone)
ALL RECORDS:C47([Familia:78])
ARRAY LONGINT:C221(aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Familia:78];aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Separando celulares..."))
For ($i;1;Size of array:C274(aRecNums))
	READ WRITE:C146([Familia:78])
	GOTO RECORD:C242([Familia:78];aRecNums{$i})
	[Familia:78]Telefono:10:=Replace string:C233([Familia:78]Telefono:10;" ";"")
	$phones:=[Familia:78]Telefono:10
	For ($k;1;ST_CountWords ($phones;0;$separador))
		$phone:=ST_GetWord ($phones;$k;$separador)
		If ((($phone="08@") | ($phone="09@") | ($phone="(08@") | ($phone="(09@")) & ((Old:C35([Familia:78]Celular:32)="") & (Length:C16($phone)>=9)))
			[Familia:78]Celular:32:=[Familia:78]Celular:32+$phone+$separador
			[Familia:78]Telefono:10:=Replace string:C233([Familia:78]Telefono:10;$separador+$phone;"")
			[Familia:78]Telefono:10:=Replace string:C233([Familia:78]Telefono:10;$phone+$separador;"")
			[Familia:78]Telefono:10:=Replace string:C233([Familia:78]Telefono:10;$phone;"")
		End if 
	End for 
	[Familia:78]Telefono:10:=Replace string:C233([Familia:78]Telefono:10;$separador+$separador;$separador)
	If ([Familia:78]Telefono:10[[Length:C16([Familia:78]Telefono:10)]]=$separador)
		[Familia:78]Telefono:10:=Substring:C12([Familia:78]Telefono:10;1;Length:C16([Familia:78]Telefono:10)-1)
	End if 
	[Familia:78]Celular:32:=Replace string:C233([Familia:78]Celular:32;$separador+$separador;$separador)
	If ([Familia:78]Celular:32[[Length:C16([Familia:78]Celular:32)]]=$separador)
		[Familia:78]Celular:32:=Substring:C12([Familia:78]Celular:32;1;Length:C16([Familia:78]Celular:32)-1)
	End if 
	SAVE RECORD:C53([Familia:78])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRecNums);__ ("Separando celulares..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)