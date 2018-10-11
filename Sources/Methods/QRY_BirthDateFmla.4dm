//%attributes = {}
  //QRY_BirthDateFmla

READ ONLY:C145(yBWR_CurrentTable->)
$table:=Table:C252(yBWR_CurrentTable)
$set:="$RecordSet_Table"+String:C10($table)
C_TEXT:C284($vs_Cumpleaños1;$vs_Cumpleaños2)

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_busqueda_cumpleaños";7;4;__ ("Cumpleaños"))
DIALOG:C40([xxSTR_Constants:1];"STR_busqueda_cumpleaños")
CLOSE WINDOW:C154
If (ok=1)
	Case of 
		: (vb_Hoy=1)
			$vs_Cumpleaños1:=String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
			$vs_Cumpleaños2:=String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
		: (vb_Semana=1)
			$vs_Cumpleaños1:=Substring:C12(vt_Semana;4;2)+Substring:C12(vt_Semana;1;2)
			$vs_Cumpleaños2:=Substring:C12(vt_Semana;13;2)+Substring:C12(vt_Semana;10;2)
		: (vb_Mes=1)
			$vs_Cumpleaños1:=String:C10(vl_Mes;"00")+"01"
			$vs_Cumpleaños2:=String:C10(vl_Mes;"00")+"31"
		: (vb_Periodo=1)
			$vs_Cumpleaños1:=String:C10(Month of:C24(dDate1);"00")+String:C10(Day of:C23(dDate1);"00")
			$vs_Cumpleaños2:=String:C10(Month of:C24(dDate2);"00")+String:C10(Day of:C23(dDate2);"00")
		: (vb_Rangofecha=1)
			$vs_Cumpleaños1:=String:C10(vl_Mes1;"00")+String:C10(vl_dia1;"00")
			$vs_Cumpleaños2:=String:C10(vl_Mes2;"00")+String:C10(vl_dia2;"00")
	End case 
	
	If (($vs_Cumpleaños1#"") & ($vs_Cumpleaños2#""))
		MESSAGES OFF:C175
		$UITher:=IT_UThermometer (1;0;__ ("Buscando..."))
		If (cbSearchSelection=1)
			USE SET:C118($set)
			Case of 
				: ($table=2)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=vl_nivel1;*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=vl_nivel2)
			End case 
		Else 
			Case of 
				: ($table=2)
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=vl_nivel1;*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=vl_nivel2)
				Else 
					ALL RECORDS:C47(yBWR_CurrentTable->)
			End case 
		End if 
		
		  // MOD Ticket N° 168927 Patricio Aliaga 20180822
		If (l_inactivos=0)
			Case of 
				: ($table=7)
					QUERY SELECTION:C341([Personas:7];[Personas:7]Inactivo:46=False:C215)
				: ($table=2)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="activo")
				: ($table=4)
					QUERY SELECTION:C341([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
			End case 
		End if 
		
		ARRAY LONGINT:C221($al_recNum;0)
		ARRAY LONGINT:C221($al_fecha;0)
		ARRAY DATE:C224($ad_fecha;0)
		ARRAY LONGINT:C221($al_result;0)
		Case of 
			: ($table=7)
				SELECTION TO ARRAY:C260([Personas:7];$al_recNum;[Personas:7]Fecha_de_nacimiento:5;$ad_fecha)
				For ($i;1;Size of array:C274($ad_fecha))
					APPEND TO ARRAY:C911($al_fecha;Num:C11(String:C10(Month of:C24($ad_fecha{$i});"00")+String:C10(Day of:C23($ad_fecha{$i});"00")))
				End for 
				For ($i;1;Size of array:C274($ad_fecha))
					If (($al_fecha{$i}>=Num:C11($vs_Cumpleaños1)) & ($al_fecha{$i}<=Num:C11($vs_Cumpleaños2)))
						APPEND TO ARRAY:C911($al_result;$al_recNum{$i})
					End if 
				End for 
				
			: ($table=2)
				SELECTION TO ARRAY:C260([Alumnos:2];$al_recNum;[Alumnos:2]Fecha_de_nacimiento:7;$ad_fecha)
				For ($i;1;Size of array:C274($ad_fecha))
					APPEND TO ARRAY:C911($al_fecha;Num:C11(String:C10(Month of:C24($ad_fecha{$i});"00")+String:C10(Day of:C23($ad_fecha{$i});"00")))
				End for 
				For ($i;1;Size of array:C274($ad_fecha))
					If (($al_fecha{$i}>=Num:C11($vs_Cumpleaños1)) & ($al_fecha{$i}<=Num:C11($vs_Cumpleaños2)))
						APPEND TO ARRAY:C911($al_result;$al_recNum{$i})
					End if 
				End for 
				
			: ($table=4)
				SELECTION TO ARRAY:C260([Profesores:4];$al_recNum;[Profesores:4]Fecha_de_nacimiento:6;$ad_fecha)
				For ($i;1;Size of array:C274($ad_fecha))
					APPEND TO ARRAY:C911($al_fecha;Num:C11(String:C10(Month of:C24($ad_fecha{$i});"00")+String:C10(Day of:C23($ad_fecha{$i});"00")))
				End for 
				For ($i;1;Size of array:C274($ad_fecha))
					If (($al_fecha{$i}>=Num:C11($vs_Cumpleaños1)) & ($al_fecha{$i}<=Num:C11($vs_Cumpleaños2)))
						APPEND TO ARRAY:C911($al_result;$al_recNum{$i})
					End if 
				End for 
				
		End case 
		MESSAGES OFF:C175
		IT_UThermometer (-2;$UITher)
		If (Size of array:C274($al_result)=0)
			REDUCE SELECTION:C351(yBWR_CurrentTable->;0)
			BEEP:C151
		Else 
			CREATE SELECTION FROM ARRAY:C640(yBWR_CurrentTable->;$al_result)
		End if 
	End if 
End if 