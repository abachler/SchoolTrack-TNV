//%attributes = {}
  //dbu_TelefonosRegiones_5y8

C_LONGINT:C283($i;$j;$k;$pID;$el)
C_TEXT:C284($separador;$phones;$phone)
ARRAY TEXT:C222(aText;29)

$separador:=CD_Request (__ ("Separador para más de un número en un mismo campo:");__ ("OK");__ ("Cancelar");__ ("");__ ("/"))
If (ok=1)
	AT_Inc (0)
	aText{AT_Inc }:="Arauco"
	aText{AT_Inc }:="Cañete"
	aText{AT_Inc }:="Casablanca"
	aText{AT_Inc }:="Concepción"
	aText{AT_Inc }:="Concon"
	aText{AT_Inc }:="Contulmo"
	aText{AT_Inc }:="Coronel"
	aText{AT_Inc }:="Curanilahue"
	aText{AT_Inc }:="Chiguayante"
	aText{AT_Inc }:="Florida"
	aText{AT_Inc }:="Hualqui"
	aText{AT_Inc }:="Isla de Pascua"
	aText{AT_Inc }:="Juan Fernández"
	aText{AT_Inc }:="Lebu"
	aText{AT_Inc }:="Los Alamos"
	aText{AT_Inc }:="Lota"
	aText{AT_Inc }:="Penco"
	aText{AT_Inc }:="Penco"
	aText{AT_Inc }:="Quilpué"
	aText{AT_Inc }:="Quintero"
	aText{AT_Inc }:="Santa Juana"
	aText{AT_Inc }:="Talcahuano"
	aText{AT_Inc }:="Tirúa"
	aText{AT_Inc }:="Tomé"
	aText{AT_Inc }:="Valparaíso"
	aText{AT_Inc }:="Villa Alemana"
	aText{AT_Inc }:="Viña del Mar"
	
	ALL RECORDS:C47([Alumnos:2])
	ARRAY LONGINT:C221(aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];aRecNums;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	For ($i;1;Size of array:C274(aRecNums))
		READ WRITE:C146([Alumnos:2])
		GOTO RECORD:C242([Alumnos:2];aRecNums{$i})
		$el:=Find in array:C230(aText;[Alumnos:2]Comuna:14)
		If ($el>0)
			$phone:=[Alumnos:2]Fax:69
			[Alumnos:2]Fax:69:=""
			Case of 
				: (Length:C16($phone)=6)
					[Alumnos:2]Fax:69:="2"+$phone
				: ((Length:C16($phone)=8) & ($phone="41@"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"41";"41-2";1)
				: ((Length:C16($phone)=8) & ($phone="32@"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"32";"32-2";1)
				: ((Length:C16($phone)=9) & ($phone="41-@"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"41-";"41-2";1)
				: ((Length:C16($phone)=9) & ($phone="32-@"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"32-";"32-2";1)
				: ((Length:C16($phone)=10) & ($phone="(41)@"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"(41)";"(41) 2";1)
				: ((Length:C16($phone)=10) & ($phone="(32)@"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"(32)";"(32) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(41) @"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"(41) ";"(41) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(32) @"))
					[Alumnos:2]Fax:69:=[Alumnos:2]Fax:69+Replace string:C233($phone;"(32) ";"(32) 2";1)
			End case 
			$phones:=[Alumnos:2]Telefono:17
			[Alumnos:2]Telefono:17:=""
			For ($k;1;ST_CountWords ($phones;0;$separador))
				$phone:=ST_GetWord ($phones;$k;$separador)
				Case of 
					: ((Length:C16($phone)=8) & ($phone="41@"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"41";"41-2";1)+$separador
					: ((Length:C16($phone)=8) & ($phone="32@"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"32";"32-2";1)+$separador
					: ((Length:C16($phone)=9) & ($phone="41-@"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"41-";"41-2";1)+$separador
					: ((Length:C16($phone)=9) & ($phone="32-@"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"32-";"32-2";1)+$separador
					: ((Length:C16($phone)=10) & ($phone="(41)@"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"(41)";"(41) 2";1)+$separador
					: ((Length:C16($phone)=10) & ($phone="(32)@"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"(32)";"(32) 2";1)+$separador
					: ((Length:C16($phone)=11) & ($phone="(41 )@"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"(41) ";"(41) 2";1)+$separador
					: ((Length:C16($phone)=11) & ($phone="(32) @"))
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+Replace string:C233($phone;"(32) ";"(32) 2";1)+$separador
					: (Length:C16($phone)=6)
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+"2"+$phone+$separador
					Else 
						[Alumnos:2]Telefono:17:=[Alumnos:2]Telefono:17+$phone+$separador
				End case 
			End for 
			If ([Alumnos:2]Telefono:17[[Length:C16([Alumnos:2]Telefono:17)]]=$separador)
				[Alumnos:2]Telefono:17:=Substring:C12([Alumnos:2]Telefono:17;1;Length:C16([Alumnos:2]Telefono:17)-1)
			End if 
			
		End if 
		SAVE RECORD:C53([Alumnos:2])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRecNums);__ ("Alumnos: Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	ALL RECORDS:C47([Personas:7])
	ARRAY LONGINT:C221(aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Personas:7];aRecNums;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	For ($i;1;Size of array:C274(aRecNums))
		READ WRITE:C146([Personas:7])
		GOTO RECORD:C242([Personas:7];aRecNums{$i})
		$el:=Find in array:C230(aText;[Personas:7]Comuna:16)
		If ($el>0)
			$phone:=[Personas:7]Fax:35
			[Personas:7]Fax:35:=""
			Case of 
				: (Length:C16($phone)=6)
					[Personas:7]Fax:35:="2"+$phone
				: ((Length:C16($phone)=8) & ($phone="41@"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"41";"41-2";1)
				: ((Length:C16($phone)=8) & ($phone="32@"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"32";"32-2";1)
				: ((Length:C16($phone)=9) & ($phone="41-@"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"41-";"41-2";1)
				: ((Length:C16($phone)=9) & ($phone="32-@"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"32-";"32-2";1)
				: ((Length:C16($phone)=10) & ($phone="(41)@"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"(41)";"(41) 2";1)
				: ((Length:C16($phone)=10) & ($phone="(32)@"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"(32)";"(32) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(41) @"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"(41) ";"(41) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(32) @"))
					[Personas:7]Fax:35:=[Personas:7]Fax:35+Replace string:C233($phone;"(32) ";"(32) 2";1)
			End case 
			$phone:=[Personas:7]Telefono_domicilio:19
			[Personas:7]Telefono_domicilio:19:=""
			Case of 
				: (Length:C16($phone)=6)
					[Personas:7]Telefono_domicilio:19:="2"+$phone
				: ((Length:C16($phone)=8) & ($phone="41@"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"41";"41-2";1)
				: ((Length:C16($phone)=8) & ($phone="32@"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"32";"32-2";1)
				: ((Length:C16($phone)=9) & ($phone="41-@"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"41-";"41-2";1)
				: ((Length:C16($phone)=9) & ($phone="32-@"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"32-";"32-2";1)
				: ((Length:C16($phone)=10) & ($phone="(41)@"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"(41)";"(41) 2";1)
				: ((Length:C16($phone)=10) & ($phone="(32)@"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"(32)";"(32) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(41) @"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"(41) ";"(41) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(32) @"))
					[Personas:7]Telefono_domicilio:19:=[Personas:7]Telefono_domicilio:19+Replace string:C233($phone;"(32) ";"(32) 2";1)
			End case 
		End if 
		
		For ($j;1;Size of array:C274(aText))
			If (Position:C15(aText{$j};[Personas:7]Direccion_Profesional:23)>0)
				$j:=Size of array:C274(aText)
				$phone:=[Personas:7]Fax_empresa:25
				[Personas:7]Fax_empresa:25:=""
				Case of 
					: (Length:C16($phone)=6)
						[Personas:7]Fax_empresa:25:="2"+$phone
					: ((Length:C16($phone)=8) & ($phone="41@"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"41";"41-2";1)
					: ((Length:C16($phone)=8) & ($phone="32@"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"32";"32-2";1)
					: ((Length:C16($phone)=9) & ($phone="41-@"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"41-";"41-2";1)
					: ((Length:C16($phone)=9) & ($phone="32-@"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"32-";"32-2";1)
					: ((Length:C16($phone)=10) & ($phone="(41)@"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"(41)";"(41) 2";1)
					: ((Length:C16($phone)=10) & ($phone="(32)@"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"(32)";"(32) 2";1)
					: ((Length:C16($phone)=11) & ($phone="(41) @"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"(41) ";"(41) 2";1)
					: ((Length:C16($phone)=11) & ($phone="(32) @"))
						[Personas:7]Fax_empresa:25:=[Personas:7]Fax_empresa:25+Replace string:C233($phone;"(32) ";"(32) 2";1)
				End case 
				
				$phone:=[Personas:7]Telefono_profesional:29
				[Personas:7]Telefono_profesional:29:=""
				Case of 
					: (Length:C16($phone)=6)
						[Personas:7]Telefono_profesional:29:="2"+$phone
					: ((Length:C16($phone)=8) & ($phone="41@"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"41";"41-2";1)
					: ((Length:C16($phone)=8) & ($phone="32@"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"32";"32-2";1)
					: ((Length:C16($phone)=9) & ($phone="41-@"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"41-";"41-2";1)
					: ((Length:C16($phone)=9) & ($phone="32-@"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"32-";"32-2";1)
					: ((Length:C16($phone)=10) & ($phone="(41)@"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"(41)";"(41) 2";1)
					: ((Length:C16($phone)=10) & ($phone="(32)@"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"(32)";"(32) 2";1)
					: ((Length:C16($phone)=11) & ($phone="(41) @"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"(41) ";"(41) 2";1)
					: ((Length:C16($phone)=11) & ($phone="(32) @"))
						[Personas:7]Telefono_profesional:29:=[Personas:7]Telefono_profesional:29+Replace string:C233($phone;"(32) ";"(32) 2";1)
				End case 
			End if 
		End for 
		SAVE RECORD:C53([Personas:7])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRecNums);__ ("Personas: Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	ALL RECORDS:C47([Profesores:4])
	ARRAY LONGINT:C221(aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Profesores:4];aRecNums;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	For ($i;1;Size of array:C274(aRecNums))
		READ WRITE:C146([Profesores:4])
		GOTO RECORD:C242([Profesores:4];aRecNums{$i})
		$el:=Find in array:C230(aText;[Profesores:4]Comuna:10)
		If ($el>0)
			$phone:=[Profesores:4]Fax:39
			[Profesores:4]Fax:39:=""
			Case of 
				: (Length:C16($phone)=6)
					[Profesores:4]Fax:39:="2"+$phone
				: ((Length:C16($phone)=8) & ($phone="41@"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"41";"41-2";1)
				: ((Length:C16($phone)=8) & ($phone="32@"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"32";"32-2";1)
				: ((Length:C16($phone)=9) & ($phone="41-@"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"41-";"41-2";1)
				: ((Length:C16($phone)=9) & ($phone="32-@"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"32-";"32-2";1)
				: ((Length:C16($phone)=10) & ($phone="(41)@"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"(41)";"(41) 2";1)
				: ((Length:C16($phone)=10) & ($phone="(32)@"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"(32)";"(32) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(41) @"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"(41) ";"(41) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(32) @"))
					[Profesores:4]Fax:39:=[Profesores:4]Fax:39+Replace string:C233($phone;"(32) ";"(32) 2";1)
			End case 
			$phone:=[Profesores:4]Telefono_domicilio:24
			[Profesores:4]Telefono_domicilio:24:=""
			Case of 
				: (Length:C16($phone)=6)
					[Profesores:4]Telefono_domicilio:24:="2"+$phone
				: ((Length:C16($phone)=8) & ($phone="41@"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"41";"41-2";1)
				: ((Length:C16($phone)=8) & ($phone="32@"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"32";"32-2";1)
				: ((Length:C16($phone)=9) & ($phone="41-@"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"41-";"41-2";1)
				: ((Length:C16($phone)=9) & ($phone="32-@"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"32-";"32-2";1)
				: ((Length:C16($phone)=10) & ($phone="(41)@"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"(41)";"(41) 2";1)
				: ((Length:C16($phone)=10) & ($phone="(32)@"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"(32)";"(32) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(41) @"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"(41) ";"(41) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(32) @"))
					[Profesores:4]Telefono_domicilio:24:=[Profesores:4]Telefono_domicilio:24+Replace string:C233($phone;"(32 )";"(32) 2";1)
			End case 
		End if 
		SAVE RECORD:C53([Profesores:4])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRecNums);__ ("Profesores: Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	ALL RECORDS:C47([Familia:78])
	ARRAY LONGINT:C221(aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Familia:78];aRecNums;"")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	For ($i;1;Size of array:C274(aRecNums))
		READ WRITE:C146([Familia:78])
		GOTO RECORD:C242([Familia:78];aRecNums{$i})
		$el:=Find in array:C230(aText;[Familia:78]Comuna:8)
		If ($el>0)
			$phone:=[Familia:78]Fax:20
			[Familia:78]Fax:20:=""
			Case of 
				: (Length:C16($phone)=6)
					[Familia:78]Fax:20:="2"+$phone
				: ((Length:C16($phone)=8) & ($phone="41@"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"41";"41-2";1)
				: ((Length:C16($phone)=8) & ($phone="32@"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"32";"32-2";1)
				: ((Length:C16($phone)=9) & ($phone="41-@"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"41-";"41-2";1)
				: ((Length:C16($phone)=9) & ($phone="32-@"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"32-";"32-2";1)
				: ((Length:C16($phone)=10) & ($phone="(41)@"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"(41)";"(41) 2";1)
				: ((Length:C16($phone)=10) & ($phone="(32)@"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"(32)";"(32) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(41) @"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"(41) ";"(41) 2";1)
				: ((Length:C16($phone)=11) & ($phone="(32) @"))
					[Familia:78]Fax:20:=[Familia:78]Fax:20+Replace string:C233($phone;"(32) ";"(32) 2";1)
			End case 
			$phones:=[Familia:78]Telefono:10
			[Familia:78]Telefono:10:=""
			For ($k;1;ST_CountWords ($phones;0;$separador))
				$phone:=ST_GetWord ($phones;$k;$separador)
				Case of 
					: ((Length:C16($phone)=8) & ($phone="41@"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"41";"41-2";1)+$separador
					: ((Length:C16($phone)=8) & ($phone="32@"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"32";"32-2";1)+$separador
					: ((Length:C16($phone)=9) & ($phone="41-@"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"41-";"41-2";1)+$separador
					: ((Length:C16($phone)=9) & ($phone="32-@"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"32-";"32-2";1)+$separador
					: ((Length:C16($phone)=10) & ($phone="(41)@"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"(41)";"(41) 2";1)+$separador
					: ((Length:C16($phone)=10) & ($phone="(32)@"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"(32)";"(32) 2";1)+$separador
					: ((Length:C16($phone)=11) & ($phone="(41) @"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"(41) ";"(41) 2";1)+$separador
					: ((Length:C16($phone)=11) & ($phone="(32) @"))
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+Replace string:C233($phone;"(32) ";"(32) 2";1)+$separador
					: (Length:C16($phone)=6)
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+"2"+$phone+$separador
					Else 
						[Familia:78]Telefono:10:=[Familia:78]Telefono:10+$phone+$separador
				End case 
			End for 
			If ([Familia:78]Telefono:10[[Length:C16([Familia:78]Telefono:10)]]=$separador)
				[Familia:78]Telefono:10:=Substring:C12([Familia:78]Telefono:10;1;Length:C16([Familia:78]Telefono:10)-1)
			End if 
			
			
		End if 
		SAVE RECORD:C53([Familia:78])
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRecNums);__ ("Familias: Agregando prefijo '2' a los números télefónicos correspondientes a códigos de área 32 y 41..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 