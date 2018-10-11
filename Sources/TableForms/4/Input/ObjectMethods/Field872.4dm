If ([Profesores:4]Es_Tutor:34=False:C215)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;False:C215;1;0)
	If (Old:C35([Profesores:4]Es_Tutor:34))
		QUERY:C277([Alumnos:2];[Alumnos:2]Tutor_numero:36=[Profesores:4]Numero:1)
		If (Records in selection:C76([Alumnos:2])>0)
			$msg:=__ ("^0 es tutor de uno o mas alumnos.\r¿Desea realmente eliminar esta tutoría?")
			$r:=CD_Dlog (0;Replace string:C233($msg;__ ("^0");[Profesores:4]Nombre_comun:21);__ ("");__ ("No");__ ("Sí"))
			If ($r=2)
				ARRAY LONGINT:C221(aLong1;0)
				ARRAY LONGINT:C221(aLong1;Records in selection:C76([Alumnos:2]))
				START TRANSACTION:C239
				OK:=KRL_Array2Selection (->aLong1;->[Alumnos:2]Tutor_numero:36)
				If (OK=1)
					VALIDATE TRANSACTION:C240
					$saved:=PF_fSave 
				Else 
					CANCEL TRANSACTION:C241
				End if 
			Else 
				[Profesores:4]Es_Tutor:34:=Old:C35([Profesores:4]Es_Tutor:34)
			End if 
		End if 
	End if 
Else 
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;True:C214;1;0)
	$saved:=PF_fSave 
End if 
_O_REDRAW LIST:C382(hlTab_STR_profesores)