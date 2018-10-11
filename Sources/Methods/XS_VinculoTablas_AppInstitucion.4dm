//%attributes = {}
  // XS_VinculoTablas_AppInstitucion()
  // Por: Alberto Bachler K.: 29-08-14, 12:37:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_eventoTrigger;$l_nivelTrigger;$l_numeroTabla;$l_recNum;$l_result)
C_POINTER:C301($y_tabla)

$l_nivelTrigger:=Trigger level:C398
TRIGGER PROPERTIES:C399($l_nivelTrigger;$l_eventoTrigger;$l_numeroTabla;$l_recNum)
If ($l_nivelTrigger=1)
	XS_MapeoTablas_AppColegio 
	Case of 
		: ($l_numeroTabla=<>lApplicationCustomerTable)
			READ WRITE:C146([xShell_ApplicationData:45])
			If (Trigger event:C369=On Deleting Record Event:K3:3)
				ALL RECORDS:C47([xShell_ApplicationData:45])
				DELETE SELECTION:C66([xShell_ApplicationData:45])
			Else 
				ALL RECORDS:C47([xShell_ApplicationData:45])
				If (Records in selection:C76([xShell_ApplicationData:45])=0)
					CREATE RECORD:C68([xShell_ApplicationData:45])
					[xShell_ApplicationData:45]ProductName:16:="Main"
				Else 
					FIRST RECORD:C50([xShell_ApplicationData:45])
				End if 
				For ($i;1;Size of array:C274(<>aApplicationTableLinks))
					<>aXS_DLTable{$i}->:=<>aApplicationTableLinks{$i}->
				End for 
				SAVE RECORD:C53([xShell_ApplicationData:45])
				KRL_ReloadAsReadOnly (->[xShell_ApplicationData:45])
			End if 
			
			
		: ($l_numeroTabla=Table:C252(->[xShell_ApplicationData:45]))
			$y_tabla:=Table:C252(<>lApplicationCustomerTable)
			READ WRITE:C146($y_tabla->)
			If (Trigger event:C369=On Deleting Record Event:K3:3)
				  //20141107 ASM. Se comenta porque en algunos casos se estaba eliminando el registro de la tabla [colegios].
				  //ALL RECORDS($y_tabla->)
				  //DELETE SELECTION($y_tabla->)
			Else 
				ALL RECORDS:C47($y_tabla->)
				If (Records in selection:C76($y_tabla->)=0)
					CREATE RECORD:C68($y_tabla->)
				Else 
					FIRST RECORD:C50($y_tabla->)
				End if 
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_result)
				QUERY:C277([xShell_ApplicationData:45];[xShell_ApplicationData:45]UUID:31#"")
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($l_result#0)
					For ($i;1;Size of array:C274(<>aApplicationTableLinks))
						<>aApplicationTableLinks{$i}->:=<>aXS_DLTable{$i}->
					End for 
				End if 
				SAVE RECORD:C53($y_tabla->)
				KRL_ReloadAsReadOnly ($y_tabla)
			End if 
	End case 
End if 