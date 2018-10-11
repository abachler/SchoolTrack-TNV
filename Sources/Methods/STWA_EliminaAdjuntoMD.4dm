//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 29-03-17, 09:40:48
  // ----------------------------------------------------
  // Método: STWA_EliminaAdjuntoMD
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_BOOLEAN:C305($b_ok)
C_LONGINT:C283($i;$l_locked;$l_respuesta)

ARRAY LONGINT:C221($al_RnAdjuntosEliminar;0)

READ WRITE:C146([Asignaturas_Adjuntos:230])

$b_ok:=SR_SeleccionaFecha 
If ($b_ok)
	QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]fecha_adjunto:5>=vinidate;*)
	QUERY:C277([Asignaturas_Adjuntos:230]; & ;[Asignaturas_Adjuntos:230]fecha_adjunto:5<=venddate)
	
	If (Records in selection:C76([Asignaturas_Adjuntos:230])>0)
		$l_respuesta:=CD_Dlog (1;__ ("Se eliminarán ")+String:C10(Records in selection:C76([Asignaturas_Adjuntos:230]))+__ (" archivos de adjuntos ")+"\r"+__ ("¿Desea continuar?");"";__ ("Aceptar");__ ("Cancelar"))
		If ($l_respuesta=1)
			START TRANSACTION:C239
			KRL_RelateSelection (->[xShell_Documents:91]RelatedID:2;->[Asignaturas_Adjuntos:230]ID:1;"")
			SELECTION TO ARRAY:C260([xShell_Documents:91];$al_RnAdjuntosEliminar)
			DELETE SELECTION:C66([Asignaturas_Adjuntos:230])
			$l_locked:=Records in set:C195("LockedSet")
			If ($l_locked=0)
				For ($i;1;Size of array:C274($al_RnAdjuntosEliminar))
					XDOC_RemoveAttachedDocument ($al_RnAdjuntosEliminar{$i};"DocsGuias")
				End for 
				VALIDATE TRANSACTION:C240
				CD_Dlog (0;__ ("Eliminación de adjuntos de Material Docente exitosa."))
			Else 
				CANCEL TRANSACTION:C241
				CD_Dlog (0;__ ("Existen registros en uso. No es posible terminar el proceso de eliminación."))
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("No existen adjuntos de Material Docente para el rango de fecha seleccionado."))
	End if 
	
Else 
	CD_Dlog (0;__ ("Debe seleccionar un rango de fechas."))
End if 