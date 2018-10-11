//%attributes = {}
  //SRal_EnfermeriaMeses

C_LONGINT:C283($1;$Informe)

If (Count parameters:C259=0)
	$Informe:=1
Else 
	$Informe:=$1
End if 

  //26.09.2014 Saúl Ponce O. Ticket 136964
  //Se cargaba siempre la configuración principal de períodos -1 dejando fuera eventos enfermería que se necesita considerar
  //PERIODOS_LoadData (0;-1) // comente esta línea
PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)  // añadí esta

SRal_FinEnfermeriaMeses 
$Periodos:=Size of array:C274(atSTR_Periodos_Nombre)
QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2>=adSTR_Periodos_Desde{1};*)
QUERY:C277([Alumnos_EventosEnfermeria:14]; & ;[Alumnos_EventosEnfermeria:14]Fecha:2<=adSTR_Periodos_Hasta{$Periodos})
CREATE SET:C116([Alumnos_EventosEnfermeria:14];"LasDelAño")

Case of 
	: ($Informe=1)  //Informe de visitas por mes para cada periodo
		$unlimitedThermo:=IT_UThermometer (1;0;__ ("Contando visitas por mes para cada período..."))
		For ($j;1;$Periodos)
			USE SET:C118("LasDelAño")
			QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2>=adSTR_Periodos_Desde{$j};*)
			QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14]; & ;[Alumnos_EventosEnfermeria:14]Fecha:2<=adSTR_Periodos_Hasta{$j})
			$TotalPeriodoPtr:=Get pointer:C304("vTot"+String:C10($j))
			$TotalPeriodoPtr->:=Records in selection:C76([Alumnos_EventosEnfermeria:14])
			If ($TotalPeriodoPtr->>0)
				CREATE SET:C116([Alumnos_EventosEnfermeria:14];"Periodo"+String:C10($j))
				$MesesPeriodoPtr:=Get pointer:C304("aENF_MesesP"+String:C10($j))
				$CantidadesPtr:=Get pointer:C304("aENF_CantidadesP"+String:C10($j))
				$PorcentajesPtr:=Get pointer:C304("aENF_PorcentajesP"+String:C10($j))
				AT_Insert (0;Month of:C24(adSTR_Periodos_Hasta{$j})-Month of:C24(adSTR_Periodos_Desde{$j})+1;$MesesPeriodoPtr;$CantidadesPtr;$PorcentajesPtr)
				$counter:=1
				For ($w;Month of:C24(adSTR_Periodos_Desde{$j});Month of:C24(adSTR_Periodos_Hasta{$j}))
					USE SET:C118("Periodo"+String:C10($j))
					SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;aFechas)
					ARRAY LONGINT:C221(aMes;Size of array:C274(aFechas))
					For ($temp;1;Size of array:C274(aFechas))
						aMes{$temp}:=Month of:C24(aFechas{$temp})
					End for 
					aMes{0}:=$w
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->aMes;"=";->$DA_Return)
					$MesesPeriodoPtr->{$counter}:=<>atXS_MonthNames{$w}
					$CantidadesPtr->{$counter}:=Size of array:C274($DA_Return)
					$PorcentajesPtr->{$counter}:=Round:C94(($CantidadesPtr->{$counter}/$TotalPeriodoPtr->)*100;2)
					$counter:=$counter+1
				End for 
				SET_ClearSets ("Periodo"+String:C10($j))
			End if 
		End for 
		IT_UThermometer (-2;$unlimitedThermo)
		
	: ($informe=2)  //Informe de visitas por nivel
		SRalENF_SeleccionPeriodo 
		If (OK=1)
			$unlimitedThermo:=IT_UThermometer (1;0;__ ("Contando visitas por sección..."))
			ARRAY LONGINT:C221(aCantidadXSeccion;Size of array:C274(<>aListSect))
			ARRAY REAL:C219(aPorcentajesXSeccion;Size of array:C274(<>aListSect))
			USE SET:C118("Selection")
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Alumno_Numero:1;aVisitasAlumnosID)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;"")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aAlumnosID;[Alumnos:2]Sección:26;$aAlumnosSeccion)
			$totalVisitas:=Size of array:C274(aVisitasAlumnosID)
			For ($x;1;Size of array:C274($aAlumnosID))
				aVisitasAlumnosID{0}:=$aAlumnosID{$x}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aVisitasAlumnosID;"=";->$DA_Return)
				$Cantidad:=Size of array:C274($DA_Return)
				$seccion:=Find in array:C230(<>aListSect;$aAlumnosSeccion{$x})
				If ($seccion=-1)
					AT_Insert (0;1;-><>aListSect;->aCantidadXSeccion;->aPorcentajesXSeccion)
					<>aListSect{Size of array:C274(<>aListSect)}:=$aAlumnosSeccion{$x}
					$seccion:=Size of array:C274(<>aListSect)
				End if 
				aCantidadXSeccion{$seccion}:=aCantidadXSeccion{$seccion}+$Cantidad
				For ($del;$Cantidad;1;-1)
					DELETE FROM ARRAY:C228(aVisitasAlumnosID;$DA_Return{$del};1)
				End for 
			End for 
			vTot5:=$totalVisitas
			For ($Percents;1;Size of array:C274(aCantidadXSeccion))
				aPorcentajesXSeccion{$Percents}:=Round:C94((aCantidadXSeccion{$Percents}/$totalVisitas)*100;2)
			End for 
			IT_UThermometer (-2;$unlimitedThermo)
		End if 
		
	: ($informe=3)  //Informe de visitas por dia
		SRalENF_SeleccionPeriodo 
		If (OK=1)
			$unlimitedThermo:=IT_UThermometer (1;0;__ ("Contando visitas por sección y ordenando por día de la semana..."))
			ARRAY LONGINT:C221(aLunes;Size of array:C274(<>aListSect))
			ARRAY LONGINT:C221(aMartes;Size of array:C274(<>aListSect))
			ARRAY LONGINT:C221(aMiercoles;Size of array:C274(<>aListSect))
			ARRAY LONGINT:C221(aJueves;Size of array:C274(<>aListSect))
			ARRAY LONGINT:C221(aViernes;Size of array:C274(<>aListSect))
			ARRAY LONGINT:C221(aSabado;Size of array:C274(<>aListSect))
			USE SET:C118("Selection")
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;$aFechas)
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Alumno_Numero:1;aVisitasAlumnosID)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;"")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aAlumnosID;[Alumnos:2]Sección:26;$aAlumnosSeccion)
			For ($u;1;Size of array:C274($aAlumnosID))
				aVisitasAlumnosID{0}:=$aAlumnosID{$u}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aVisitasAlumnosID;"=";->$DA_Return)
				$seccion:=Find in array:C230(<>aListSect;$aAlumnosSeccion{$u})
				If ($seccion=-1)
					AT_Insert (0;1;-><>aListSect;->aLunes;->aMartes;->aMiercoles;->aJueves;->aViernes;->aSabado)
					<>aListSect{Size of array:C274(<>aListSect)}:=$aAlumnosSeccion{$u}
					$seccion:=Size of array:C274(<>aListSect)
				End if 
				For ($rt;1;Size of array:C274($DA_Return))
					$viDay:=Day number:C114($aFechas{$DA_Return{$rt}})  // $viDay gets the current day number
					Case of 
						: ($viDay=1)
							  //domingo
						: ($viDay=2)
							aLunes{$seccion}:=aLunes{$seccion}+1
						: ($viDay=3)
							aMartes{$seccion}:=aMartes{$seccion}+1
						: ($viDay=4)
							aMiercoles{$seccion}:=aMiercoles{$seccion}+1
						: ($viDay=5)
							aJueves{$seccion}:=aJueves{$seccion}+1
						: ($viDay=6)
							aViernes{$seccion}:=aViernes{$seccion}+1
						: ($viDay=7)
							aSabado{$seccion}:=aSabado{$seccion}+1
					End case 
				End for 
			End for 
			IT_UThermometer (-2;$unlimitedThermo)
		End if 
		
	: ($informe=4)  //Informe de visitas por tipo de consulta
		SRalENF_SeleccionPeriodo 
		If (OK=1)
			$unlimitedThermo:=IT_UThermometer (1;0;__ ("Contando visitas por sección y ordenando por tipo de consulta..."))
			ARRAY LONGINT:C221(aMedica;Size of array:C274(<>aListSect))
			ARRAY LONGINT:C221(aDental;Size of array:C274(<>aListSect))
			ARRAY LONGINT:C221(aTraumatologica;Size of array:C274(<>aListSect))
			USE SET:C118("Selection")
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Alumno_Numero:1;aVisitasAlumnosID;[Alumnos_EventosEnfermeria:14]TipoConsulta:5;$aTipoConsulta)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;"")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aAlumnosID;[Alumnos:2]Sección:26;$aAlumnosSeccion)
			For ($u;1;Size of array:C274($aAlumnosID))
				aVisitasAlumnosID{0}:=$aAlumnosID{$u}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aVisitasAlumnosID;"=";->$DA_Return)
				$seccion:=Find in array:C230(<>aListSect;$aAlumnosSeccion{$u})
				If ($seccion=-1)
					AT_Insert (0;1;-><>aListSect;->aMedica;->aDental;->aTraumatologica)
					<>aListSect{Size of array:C274(<>aListSect)}:=$aAlumnosSeccion{$u}
					$seccion:=Size of array:C274(<>aListSect)
				End if 
				
				For ($rt;1;Size of array:C274($DA_Return))
					Case of 
						: ($aTipoConsulta{$DA_Return{$rt}}="Medica")
							aMedica{$seccion}:=aMedica{$seccion}+1
						: ($aTipoConsulta{$DA_Return{$rt}}="Dental")
							aDental{$seccion}:=aDental{$seccion}+1
						: ($aTipoConsulta{$DA_Return{$rt}}="Traumatológica")
							aTraumatologica{$seccion}:=aTraumatologica{$seccion}+1
					End case 
				End for 
			End for 
			IT_UThermometer (-2;$unlimitedThermo)
		End if 
		
	: ($informe=5)  //informe de visitas por hora
		ARRAY TEXT:C222(aDesdeStr;11)
		ARRAY TEXT:C222(aHastaStr;11)
		ARRAY LONGINT:C221(aDesde;11)
		ARRAY LONGINT:C221(aHasta;11)
		C_TIME:C306($tempHorasDesde;$tempHorasHasta)
		SRalENF_SeleccionPeriodo 
		If (OK=1)
			$unlimitedThermo:=IT_UThermometer (1;0;__ ("Contando visitas por sección y ordenando por hora..."))
			ARRAY POINTER:C280($aPtrs;Size of array:C274(aDesde))
			$tempHorasDesde:=?07:00:00?
			$tempHorasHasta:=?08:00:00?
			For ($horas;1;Size of array:C274(aDesde))
				$tempHorasDesde:=$tempHorasDesde+?01:00:00?
				$tempHorasHasta:=$tempHorasHasta+?01:00:00?
				aDesde{$horas}:=$tempHorasDesde*1
				aHasta{$horas}:=$tempHorasHasta*1
				aDesdeStr{$horas}:=String:C10($tempHorasDesde;2)
				aHastaStr{$horas}:=String:C10($tempHorasHasta;2)
				$aPtrs{$horas}:=Bash_Get_Array_By_Type (Is longint:K8:6)
				AT_DimArrays (Size of array:C274(<>aListSect);$aPtrs{$horas})
			End for 
			USE SET:C118("Selection")
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Alumno_Numero:1;aVisitasAlumnosID;[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;$aHoraIngreso)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;"")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aAlumnosID;[Alumnos:2]Sección:26;$aAlumnosSeccion)
			For ($u;1;Size of array:C274($aAlumnosID))
				aVisitasAlumnosID{0}:=$aAlumnosID{$u}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aVisitasAlumnosID;"=";->$DA_Return)
				$seccion:=Find in array:C230(<>aListSect;$aAlumnosSeccion{$u})
				If ($seccion=-1)
					AT_Insert (0;1;-><>aListSect)
					<>aListSect{Size of array:C274(<>aListSect)}:=$aAlumnosSeccion{$u}
					$seccion:=Size of array:C274(<>aListSect)
				End if 
				For ($rt;1;Size of array:C274($DA_Return))
					For ($horas;1;Size of array:C274(aDesde))
						If (($aHoraIngreso{$DA_Return{$rt}}>=aDesde{$horas}) & ($aHoraIngreso{$DA_Return{$rt}}<=aHasta{$horas}))
							$aPtrs{$horas}->{$seccion}:=$aPtrs{$horas}->{$seccion}+1
							$horas:=Size of array:C274(aDesde)+1
						End if 
					End for 
				End for 
			End for 
			For ($horas;1;Size of array:C274(aDesde))
				$array:=Get pointer:C304("aHora"+String:C10($horas))
				COPY ARRAY:C226($aPtrs{$horas}->;$array->)
				Bash_Return_Variable ($aPtrs{$horas})
			End for 
			IT_UThermometer (-2;$unlimitedThermo)
		End if 
		
	: ($informe=6)  //informe de visitas por lugar de procedencia
		SRalENF_SeleccionPeriodo 
		If (OK=1)
			$unlimitedThermo:=IT_UThermometer (1;0;__ ("Contando visitas por sección y ordenando por lugar de procedencia..."))
			ARRAY POINTER:C280($aPtrs;Size of array:C274(<>aProced))
			For ($i;1;Size of array:C274(<>aProced))
				$aPtrs{$i}:=Bash_Get_Array_By_Type (Is longint:K8:6)
				AT_DimArrays (Size of array:C274(<>aListSect);$aPtrs{$i})
			End for 
			USE SET:C118("Selection")
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Alumno_Numero:1;aVisitasAlumnosID;[Alumnos_EventosEnfermeria:14]Procedencia:4;$aProcedencia)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;"")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aAlumnosID;[Alumnos:2]Sección:26;$aAlumnosSeccion)
			For ($u;1;Size of array:C274($aAlumnosID))
				aVisitasAlumnosID{0}:=$aAlumnosID{$u}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aVisitasAlumnosID;"=";->$DA_Return)
				$seccion:=Find in array:C230(<>aListSect;$aAlumnosSeccion{$u})
				If ($seccion=-1)
					AT_Insert (0;1;-><>aListSect)
					<>aListSect{Size of array:C274(<>aListSect)}:=$aAlumnosSeccion{$u}
					$seccion:=Size of array:C274(<>aListSect)
					For ($i;1;Size of array:C274(<>aProced))
						AT_DimArrays (Size of array:C274(<>aListSect);$aPtrs{$i})
					End for 
				End if 
				For ($rt;1;Size of array:C274($DA_Return))
					For ($proc;1;Size of array:C274(<>aProced))
						If ($aProcedencia{$DA_Return{$rt}}=<>aProced{$proc})
							$aPtrs{$proc}->{$seccion}:=$aPtrs{$proc}->{$seccion}+1
						End if 
					End for 
				End for 
			End for 
			$s:=Size of array:C274(<>aProced)
			If ($s>32)
				$s:=32
			End if 
			For ($proc;1;$s)
				$array:=Get pointer:C304("aProcedencia"+String:C10($proc))
				COPY ARRAY:C226($aPtrs{$proc}->;$array->)
				Bash_Return_Variable ($aPtrs{$proc})
			End for 
			IT_UThermometer (-2;$unlimitedThermo)
		End if 
	: ($informe=7)  //informe de visitas por lugar de destino
		SRalENF_SeleccionPeriodo 
		If (OK=1)
			$unlimitedThermo:=IT_UThermometer (1;0;__ ("Contando visitas por sección y ordenando por lugar de destino..."))
			ARRAY POINTER:C280($aPtrs;Size of array:C274(<>aDest))
			For ($i;1;Size of array:C274(<>aDest))
				$aPtrs{$i}:=Bash_Get_Array_By_Type (Is longint:K8:6)
				AT_DimArrays (Size of array:C274(<>aListSect);$aPtrs{$i})
			End for 
			USE SET:C118("Selection")
			SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Alumno_Numero:1;aVisitasAlumnosID;[Alumnos_EventosEnfermeria:14]Destino:9;$aDestino)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_EventosEnfermeria:14]Alumno_Numero:1;"")
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aAlumnosID;[Alumnos:2]Sección:26;$aAlumnosSeccion)
			For ($u;1;Size of array:C274($aAlumnosID))
				aVisitasAlumnosID{0}:=$aAlumnosID{$u}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aVisitasAlumnosID;"=";->$DA_Return)
				$seccion:=Find in array:C230(<>aListSect;$aAlumnosSeccion{$u})
				If ($seccion=-1)
					AT_Insert (0;1;-><>aListSect)
					<>aListSect{Size of array:C274(<>aListSect)}:=$aAlumnosSeccion{$u}
					$seccion:=Size of array:C274(<>aListSect)
				End if 
				For ($rt;1;Size of array:C274($DA_Return))
					For ($dest;1;Size of array:C274(<>aDest))
						If ($aDestino{$DA_Return{$rt}}=<>aDest{$dest})
							$aPtrs{$dest}->{$seccion}:=$aPtrs{$dest}->{$seccion}+1
						End if 
					End for 
				End for 
			End for 
			$s:=Size of array:C274(<>aDest)
			If ($s>32)
				$s:=32
			End if 
			For ($dest;1;$s)
				$array:=Get pointer:C304("aDestino"+String:C10($dest))
				COPY ARRAY:C226($aPtrs{$dest}->;$array->)
				Bash_Return_Variable ($aPtrs{$dest})
			End for 
			IT_UThermometer (-2;$unlimitedThermo)
		End if 
End case 

SET_ClearSets ("LasDelAño";"Selection")