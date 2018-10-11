READ ONLY:C145([xxSTR_DatosDeCierre:24])
ALL RECORDS:C47([xxSTR_DatosDeCierre:24])
ORDER BY:C49([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1;<)

WDW_OpenFormWindow (->[xxSTR_DatosDeCierre:24];"propiedades2";-1;8;__ ("Años Anteriores"))
DIALOG:C40([xxSTR_DatosDeCierre:24];"propiedades2")
CLOSE WINDOW:C154

If (ok=1)
	ARRAY LONGINT:C221($DA_Return;0)
	ab_ModificadoDC{0}:=True:C214
	AT_SearchArray (->ab_ModificadoDC;"=";->$DA_Return)
	If (Size of array:C274($DA_Return)>0)
		$p:=IT_UThermometer (1;0;__ ("Actualizando registros históricos…"))
		For ($i;1;Size of array:C274($DA_Return))
			KRL_GotoRecord (->[xxSTR_DatosDeCierre:24];al_RecNumDC{$DA_Return{$i}};True:C214)
			$modNombre:=([xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5#as_NombreYearDC{$DA_Return{$i}})
			[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=as_NombreYearDC{$DA_Return{$i}}
			[xxSTR_DatosDeCierre:24]FechaInicio:6:=ad_InicioDC{$DA_Return{$i}}
			[xxSTR_DatosDeCierre:24]FechaTermino:7:=ad_TerminoDC{$DA_Return{$i}}
			SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
			
			If ($modNombre)
				ARRAY TEXT:C222($aNombreAgno;0)
				READ WRITE:C146([Alumnos_Historico:25])
				QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=[xxSTR_DatosDeCierre:24]Year:1)
				$yearName:=[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5
				ARRAY TEXT:C222($aNombreAgno;Records in selection:C76([Alumnos_Historico:25]))
				AT_Populate (->$aNombreAgno;->$yearName)
				KRL_Array2Selection (->$aNombreAgno;->[Alumnos_Historico:25]NombreAgnoEscolar:37)
				KRL_UnloadReadOnly (->[Alumnos_Historico:25])
				
				READ WRITE:C146([Asignaturas_Historico:84])
				QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Año:5=[xxSTR_DatosDeCierre:24]Year:1)
				ARRAY TEXT:C222($aNombreAgno;Records in selection:C76([Asignaturas_Historico:84]))
				$yearName:=[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5
				AT_Populate (->$aNombreAgno;->$yearName)
				KRL_Array2Selection (->$aNombreAgno;->[Asignaturas_Historico:84]NombreAgnoEscolar:39)
				KRL_UnloadReadOnly (->[Asignaturas_Historico:84])
			End if 
			KRL_UnloadReadOnly (->[xxSTR_DatosDeCierre:24])
		End for 
		IT_UThermometer (-2;$p)
	End if 
End if 
ARRAY INTEGER:C220(ai_YearDC;0)
_O_ARRAY STRING:C218(31;as_NombreYearDC;0)
ARRAY DATE:C224(ad_InicioDC;0)
ARRAY DATE:C224(ad_TerminoDC;0)
ARRAY LONGINT:C221(al_RecNumDC;0)
ARRAY BOOLEAN:C223(ab_ModificadoDC;0)