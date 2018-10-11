
DEFAULT TABLE:C46([xxSTR_Niveles:6])

ARRAY TEXT:C222(at_OrdenAsignaturas;0)
ARRAY TEXT:C222(aSubjectName;0)

QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Consolidacion_Madre_Id:7=0)
  //QUERY SELECTION([Asignaturas];[Asignaturas]AsgConsol_ID=0)

SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;aSubjectName;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas)
SORT ARRAY:C229(aSubjectName;at_OrdenAsignaturas;>)
For ($k;Size of array:C274(aSubjectName);2;-1)
	If ((aSubjectName{$k-1}=aSubjectName{$k}))
		DELETE FROM ARRAY:C228(aSubjectName;$k)
		DELETE FROM ARRAY:C228(at_OrdenAsignaturas;$k)
	End if 
End for 
SORT ARRAY:C229(at_OrdenAsignaturas;aSubjectName;>)


vb_OrderModified:=False:C215
WDW_OpenFormWindow (->[xxSTR_Niveles:6];"OrdenSubsectores";9;Movable form dialog box:K39:8;__ ("Orden de subsectores en informes"))
DIALOG:C40([xxSTR_Niveles:6];"OrdenSubsectores")
CLOSE WINDOW:C154

If (vb_OrderModified)
	BLOB_Variables2Blob (->[xxSTR_Niveles:6]OrdenSubsectores:36;0;->at_OrdenAsignaturas;->aSubjectName)
	COMPRESS BLOB:C534([xxSTR_Niveles:6]OrdenSubsectores:36)
	SAVE RECORD:C53([xxSTR_Niveles:6])
	
	If (bApplyToClasses=1)
		READ WRITE:C146([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
		APPLY TO SELECTION:C70([Cursos:3];[Cursos:3]Orden_Subsectores:17:=[xxSTR_Niveles:6]OrdenSubsectores:36)
		READ WRITE:C146([Asignaturas:18])
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Asignando orden a las asignaturas del nivel..."))
		For ($i;1;Size of array:C274(at_OrdenAsignaturas))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]denominacion_interna:16=aSubjectName{$i};*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Consolidacion_Madre_nombre:8="")  //20112807 AS. se valida que las asignaturas sean solo Madres.
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
			For ($iRecNums;1;Size of array:C274($aRecNums))
				READ WRITE:C146([Asignaturas:18])
				GOTO RECORD:C242([Asignaturas:18];$aRecNums{$iRecNums})
				[Asignaturas:18]posicion_en_informes_de_notas:36:=Num:C11(at_OrdenAsignaturas{$i})
				[Asignaturas:18]ordenGeneral:105:=at_OrdenAsignaturas{$i}
				SAVE RECORD:C53([Asignaturas:18])
				AS_FijaNivelJeraquicoHijas (Record number:C243([Asignaturas:18]))
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aSubjectName))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		UNLOAD RECORD:C212([Asignaturas:18])
		READ ONLY:C145([Asignaturas:18])
		UNLOAD RECORD:C212([Cursos:3])
		READ ONLY:C145([Cursos:3])
	End if 
End if 