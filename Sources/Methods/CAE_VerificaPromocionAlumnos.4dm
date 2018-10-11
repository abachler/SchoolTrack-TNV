//%attributes = {}
  //`Método: CAE_VerificaPromocionAlumnos


C_LONGINT:C283($i;$tab)
CREATE EMPTY SET:C140([Alumnos:2];"No promovidos")
QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelRegular)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
ARRAY LONGINT:C221(aQR_Longint1;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];aQR_Longint1;"")

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando alumnos no promovidos durante el cierre del año escolar..."))
For ($i;1;Size of array:C274(aQR_Longint1))
	GOTO RECORD:C242([Alumnos:2];aQR_Longint1{$i})
	QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=<>gYear-1;*)
	QUERY:C277([Alumnos_Historico:25]; & ;[Alumnos_Historico:25]Alumno_Numero:1=[Alumnos:2]numero:1)
	If (Records in selection:C76([Alumnos_Historico:25])=0)
		  //ADD TO SET([Alumnos];"No promovidos")
	Else 
		If ([Alumnos_Historico:25]Nivel:11=[Alumnos:2]nivel_numero:29)
			ADD TO SET:C119([Alumnos:2];"No promovidos")
		End if 
	End if 
	
	
	GOTO RECORD:C242([Alumnos:2];aQR_Longint1{$i})
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear-1;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
	If (Records in selection:C76([Alumnos_SintesisAnual:210])=0)
		  //ADD TO SET([Alumnos];"No promovidos")
	Else 
		If ([Alumnos_SintesisAnual:210]NumeroNivel:6=[Alumnos:2]nivel_numero:29)
			ADD TO SET:C119([Alumnos:2];"No promovidos")
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


USE SET:C118("No promovidos")
SELECT LIST ITEMS BY REFERENCE:C630(vlXS_BrowserTab;2)
$tab:=Selected list items:C379(vlXS_BrowserTab)
GET LIST ITEM:C378(vlXS_BrowserTab;$tab;vlBWR_SelectedTableRef;vsBWR_selectedTableName)
yBWR_currentTable:=->[Alumnos:2]  //pointer to the default table displayed in browser    
CREATE SET:C116(yBWR_CurrentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
If (Records in selection:C76([Alumnos:2])>0)
	CD_Dlog (0;String:C10(Records in selection:C76([Alumnos:2]))+__ (" alumno(s) no fueron promovido(s) durante el último cierre del año escolar.\rSerán listado(s) en el explorador inmediatamente."))
	
Else 
	CD_Dlog (0;__ ("Todos los alumnos fueron promovidos durante el último cierre del año escolar"))
End if 

BWR_PanelSettings 
BWR_SelectTableData 

XS_SetInterface 
ALP_SetInterface (xALP_Browser)

