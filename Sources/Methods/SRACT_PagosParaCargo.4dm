//%attributes = {}
  //SRACT_PagosParaCargo


ok:=1
WDW_OpenFormWindow (->[xxSTR_Constants:1];"SRACT_SeleccionaItem";0;Palette form window:K39:9;__ ("Selección del item"))
DIALOG:C40([xxSTR_Constants:1];"SRACT_SeleccionaItem")
CLOSE WINDOW:C154

If (ok=1)
	$0:=True:C214
	ARRAY TEXT:C222(atNombreAlumno;0)
	ARRAY TEXT:C222(atCursoAlumno;0)
	ARRAY LONGINT:C221($aRecNumCtas;0)
	ARRAY LONGINT:C221(aNivelAlumno;0)
	ARRAY TEXT:C222(atMes1;0)
	ARRAY TEXT:C222(atMes2;0)
	ARRAY TEXT:C222(atMes3;0)
	ARRAY TEXT:C222(atMes4;0)
	ARRAY TEXT:C222(atMes5;0)
	ARRAY TEXT:C222(atMes6;0)
	ARRAY TEXT:C222(atMes7;0)
	ARRAY TEXT:C222(atMes8;0)
	ARRAY TEXT:C222(atMes9;0)
	ARRAY TEXT:C222(atMes10;0)
	ARRAY TEXT:C222(atMes11;0)
	ARRAY TEXT:C222(atMes12;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$aRecNumCtas;"")
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([Alumnos:2])
	$iterations:=Size of array:C274($aRecNumCtas)*12
	$currentiteration:=0
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recopilando información..."))
	For ($i;1;Size of array:C274($aRecNumCtas))
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aRecNumCtas{$i})
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		AT_Insert (0;1;->atNombreAlumno;->atCursoAlumno;->aNivelAlumno)
		atNombreAlumno{Size of array:C274(atNombreAlumno)}:=[Alumnos:2]apellidos_y_nombres:40
		atCursoAlumno{Size of array:C274(atCursoAlumno)}:=[Alumnos:2]curso:20
		aNivelAlumno{Size of array:C274(aNivelAlumno)}:=[Alumnos:2]nivel_numero:29
		$year:=Year of:C25(Current date:C33(*))
		For ($j;1;12)
			$IniDate:=DT_GetDateFromDayMonthYear (1;$j;$year)
			$EndDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($j;$year);$j;$year)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=vlACT_RefItem;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=$iniDate;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$endDate)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
			$ptr:=Get pointer:C304("atMes"+String:C10($j))
			AT_Insert (0;1;$ptr)
			ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5;>)
			FIRST RECORD:C50([ACT_Transacciones:178])
			For ($k;1;Records in selection:C76([ACT_Transacciones:178]))
				$ptr->{Size of array:C274($ptr->)}:=$ptr->{Size of array:C274($ptr->)}+String:C10([ACT_Transacciones:178]Fecha:5;7)+"\r"
				NEXT RECORD:C51([ACT_Transacciones:178])
			End for 
			$ptr->{Size of array:C274($ptr->)}:=Substring:C12($ptr->{Size of array:C274($ptr->)};1;Length:C16($ptr->{Size of array:C274($ptr->)})-1)
			$currentiteration:=$currentiteration+1
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentiteration/$iterations;__ ("Recopilando información..."))
		End for 
	End for 
	AT_MultiLevelSort (">>>            ";->aNivelAlumno;->atCursoAlumno;->atNombreAlumno;->atMes1;->atMes2;->atMes3;->atMes4;->atMes5;->atMes6;->atMes7;->atMes8;->atMes9;->atMes10;->atMes11;->atMes12)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
Else 
	$0:=False:C215
End if 