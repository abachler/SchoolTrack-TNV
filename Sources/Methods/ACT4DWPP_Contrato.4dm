//%attributes = {}
  //ACT4DWPP_Contrato

If (Count parameters:C259=3)
	If ($3=1)
		$viAño:=Num:C11(String:C10(Year of:C25(Current date:C33(*))+1/1/1))
	Else 
		$viAño:=Num:C11(String:C10(Year of:C25(Current date:C33(*))))
	End if 
End if 
If (Count parameters:C259<3)
	$viAño:=Num:C11(String:C10(Year of:C25(Current date:C33(*))))
End if 

$iniDate:=DT_GetDateFromDayMonthYear (1;1;$viAño)
$endDate:=DT_GetDateFromDayMonthYear (31;12;$viAño)

If ((Count parameters:C259>0) & (Count parameters:C259<4))
	If ($1=1)
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			If (Size of array:C274(abrSelect)>0)
				If (Size of array:C274(abrSelect)=1)
					GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
				Else 
					CD_Dlog (1;__ ("Seleccione solo un apoderado"))
				End if 
			Else 
				CD_Dlog (1;__ ("Seleccione un apoderado en el explorador"))
			End if 
		Else 
			CD_Dlog (1;__ ("Este informe se ejecuta desde la pestaña Apoderados en AccountTrack"))
		End if 
	End if 
	
	If (Size of array:C274(abrSelect)>0)
		If ($1=2)
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			LOAD RECORD:C52([Personas:7])
			C_TEXT:C284(vt_StudentName)
			vt_StudentName:=""
			vt_StudentName:="\t"+"Nombre"+"\t"+"RUT"+"\t"+"Fec. de Nac."+"\t"+"Vive con"+"\r"
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($x;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				vt_StudentName:=vt_StudentName+String:C10($x)+".-"+"\t"+[Alumnos:2]Nombres:2+"\t"+SR_FormatoRUT2 ([Alumnos:2]RUT:5)+"\t"+String:C10([Alumnos:2]Fecha_de_nacimiento:7)+"\t"+[Alumnos:2]Vive_con:81+"\r"
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentName;1;Length:C16(vt_StudentName)-1)
		End if 
		
		If ($1=3)
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			C_TEXT:C284(vt_StudentMa)
			C_REAL:C285($valorMat;$valorMatTotal)
			_O_C_STRING:C293(80;$nomAlu)
			vt_StudentMa:=""
			vt_StudentMa:="\t"+"Nombre"+"\t"+"Valor de Matrícula"+"\r"
			$valorMatTotal:=0
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			LOAD RECORD:C52([Personas:7])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($i;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				$nomAlu:=""
				$valorMat:=0
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>$iniDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<$endDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Glosa:12="Matrícula@")
				$valorMat:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				$nomAlu:=[Alumnos:2]Nombres:2
				vt_StudentMa:=vt_StudentMa+String:C10($i)+".-"+"\t"+$nomAlu+"\t"+String:C10($valorMat;"|Despliegue_ACT")+"\r"
				$valorMatTotal:=$valorMatTotal+$valorMat
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentMa;1;Length:C16(vt_StudentMa)-1)
			If ($2=1)
				$0:=String:C10($valorMatTotal;"|Despliegue_ACT")
			End if 
		End if 
		
		If ($1=4)
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			C_TEXT:C284(vt_StudentCol)
			_O_C_STRING:C293(80;$nomAlu)
			C_REAL:C285($sumaCargos;$valorColAnual)
			$valorColAnual:=0
			vt_StudentCol:=""
			vt_StudentCol:="\t"+"Nombre Alumno"+"\t"+"Valor Anual de Colegiatura"+"\r"
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			LOAD RECORD:C52([Personas:7])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($i;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				$sumaCargos:=0
				$nomAlu:=""
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>$iniDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<$endDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Glosa:12#"Matrícula@")
				$sumaCargos:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				$nomAlu:=[Alumnos:2]Nombres:2
				vt_StudentCol:=vt_StudentCol+String:C10($i)+".-"+"\t"+$nomAlu+"\t"+String:C10($sumaCargos;"|Despliegue_ACT")+"\r"
				$valorColAnual:=$valorColAnual+$sumaCargos
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentCol;1;Length:C16(vt_StudentCol)-1)
			If ($2=1)
				$0:=String:C10($valorColAnual;"|Despliegue_ACT")
			End if 
		End if 
		
		If ($1=5)
			C_TEXT:C284(vt_Nombres)
			C_TEXT:C284(vt_Apellidos)
			vt_Nombres:=""
			vt_Apellidos:=""
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			ARRAY LONGINT:C221(aIdsCtas;Records in selection:C76([ACT_CuentasCorrientes:175]))
			ARRAY TEXT:C222(at_Nombres;Records in selection:C76([ACT_CuentasCorrientes:175]))
			ARRAY TEXT:C222(at_Apellidos;Records in selection:C76([ACT_CuentasCorrientes:175]))
			LOAD RECORD:C52([Personas:7])
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aIdsCtas)
			For ($e;1;Size of array:C274(aIdsCtas))
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIdsCtas{$e})
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				at_Nombres{$e}:=[Alumnos:2]Nombres:2
				at_Apellidos{$e}:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
			End for 
			
			For ($e;1;Size of array:C274(at_Nombres))
				Case of 
					: (Size of array:C274(at_Nombres)=1)
						vt_Nombres:=at_Nombres{$e}
						vt_Apellidos:=at_Apellidos{$e}
					: (($e=(Size of array:C274(at_Nombres)-1)))
						vt_Nombres:=vt_Nombres+" "+at_Nombres{$e}
						If (at_Apellidos{$e}#at_Apellidos{$e-1})
							vt_Apellidos:=vt_Apellidos+" "+at_Apellidos{$e}
						End if 
					: (($e=Size of array:C274(at_Nombres)) & (Size of array:C274(at_Nombres)#1))
						vt_Nombres:=vt_Nombres+" y "+at_Nombres{$e}
						If (at_Apellidos{$e}#at_Apellidos{$e-1})
							vt_Apellidos:=vt_Apellidos+" y "+at_Apellidos{$e}
						End if 
					Else 
						vt_Nombres:=vt_Nombres+" "+at_Nombres{$e}+","
						If (at_Apellidos{$e}#at_Apellidos{$e-1})
							vt_Apellidos:=vt_Apellidos+" "+at_Apellidos{$e}
						End if 
				End case 
			End for 
			  //Junta el nombre de los alumnos con el apellido
			$0:=vt_Nombres+" "+vt_Apellidos
		End if 
		
		If ($1=6)
			C_TEXT:C284(vt_Cursos)
			vt_Cursos:=""
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			ARRAY LONGINT:C221(aIdsCtas;Records in selection:C76([ACT_CuentasCorrientes:175]))
			LOAD RECORD:C52([Personas:7])
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aIdsCtas)
			For ($e;1;Size of array:C274(aIdsCtas))
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIdsCtas{$e})
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				vt_Cursos:=vt_Cursos+[Alumnos:2]curso:20+", "
			End for 
			$0:=Substring:C12(vt_Cursos;1;Length:C16(vt_Cursos)-2)
		End if 
		
		If ($1=7)
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			LOAD RECORD:C52([Personas:7])
			C_TEXT:C284(vt_StudentName)
			vt_StudentName:=""
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($x;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				vt_StudentName:=vt_StudentName+String:C10($x)+"\t"+[Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4+"\r"
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentName;1;Length:C16(vt_StudentName)-1)
		End if 
		
		If ($1=8)  //igual al 3 pero en moneda pago
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			C_TEXT:C284(vt_StudentMa)
			C_REAL:C285($valorMat;$valorMatTotal)
			_O_C_STRING:C293(80;$nomAlu)
			vt_StudentMa:=""
			vt_StudentMa:="\t"+"Nombre"+"\t"+"Valor de Matrícula"+"\r"
			$valorMatTotal:=0
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			LOAD RECORD:C52([Personas:7])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($i;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				$nomAlu:=""
				$valorMat:=0
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>$iniDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<$endDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Glosa:12="Matrícula@")
				  //$valorMat:=Sum([ACT_Cargos]Monto_Neto)
				$valorMat:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				$nomAlu:=[Alumnos:2]Nombres:2
				vt_StudentMa:=vt_StudentMa+String:C10($i)+".-"+"\t"+$nomAlu+"\t"+String:C10($valorMat;"|Despliegue_ACT")+"\r"
				$valorMatTotal:=$valorMatTotal+$valorMat
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentMa;1;Length:C16(vt_StudentMa)-1)
			If ($2=1)
				$0:=String:C10($valorMatTotal;"|Despliegue_ACT")
			End if 
		End if 
		
		If ($1=9)  //igual al 4 pero en moneda pago
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			C_TEXT:C284(vt_StudentCol)
			_O_C_STRING:C293(80;$nomAlu)
			C_REAL:C285($sumaCargos;$valorColAnual)
			$valorColAnual:=0
			vt_StudentCol:=""
			vt_StudentCol:="\t"+"Nombre Alumno"+"\t"+"Valor Anual de Colegiatura"+"\r"
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			LOAD RECORD:C52([Personas:7])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($i;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				$sumaCargos:=0
				$nomAlu:=""
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>$iniDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<$endDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Glosa:12#"Matrícula@")
				$sumaCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				$nomAlu:=[Alumnos:2]Nombres:2
				vt_StudentCol:=vt_StudentCol+String:C10($i)+".-"+"\t"+$nomAlu+"\t"+String:C10($sumaCargos;"|Despliegue_ACT")+"\r"
				$valorColAnual:=$valorColAnual+$sumaCargos
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentCol;1;Length:C16(vt_StudentCol)-1)
			If ($2=1)
				$0:=String:C10($valorColAnual;"|Despliegue_ACT")
			End if 
		End if 
		
		If ($1=10)  //igual al 3 pero en moneda emision
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			C_TEXT:C284(vt_StudentMa)
			C_REAL:C285($valorMat;$valorMatTotal)
			_O_C_STRING:C293(80;$nomAlu)
			vt_StudentMa:=""
			vt_StudentMa:="\t"+"Nombre"+"\t"+"Valor de Matrícula"+"\r"
			$valorMatTotal:=0
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			LOAD RECORD:C52([Personas:7])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($i;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				$nomAlu:=""
				$valorMat:=0
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>$iniDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<$endDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Glosa:12="Matrícula@")
				$valorMat:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				$nomAlu:=[Alumnos:2]Nombres:2
				vt_StudentMa:=vt_StudentMa+String:C10($i)+".-"+"\t"+$nomAlu+"\t"+String:C10($valorMat;"|Despliegue_ACT")+"\r"
				$valorMatTotal:=$valorMatTotal+$valorMat
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentMa;1;Length:C16(vt_StudentMa)-1)
			If ($2=1)
				$0:=String:C10($valorMatTotal;"|Despliegue_ACT")
			End if 
		End if 
		
		If ($1=11)  //igual al 4 pero en moneda emision
			READ ONLY:C145([Personas:7])
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			C_TEXT:C284(vt_StudentCol)
			_O_C_STRING:C293(80;$nomAlu)
			C_REAL:C285($sumaCargos;$valorColAnual)
			$valorColAnual:=0
			vt_StudentCol:=""
			vt_StudentCol:="\t"+"Nombre Alumno"+"\t"+"Valor Anual de Colegiatura"+"\r"
			GOTO RECORD:C242([Personas:7];alBWR_recordNumber{abrSelect{1}})
			LOAD RECORD:C52([Personas:7])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			ORDER BY:C49([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1)
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			For ($i;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				$sumaCargos:=0
				$nomAlu:=""
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>$iniDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<$endDate;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Glosa:12#"Matrícula@")
				$sumaCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				$nomAlu:=[Alumnos:2]Nombres:2
				vt_StudentCol:=vt_StudentCol+String:C10($i)+".-"+"\t"+$nomAlu+"\t"+String:C10($sumaCargos;"|Despliegue_ACT")+"\r"
				$valorColAnual:=$valorColAnual+$sumaCargos
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			$0:=Substring:C12(vt_StudentCol;1;Length:C16(vt_StudentCol)-1)
			If ($2=1)
				$0:=String:C10($valorColAnual;"|Despliegue_ACT")
			End if 
		End if 
	End if 
End if 