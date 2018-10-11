//%attributes = {}
  //SRACT_ccContratoporCtaCte

If (Count parameters:C259>0)
	C_LONGINT:C283($1;$2)
	
	vdFechaCargoFin:=DT_GetDateFromDayMonthYear (31;12;$2)
	vdFechaCargoIni:=DT_GetDateFromDayMonthYear (1;1;$2)
	
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	$IDCtaCte:=[ACT_CuentasCorrientes:175]ID:1
	$IDApoderado:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1;=;[ACT_CuentasCorrientes:175]ID_Alumno:3)
	$vtNombreAlumno:=[Alumnos:2]apellidos_y_nombres:40
	$vtRutAlumno:=[Alumnos:2]RUT:5
	
	If ($2=Year of:C25(Current date:C33(*)))
		$NivelBuscado:=[Alumnos:2]nivel_numero:29
	Else 
		$NivelBuscado:=[Alumnos:2]nivel_numero:29+1
	End if 
	
	READ ONLY:C145([xxSTR_Niveles:6])
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;=;$NivelBuscado)
	$vtNivelAlumno:=[xxSTR_Niveles:6]Nivel:1
	READ ONLY:C145([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]No:1;=;[ACT_CuentasCorrientes:175]ID_Apoderado:9)
	$vtApodenadoNombre:=[Personas:7]Apellidos_y_nombres:30
	$vtRutApoderado:=[Personas:7]RUT:6
	$vtDomicilioApod:=[Personas:7]Direccion:14
	$vtTelefonoApod:=[Personas:7]Telefono_domicilio:19
	$vtComunaApod:=[Personas:7]Comuna:16
	
	  //Para calcular el arancel anual -    Mensualidad
	  //Buscar ID de los items que contengan la palabra Mensualidad
	ARRAY TEXT:C222(atACT_GlosaItemsGral;0)
	ARRAY LONGINT:C221(alACT_IDItemsGral;0)
	ARRAY LONGINT:C221(alACT_IDItemsBuscados;0)
	READ ONLY:C145([xxACT_Items:179])
	ALL RECORDS:C47([xxACT_Items:179])
	SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_GlosaItemsGral;[xxACT_Items:179]ID:1;alACT_IDItemsGral)
	$line:=Size of array:C274(alACT_IDItemsGral)
	For ($j;1;$line)
		$vtGlosaGral:=atACT_GlosaItemsGral{$j}
		If (Position:C15("Mensualidad";$vtGlosaGral)>0)
			AT_Insert (0;1;->alACT_IDItemsBuscados)
			alACT_IDItemsBuscados{Size of array:C274(alACT_IDItemsBuscados)}:=alACT_IDItemsGral{$j}
		End if 
	End for 
	
	QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->alACT_IDItemsBuscados)
	CREATE SET:C116([ACT_Cargos:173];"todos")
	USE SET:C118("todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$IDCtaCte)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$IDApoderado)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>=;vdFechaCargoIni)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;<=;vdFechaCargoFin)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
	$Arancel:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
	$vrTotalProyectado:=String:C10($Arancel;"|Despliegue_ACT")
	C_LONGINT:C283($totaldeCargosX)
	$totaldeCargosX:=Records in selection:C76([ACT_Cargos:173])
	$vrCuotaMensual:=Round:C94($Arancel/$totaldeCargosX;0)
	$vt_ArancelenPalabras:=ST_Num2Text2 ($Arancel;"Spanish")
	$vt_CuotaenPalabras:=ST_Num2Text2 ($vrCuotaMensual;"Spanish")
	CLEAR SET:C117("todos")
	
	
	  //Para calcular el valor de la matrícula
	  //Buscar ID de los items que contengan la palabra Matrícula
	ARRAY TEXT:C222(atACT_GlosaItemsGral;0)
	ARRAY LONGINT:C221(alACT_IDItemsGral;0)
	ARRAY LONGINT:C221(alACT_IDItemsBuscados;0)
	READ ONLY:C145([xxACT_Items:179])
	ALL RECORDS:C47([xxACT_Items:179])
	SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_GlosaItemsGral;[xxACT_Items:179]ID:1;alACT_IDItemsGral)
	$line:=Size of array:C274(alACT_IDItemsGral)
	For ($j;1;$line)
		$vtGlosaGral:=atACT_GlosaItemsGral{$j}
		If (Position:C15("Matrícula";$vtGlosaGral)>0)
			AT_Insert (0;1;->alACT_IDItemsBuscados)
			alACT_IDItemsBuscados{Size of array:C274(alACT_IDItemsBuscados)}:=alACT_IDItemsGral{$j}
		End if 
	End for 
	
	QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->alACT_IDItemsBuscados)
	CREATE SET:C116([ACT_Cargos:173];"todos")
	USE SET:C118("todos")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$IDCtaCte)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$IDApoderado)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>=;vdFechaCargoIni)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;<=;vdFechaCargoFin)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
	$Matricula:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
	$vrTotalMatricula:=String:C10($Matricula;"|Despliegue_ACT")
	CLEAR SET:C117("todos")
	
	Case of 
		: ($1=1)
			$0:=$vtNombreAlumno
		: ($1=2)
			$0:=$vtRutAlumno
		: ($1=3)
			$0:=$vtNivelAlumno
		: ($1=4)
			$0:=$vtApodenadoNombre
		: ($1=5)
			$0:=$vtRutApoderado
		: ($1=6)
			$0:=$vtDomicilioApod
		: ($1=7)
			$0:=$vrTotalProyectado
		: ($1=8)
			$0:=$vrTotalMatricula
		: ($1=9)
			$0:=String:C10($vrCuotaMensual;"|Despliegue_ACT")
		: ($1=10)
			$0:=$vtTelefonoApod
		: ($1=11)
			$0:=$vtComunaApod
		: ($1=12)
			$0:=String:C10($totaldeCargosX)
		: ($1=13)
			$0:=$vt_ArancelenPalabras
		: ($1=14)
			$0:=$vt_CuotaenPalabras
	End case 
	
End if 