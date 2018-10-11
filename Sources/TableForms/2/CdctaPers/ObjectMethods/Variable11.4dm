If (False:C215)
	  //Object Method: xPL_List
	  //Written by  Alberto Bachler on 10/8/98
	  //Module: 
	  //Purpose: 
	  //Syntax: Object  xPL_List()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	  //ST_v461:=False  `10/8/98 at 04:50:27 by: Alberto Bachler
	  // implementación  de bimestres
	C_LONGINT:C283($i)
End if 


  //DECLARATIONS


  //INITIALIZATION


_O_C_INTEGER:C282($per_ind)
  //ARRAY INTEGER(aCont;0)  //20121114 ASM agregue una nueva columna para manejar el formato del PL_SetBrkText
  //MAIN CODE
If (Form event:C388=On Load:K2:1)
	ARRAY LONGINT:C221(al_Cont;0)  //20130513 ASM 
	PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	Case of 
		: (vt_PLConfigMessage="Inasistencias")
			  //Se crea este set para acumular las faltas, atrasos, anotaciones, de cada semestre y no preguntar por todo el año ya que las fechas intermedias de cda periodo pueden variar
			CREATE EMPTY SET:C140([Alumnos_Inasistencias:10];"Inasistencias")
			
			For ($per_ind;1;Size of array:C274(adSTR_Periodos_Desde))
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1>=adSTR_Periodos_Desde{$per_ind};*)
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1<=adSTR_Periodos_Hasta{$per_ind})
				CREATE SET:C116([Alumnos_Inasistencias:10];"Temp")
				UNION:C120("Temp";"Inasistencias";"Inasistencias")
			End for 
			
			USE SET:C118("Inasistencias")
			CLEAR SET:C117("Temp")
			CLEAR SET:C117("Inasistencias")
			
			ORDER BY:C49([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1;>)  // 20130408 ASM Ordenamiento por fecha.
			SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Fecha:1;aDate1;[Alumnos_Inasistencias:10]Justificación:2;aText1;[Alumnos_Inasistencias:10]Observaciones:3;aText2)
			ARRAY TEXT:C222(aText4;Size of array:C274(aDate1))
			ARRAY LONGINT:C221(al_Cont;Size of array:C274(aDate1))
			For ($i;1;Size of array:C274(aDate1))
				Case of 
					: ((aDate1{$i}>=adSTR_Periodos_Desde{1}) & (aDate1{$i}<=adSTR_Periodos_Hasta{1}))
						aText4{$i}:=atSTR_Periodos_Nombre{1}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{2}) & (aDate1{$i}<=adSTR_Periodos_Hasta{2}))
						aText4{$i}:=atSTR_Periodos_Nombre{2}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{3}) & (aDate1{$i}<=adSTR_Periodos_Hasta{3}))
						aText4{$i}:=atSTR_Periodos_Nombre{3}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{4}) & (aDate1{$i}<=adSTR_Periodos_Hasta{4}))
						aText4{$i}:=atSTR_Periodos_Nombre{4}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{5}) & (aDate1{$i}<=adSTR_Periodos_Hasta{5}))
						aText4{$i}:=atSTR_Periodos_Nombre{5}
					Else 
						aText4{$i}:="Periodo ??"
				End case 
				al_Cont{$i}:=$i
			End for 
			
			$err:=PL_SetArraysNam (Self:C308->;1;5;"al_Cont";"aDate1";"aText1";"aText2";"aText4")
			PL_SetWidths (Self:C308->;1;4;30;80;135;200)
			PL_SetHeaders (Self:C308->;1;4;"Nº";"Fecha";"Justificación.";"Observaciones")
			PL_SetSort (Self:C308->;5;1)
			PL_SetColOpts (Self:C308->;1)
			PL_SetFormat (Self:C308->;1;"|Entero";1;0;0)
		: (vt_PLConfigMessage="Atrasos")
			
			  //Se crea este set para acumular las faltas, atrasos, anotaciones, de cada semestre y no preguntar por todo el año ya que las fechas intermedias de cda periodo pueden variar
			CREATE EMPTY SET:C140([Alumnos_Atrasos:55];"Atrasos")
			
			For ($per_ind;1;Size of array:C274(adSTR_Periodos_Desde))
				QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2>=adSTR_Periodos_Desde{$per_ind};*)
				QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2<=adSTR_Periodos_Hasta{$per_ind})
				
				CREATE SET:C116([Alumnos_Atrasos:55];"Temp")
				UNION:C120("Temp";"Atrasos";"Atrasos")
			End for 
			
			USE SET:C118("Atrasos")
			CLEAR SET:C117("Temp")
			CLEAR SET:C117("Atrasos")
			
			ORDER BY:C49([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2;>)  // 20130408 ASM Ordenamiento por fecha.
			SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Fecha:2;aDate1;[Alumnos_Atrasos:55]Observaciones:3;aText2)
			ARRAY TEXT:C222(aText4;Size of array:C274(aDate1))
			ARRAY LONGINT:C221(al_Cont;Size of array:C274(aDate1))
			For ($i;1;Size of array:C274(aDate1))
				Case of 
					: ((aDate1{$i}>=adSTR_Periodos_Desde{1}) & (aDate1{$i}<=adSTR_Periodos_Hasta{1}))
						aText4{$i}:=atSTR_Periodos_Nombre{1}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{2}) & (aDate1{$i}<=adSTR_Periodos_Hasta{2}))
						aText4{$i}:=atSTR_Periodos_Nombre{2}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{3}) & (aDate1{$i}<=adSTR_Periodos_Hasta{3}))
						aText4{$i}:=atSTR_Periodos_Nombre{3}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{4}) & (aDate1{$i}<=adSTR_Periodos_Hasta{4}))
						aText4{$i}:=atSTR_Periodos_Nombre{4}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{5}) & (aDate1{$i}<=adSTR_Periodos_Hasta{5}))
						aText4{$i}:=atSTR_Periodos_Nombre{5}
					Else 
						aText4{$i}:="Periodo ??"
				End case 
				al_Cont{$i}:=$i
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;4;"al_Cont";"aDate1";"aText2";"aText4")
			PL_SetWidths (Self:C308->;1;3;30;80;470)
			PL_SetHeaders (Self:C308->;1;3;"Nº";"Fecha";"Observaciones")
			PL_SetSort (Self:C308->;4;1)
			PL_SetColOpts (Self:C308->;1)
			PL_SetFormat (Self:C308->;1;"|Entero";1;0;0)
			
		: (vt_PLConfigMessage="Anotaciones")
			
			  //Se crea este set para acumular las faltas, atrasos, anotaciones, de cada semestre y no preguntar por todo el año ya que las fechas intermedias de cda periodo pueden variar
			CREATE EMPTY SET:C140([Alumnos_Anotaciones:11];"Anotaciones")
			
			For ($per_ind;1;Size of array:C274(adSTR_Periodos_Desde))
				
				QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Fecha:1>=adSTR_Periodos_Desde{$per_ind};*)
				QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Fecha:1<=adSTR_Periodos_Hasta{$per_ind})
				
				CREATE SET:C116([Alumnos_Anotaciones:11];"Temp")
				UNION:C120("Temp";"Anotaciones";"Anotaciones")
			End for 
			
			USE SET:C118("Anotaciones")
			CLEAR SET:C117("Temp")
			CLEAR SET:C117("Anotaciones")
			
			ORDER BY:C49([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Fecha:1;>)  // 20130408 ASM Ordenamiento por fecha.
			SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Fecha:1;aDate1;[Alumnos_Anotaciones:11]Motivo:3;aText1;[Alumnos_Anotaciones:11]Observaciones:4;aText2;[Alumnos_Anotaciones:11]Signo:7;aText3;[Profesores:4]Nombre_comun:21;aProfName;[Alumnos_Anotaciones:11]Categoria:8;aText5)
			ARRAY TEXT:C222(aText4;Size of array:C274(aDate1))
			ARRAY LONGINT:C221(al_Cont;Size of array:C274(aDate1))
			For ($i;1;Size of array:C274(aDate1))
				Case of 
					: ((aDate1{$i}>=adSTR_Periodos_Desde{1}) & (aDate1{$i}<=adSTR_Periodos_Hasta{1}))
						aText4{$i}:=atSTR_Periodos_Nombre{1}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{2}) & (aDate1{$i}<=adSTR_Periodos_Hasta{2}))
						aText4{$i}:=atSTR_Periodos_Nombre{2}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{3}) & (aDate1{$i}<=adSTR_Periodos_Hasta{3}))
						aText4{$i}:=atSTR_Periodos_Nombre{3}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{4}) & (aDate1{$i}<=adSTR_Periodos_Hasta{4}))
						aText4{$i}:=atSTR_Periodos_Nombre{4}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{5}) & (aDate1{$i}<=adSTR_Periodos_Hasta{5}))
						aText4{$i}:=atSTR_Periodos_Nombre{5}
					Else 
						aText4{$i}:="Periodo ??"
				End case 
				al_Cont{$i}:=$i
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;7;"al_Cont";"aDate1";"aText5";"aText1";"aText2";"aProfName";"aText4")
			PL_SetWidths (Self:C308->;1;7;30;55;55;100;170;70;90)
			PL_SetHeaders (Self:C308->;1;6;"Nº";"Fecha";"Categoría";"Motivo";"Observaciones";"Profesor")
			PL_SetFormat (Self:C308->;5;"";0)
			PL_SetSort (Self:C308->;7;1)
			PL_SetColOpts (Self:C308->;1)
			PL_SetFormat (Self:C308->;1;"|Entero";1;0;0)
			
		: (vt_PLConfigMessage="Castigos")
			  //Se crea este set para acumular las faltas, atrasos, anotaciones, de cada semestre y no preguntar por todo el año ya que las fechas intermedias de cda periodo pueden variar
			CREATE EMPTY SET:C140([Alumnos_Castigos:9];"Castigos")
			
			For ($per_ind;1;Size of array:C274(adSTR_Periodos_Desde))
				QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Fecha:9>=adSTR_Periodos_Desde{$per_ind};*)
				QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Fecha:9<=adSTR_Periodos_Hasta{$per_ind})
				CREATE SET:C116([Alumnos_Castigos:9];"Temp")
				UNION:C120("Temp";"Castigos";"Castigos")
			End for 
			
			USE SET:C118("Castigos")
			CLEAR SET:C117("Temp")
			CLEAR SET:C117("Castigos")
			
			ORDER BY:C49([Alumnos_Castigos:9];[Alumnos_Castigos:9]Fecha:9;>)  // 20130408 ASM Ordenamiento por fecha.
			SELECTION TO ARRAY:C260([Alumnos_Castigos:9]Fecha:9;aDate1;[Alumnos_Castigos:9]Motivo:2;aText1;[Alumnos_Castigos:9]Observaciones:3;aText2;[Alumnos_Castigos:9]Horas_de_castigo:7;aInt2;[Alumnos_Castigos:9]Castigo_cumplido:4;aBool1;[Profesores:4]Nombre_comun:21;aProfName)
			ARRAY TEXT:C222(aText4;Size of array:C274(aDate1))
			ARRAY LONGINT:C221(al_Cont;Size of array:C274(aDate1))
			For ($i;1;Size of array:C274(aDate1))
				Case of 
					: ((aDate1{$i}>=adSTR_Periodos_Desde{1}) & (aDate1{$i}<=adSTR_Periodos_Hasta{1}))
						aText4{$i}:=atSTR_Periodos_Nombre{1}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{2}) & (aDate1{$i}<=adSTR_Periodos_Hasta{2}))
						aText4{$i}:=atSTR_Periodos_Nombre{2}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{3}) & (aDate1{$i}<=adSTR_Periodos_Hasta{3}))
						aText4{$i}:=atSTR_Periodos_Nombre{3}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{4}) & (aDate1{$i}<=adSTR_Periodos_Hasta{4}))
						aText4{$i}:=atSTR_Periodos_Nombre{4}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{5}) & (aDate1{$i}<=adSTR_Periodos_Hasta{5}))
						aText4{$i}:=atSTR_Periodos_Nombre{5}
					Else 
						aText4{$i}:="Periodo ??"
				End case 
				al_Cont{$i}:=$i
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;8;"al_Cont";"aDate1";"aText1";"aText2";"aInt2";"aBool1";"aProfName";"aText4")
			PL_SetWidths (Self:C308->;1;7;30;60;165;135;20;20;100)
			PL_SetHeaders (Self:C308->;1;7;"Nº";"Fecha";"Motivo";"Observaciones";"Hr.";"OK";"Profesor")
			PL_SetFormat (Self:C308->;4;"";0)
			PL_SetFormat (Self:C308->;6;"Sí;No";2)
			PL_SetSort (Self:C308->;8;1)
			PL_SetColOpts (Self:C308->;1)
			PL_SetFormat (Self:C308->;1;"|Entero";1;0;0)
			PL_SetFormat (Self:C308->;5;"|Entero";1;0;0)
		: (vt_PLConfigMessage="Suspensiones")
			
			  //Se crea este set para acumular las faltas, atrasos, anotaciones, de cada semestre y no preguntar por todo el año ya que las fechas intermedias de cda periodo pueden variar
			CREATE EMPTY SET:C140([Alumnos_Suspensiones:12];"Suspensiones")
			
			For ($per_ind;1;Size of array:C274(adSTR_Periodos_Desde))
				QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Desde:5>=adSTR_Periodos_Desde{$per_ind};*)
				QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Desde:5<=adSTR_Periodos_Hasta{$per_ind})
				CREATE SET:C116([Alumnos_Suspensiones:12];"Temp")
				UNION:C120("Temp";"Suspensiones";"Suspensiones")
			End for 
			
			USE SET:C118("Suspensiones")
			CLEAR SET:C117("Temp")
			CLEAR SET:C117("Suspensiones")
			
			ORDER BY:C49([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Desde:5;>)  // 20130408 ASM Ordenamiento por fecha.
			SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12]Desde:5;aDate1;[Alumnos_Suspensiones:12]Hasta:6;aDate2;[Alumnos_Suspensiones:12]Motivo:2;aText1;[Alumnos_Suspensiones:12]Observaciones:8;aText2;[Profesores:4]Nombre_comun:21;aProfName)
			ARRAY TEXT:C222(aText4;Size of array:C274(aDate1))
			ARRAY LONGINT:C221(al_Cont;Size of array:C274(aDate1))
			For ($i;1;Size of array:C274(aDate1))
				Case of 
					: ((aDate1{$i}>=adSTR_Periodos_Desde{1}) & (aDate1{$i}<=adSTR_Periodos_Hasta{1}))
						aText4{$i}:=atSTR_Periodos_Nombre{1}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{2}) & (aDate1{$i}<=adSTR_Periodos_Hasta{2}))
						aText4{$i}:=atSTR_Periodos_Nombre{2}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{3}) & (aDate1{$i}<=adSTR_Periodos_Hasta{3}))
						aText4{$i}:=atSTR_Periodos_Nombre{3}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{4}) & (aDate1{$i}<=adSTR_Periodos_Hasta{4}))
						aText4{$i}:=atSTR_Periodos_Nombre{4}
					: ((aDate1{$i}>=adSTR_Periodos_Desde{5}) & (aDate1{$i}<=adSTR_Periodos_Hasta{5}))
						aText4{$i}:=atSTR_Periodos_Nombre{5}
					Else 
						aText4{$i}:="Periodo ??"
				End case 
				al_Cont{$i}:=$i
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;7;"al_Cont";"aDate1";"aDate2";"aText1";"aText2";"aProfName";"aText4")
			PL_SetWidths (Self:C308->;1;6;30;60;60;160;150;100)
			PL_SetHeaders (Self:C308->;1;6;"Nº";"Desde";"Hasta";"Motivo";"Observaciones";"Profesor")
			PL_SetSort (Self:C308->;7;1)
			PL_SetColOpts (Self:C308->;1)
			PL_SetFormat (Self:C308->;1;"|Entero";1;0;0)
			
	End case 
	For ($i;1;Size of array:C274(aText2))
		Case of   //para contornar un bug de dimensionamiento de la celda en PrintList
			: (Length:C16(aText2{$i})>300)
				aText2{$i}:=aText2{$i}+"\r\r\r"
			: (Length:C16(aText2{$i})>200)
				aText2{$i}:=aText2{$i}+"\r\r"
			: (Length:C16(aText2{$i})>100)
				aText2{$i}:=aText2{$i}+"\r\r"
			: (aText2{$i}#"")
				aText2{$i}:=aText2{$i}+"\r"
		End case 
	End for 
	
	PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
	PL_SetHdrStyle (Self:C308->;0;"Tahoma";8;1)
	PL_SetHdrOpts (Self:C308->;2)
	PL_SetHeight (Self:C308->;2;1;0;4)
	PL_SetDividers (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetBrkStyle (Self:C308->;1;0;"Tahoma";10;1)
	PL_SetBrkRowDiv (Self:C308->;1.25;"Black";"Black";0)
	PL_SetBrkHeight (Self:C308->;1;1;2)
	
	  //20121106 RCH Se cambia funcion porque el formato de los numeros no era correcto para numeros inferiores a 10
	  //en todos los PL_SetArraysNam se asigna valor al arreglo aDate1 
	  //PL_SetBrkText (Self->;1;1;"\\Breakvalue: "+String(Size of array(aDate1));2;1)
	  // Modificado por: Saúl Ponce (09/12/2017) Ticket Nº 193052, después de totalizar los brake, se ponía el correlativo más un cero, añadí esto para dar formato específico a la columna
	PL_SetFormat (Self:C308->;1;"##0";1;2)
	  // Modificado por: Saúl Ponce (09/12/2017) Ticket Nº 193052, para totalizar correctamente el valor de cada brake
	PL_SetBrkText (Self:C308->;1;1;" \\BreakValue: \\Count";3)
	PL_SetBrkColOpt (Self:C308->;0;0;1;1;"Black";"Black";0)
	PL_SetBrkStyle (Self:C308->;0;0;"Tahoma";10;1)
	
	$vl_Total:=0
	AL_LeeSintesisConducta ([Alumnos:2]numero:1)
	If (bCondicional=1)
		sCondicion:="Matricula condicional hasta "+String:C10(vd_fechaCondicionalidad)+$cr+"Condicion: "+vt_motivoCondicionalidad
	Else 
		sCondicion:=""
	End if 
	vjustified:=$vl_Total
	
End if 

  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 










