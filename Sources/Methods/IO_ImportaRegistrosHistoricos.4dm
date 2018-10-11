//%attributes = {}
  //IO_ImportaRegistrosHistoricos

  //`xShell, Alberto Bachler
  //Metodo: IO_ImportaRegistrosHistoricos
  //Por abachler
  //Creada el 16/10/2003, 08:53:19
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($year;$versionID;$tables;$records;$tableNumber;$fieldNumber)

  //****INICIALIZACIONES****
$versionID:=2005



  //****CUERPO****

SET CHANNEL:C77(10;"")
If (ok=1)
	RECEIVE VARIABLE:C81($exportVersionID)
	If ($exportVersionID=$versionID)
		RECEIVE VARIABLE:C81($year)
		RECEIVE VARIABLE:C81($tables)
		For ($i;1;$tables)
			RECEIVE VARIABLE:C81($tableNumber)
			RECEIVE VARIABLE:C81($fieldNumber)
			RECEIVE VARIABLE:C81($records)
			$tablePointer:=Table:C252($tableNumber)
			$fieldPointer:=Field:C253($tableNumber;$fieldNumber)
			$tableName:=Table name:C256($tablePointer)
			READ WRITE:C146($tablePointer->)
			QUERY:C277($tablePointer->;$fieldPointer->>=$year)
			KRL_DeleteSelection ($tablePointer;False:C215)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros de la tabla ")+$tableName)
			For ($j;1;$records)
				KRL_ReceiveRecord ($tablePointer->)
				SAVE RECORD:C53($tablePointer->)
				If (Dec:C9($j/50)=0)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$j/$records;__ ("Importando registros de la tabla ")+$tableName+__ (" (")+String:C10($j)+__ ("/")+String:C10($records)+__ ("registros)"))
				End if 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End for 
	Else 
		CD_Dlog (0;__ ("Los registros exportados no son compatibles con esta versión de SchoolTrack."))
	End if 
	SET CHANNEL:C77(11)
End if 

  //****LIMPIEZA****





