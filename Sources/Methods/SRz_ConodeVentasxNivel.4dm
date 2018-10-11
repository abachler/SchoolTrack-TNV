//%attributes = {}
  //cono de ventas
  //1)numero de nivel
  //2)ciclo
  //3)puntero sobre un arreglo para las cantidades del cono x nivel
  //4) columna total booleano para columna total (ocupada en le informe)

C_LONGINT:C283($hl_estados;$nivel;$found)
C_TEXT:C284($vt_CampoPropioCiclo)
C_BOOLEAN:C305($vb_tot;$4)

$nivel:=$1
$vt_CampoPropioCiclo:=$2

If (Count parameters:C259=4)
	$vb_tot:=$4
End if 

$found:=Find in array:C230(<>al_NumeroNivelesActivos;$nivel)

If ($found#-1)
	
	ARRAY LONGINT:C221($al_resultado;0)
	ARRAY TEXT:C222($at_encabezado;0)
	ARRAY TEXT:C222($at_enca_temp;0)
	
	$hl_estados:=New list:C375
	$hl_estados:=ADTcfg_LoadEstados 
	
	LIST TO ARRAY:C288($hl_estados;$at_enca_temp)
	APPEND TO ARRAY:C911($at_enca_temp;"Reinscritos")
	
	C_LONGINT:C283($i;$j;$n;$vl_atipicos;$vl_Bajas_M;$vl_Bajas_F)
	$vl_atipicos:=0
	$vl_Bajas_M:=0
	$vl_Bajas_F:=0
	
	ARRAY LONGINT:C221($al_cantidades_M;0)
	ARRAY LONGINT:C221($al_cantidades_F;0)
	ARRAY LONGINT:C221($al_cantidades_M;Size of array:C274($at_enca_temp))
	ARRAY LONGINT:C221($al_cantidades_F;Size of array:C274($at_enca_temp))
	
	  //ESTADOS CONFIGURADOS DE ADT
	
	For ($i;1;Size of array:C274($at_enca_temp))
		
		For ($n;1;2)
			If ($n=1)
				APPEND TO ARRAY:C911($at_encabezado;$at_enca_temp{$i}+" Niños")
			Else 
				APPEND TO ARRAY:C911($at_encabezado;$at_enca_temp{$i}+" Niñas")
			End if 
		End for 
		
	End for 
	
	ARRAY LONGINT:C221(al_candidatos;0)
	ARRAY LONGINT:C221(al_prospectos;0)
	ARRAY LONGINT:C221(al_alumnos;0)
	
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Postula_a_Nombre:41=<>at_NombreNivelesActivos{$found})
	QUERY:C277([ADT_Prospectos:163];[ADT_Prospectos:163]Postula_a:11=<>al_NumeroNivelesActivos{$found})
	
	LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];al_candidatos;"")
	LONGINT ARRAY FROM SELECTION:C647([ADT_Prospectos:163];al_prospectos;"")
	
	  //Candidatos
	For ($i;1;Size of array:C274(al_candidatos))
		
		GOTO RECORD:C242([ADT_Candidatos:49];al_candidatos{$i})
		
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
		QUERY:C277([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]ID_Candidato:1=[ADT_Candidatos:49]Candidato_numero:1)
		
		ARRAY TEXT:C222($at_estados;0)
		ARRAY LONGINT:C221($al_estados;0)
		
		AT_DistinctsFieldValues (->[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3;->$al_estados)
		APPEND TO ARRAY:C911($at_estados;[ADT_Candidatos:49]Estado:52)
		AT_DistinctsArrayValues (->$al_estados)
		For ($j;1;Size of array:C274($al_estados))
			APPEND TO ARRAY:C911($at_estados;HL_FindInListByReference ($hl_estados;$al_estados{$j}))
		End for 
		AT_DistinctsArrayValues (->$at_estados)
		
		For ($n;1;Size of array:C274($at_estados))
			$j:=Find in array:C230($at_enca_temp;$at_estados{$n})
			If ($j>0)
				Case of 
					: ([Alumnos:2]Sexo:49="M")
						$al_cantidades_M{$j}:=$al_cantidades_M{$j}+1
					: ([Alumnos:2]Sexo:49="F")
						$al_cantidades_F{$j}:=$al_cantidades_F{$j}+1
					Else 
						  //TRACE
						  //CD_Dlog (0;"El Candidato "+[Alumnos]Apellidos_y_Nombres+", no tiene registrado su sexo y no puede ser contabilizado en este listado")
				End case 
			End if 
		End for 
		
	End for 
	
	For ($i;1;Size of array:C274(al_prospectos))
		GOTO RECORD:C242([ADT_Prospectos:163];al_prospectos{$i})
		$j:=Find in array:C230($at_enca_temp;"Prospecto@")
		If ($j>0)
			Case of 
				: ([ADT_Prospectos:163]Sexo:7="M")
					$al_cantidades_M{$j}:=$al_cantidades_M{$j}+1
				: ([ADT_Prospectos:163]Sexo:7="F")
					$al_cantidades_F{$j}:=$al_cantidades_F{$j}+1
				Else 
					  //TRACE
					  //CD_Dlog (0;"El Prospecto "+[ADT_Prospectos]Apellidos_y_Nombres+", no tiene registrado su sexo y no puede ser contabilizado en este listado")
			End case 
		End if 
		
	End for 
	
	
	  //ALUMNOS YA INSCRITOS Y TRANSFERIDOS A SCHOOLTRACK A CURSO DE ADT
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20="@-ADT";*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29=$nivel)
	
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];al_alumnos;"")
	
	For ($i;1;Size of array:C274(al_alumnos))
		
		ARRAY LONGINT:C221($al_estadosV;0)
		ARRAY LONGINT:C221($al_estadosN;0)
		ARRAY LONGINT:C221($al_estados;0)
		ARRAY TEXT:C222($at_estados;0)
		
		GOTO RECORD:C242([Alumnos:2];al_alumnos{$i})
		QUERY:C277([xxADT_LogCambioEstado:162];[xxADT_LogCambioEstado:162]ID_Candidato:1=[Alumnos:2]numero:1)
		AT_DistinctsFieldValues (->[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3;->$al_estadosV)
		AT_DistinctsFieldValues (->[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4;->$al_estadosN)
		AT_Union (->$al_estadosV;->$al_estadosN;->$al_estados)
		
		For ($j;1;Size of array:C274($al_estados))
			APPEND TO ARRAY:C911($at_estados;HL_FindInListByReference ($hl_estados;$al_estados{$j}))
		End for 
		
		For ($n;1;Size of array:C274($at_estados))
			
			$j:=Find in array:C230($at_enca_temp;$at_estados{$n})
			If ($j>0)
				Case of 
					: ([Alumnos:2]Sexo:49="M")
						$al_cantidades_M{$j}:=$al_cantidades_M{$j}+1
					: ([Alumnos:2]Sexo:49="F")
						$al_cantidades_F{$j}:=$al_cantidades_F{$j}+1
					Else 
						  //TRACE
						  //CD_Dlog (0;"El Candidato "+[Alumnos]Apellidos_y_Nombres+", no tiene registrado su sexo y no puede ser contabilizado en este listado")
				End case 
			End if 
			
		End for 
		
	End for 
	
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$nivel;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@-ADT")
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];al_alumnos;"")
	
	
	$vt_CampoPropioCiclo:="Inscripción ciclo "+$vt_CampoPropioCiclo
	
	For ($i;1;Size of array:C274(al_alumnos))
		
		GOTO RECORD:C242([Alumnos:2];al_alumnos{$i})
		  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID_Alumno=[Alumnos]Número)
		  // mas adelante puede ser con el campo matriculado desde cuentas corrientes
		  //If ([ACT_CuentasCorrientes]Matriculado=True)
		
		Case of 
			: ((_CampoPropio ($vt_CampoPropioCiclo))="Reinscrito@")
				$j:=Find in array:C230($at_enca_temp;"Reinscrito@")
				If ($j>0)
					Case of 
						: ([Alumnos:2]Sexo:49="M")
							$al_cantidades_M{$j}:=$al_cantidades_M{$j}+1
						: ([Alumnos:2]Sexo:49="F")
							$al_cantidades_F{$j}:=$al_cantidades_F{$j}+1
						Else 
							  //TRACE
							  //CD_Dlog (0;"El Candidato "+[Alumnos]Apellidos_y_Nombres+", no tiene registrado su sexo y no puede ser contabilizado en este listado")
					End case 
				End if 
				
			: ((_CampoPropio ($vt_CampoPropioCiclo))="Baja@")
				Case of 
					: ([Alumnos:2]Sexo:49="M")
						$vl_Bajas_M:=$vl_Bajas_M+1
					: ([Alumnos:2]Sexo:49="F")
						$vl_Bajas_F:=$vl_Bajas_F+1
					Else 
						  //TRACE
						  //CD_Dlog (0;"El Candidato "+[Alumnos]Apellidos_y_Nombres+", no tiene registrado su sexo y no puede ser contabilizado en este listado")
				End case 
		End case 
		
		If ((_CampoPropio ("Atípico"))="Si")
			$vl_atipicos:=$vl_atipicos+1
		End if 
		
	End for 
	
	C_LONGINT:C283($vl_total_M;$vl_total_F)
	For ($i;1;Size of array:C274($at_enca_temp))
		
		Case of 
			: ($at_enca_temp{$i}="Inscrito@")
				$vl_total_M:=$vl_total_M+$al_cantidades_M{$i}
				$vl_total_F:=$vl_total_F+$al_cantidades_F{$i}
			: ($at_enca_temp{$i}="Reinscrito@")
				$vl_total_M:=$vl_total_M+$al_cantidades_M{$i}
				$vl_total_F:=$vl_total_F+$al_cantidades_F{$i}
		End case 
		
		APPEND TO ARRAY:C911($3->;$al_cantidades_M{$i})
		APPEND TO ARRAY:C911($3->;$al_cantidades_F{$i})
	End for 
	
	
	APPEND TO ARRAY:C911($at_encabezado;"Alumnado Total Niños")
	APPEND TO ARRAY:C911($at_encabezado;"Alumnado Total Niñas")
	If ($vb_tot)
		APPEND TO ARRAY:C911($at_encabezado;"Alumnado Total")
	End if 
	
	APPEND TO ARRAY:C911($at_encabezado;"Bajas Niños")
	APPEND TO ARRAY:C911($at_encabezado;"Bajas Niñas")
	APPEND TO ARRAY:C911($at_encabezado;"Atípicos")
	
	APPEND TO ARRAY:C911($3->;$vl_total_M)
	APPEND TO ARRAY:C911($3->;$vl_total_F)
	
	If ($vb_tot)
		APPEND TO ARRAY:C911($3->;$vl_total_M+$vl_total_F)
	End if 
	
	APPEND TO ARRAY:C911($3->;$vl_Bajas_M)
	APPEND TO ARRAY:C911($3->;$vl_Bajas_F)
	APPEND TO ARRAY:C911($3->;$vl_atipicos)
	
End if 

