//%attributes = {}
  // BBL_AccionesThesaurus()
  // Por: Alberto Bachler K.: 23-07-14, 19:46:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$i_registros;$l_elemento;$l_recNum;$l_respuesta;$l_tipoReferencia;$l_tipoRelacion)
C_TIME:C306($h_refDocumento)
C_POINTER:C301($y_materiaRelacionada;$y_notasAplicacion;$y_tipoRelacion)
C_TEXT:C284($t_accion)
C_OBJECT:C1216($ob_Materias)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_materias;0)

$t_accion:=$1


$y_tipoRelacion:=OBJECT Get pointer:C1124(Object named:K67:5;"tipoReferencia")
$y_materiaRelacionada:=OBJECT Get pointer:C1124(Object named:K67:5;"materiaRelacionada")
$y_notasAplicacion:=OBJECT Get pointer:C1124(Object named:K67:5;"notasAplicacion")

Case of 
	: ($t_accion="agregar")
		ARRAY TEXT:C222(at_CrossRefWord;0)
		ARRAY TEXT:C222(at_CrossRefType;0)
		CREATE SET:C116([BBL_Thesaurus:68];"$materiasEnLista")
		CUT NAMED SELECTION:C334([BBL_Thesaurus:68];"$NS_materiasEnLista")
		ARRAY TEXT:C222(at_CrossRefType;0)
		ARRAY TEXT:C222(at_CrossRefWord;0)
		FORM SET INPUT:C55([BBL_Thesaurus:68];"InputZero")
		WDW_OpenFormWindow (->[BBL_Thesaurus:68];"InputZero";-1;Movable form dialog box:K39:8;__ ("Thesaurus: Nuevo Encabezamiento"))
		ADD RECORD:C56([BBL_Thesaurus:68];*)
		CLOSE WINDOW:C154
		If (OK=1)
			KRL_ReloadAsReadOnly (->[BBL_Thesaurus:68])
			CREATE SET:C116([BBL_Thesaurus:68];"$materiasSeleccionadas")
			ADD TO SET:C119([BBL_Thesaurus:68];"$materiasEnLista")
			USE SET:C118("$materiasEnLista")
			ORDER BY:C49([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13)
			
			OBJECT SET VISIBLE:C603(*;"notasAplicacion";True:C214)
			OBJECT SET VISIBLE:C603(*;"tipoReferencia";True:C214)
			OBJECT SET VISIBLE:C603(*;"materiaRelacionada";True:C214)
		Else 
			USE NAMED SELECTION:C332("$NS_materiasEnLista")
			CREATE EMPTY SET:C140([BBL_Thesaurus:68];"$materiasSeleccionadas")
			OBJECT SET VISIBLE:C603(*;"notasAplicacion";False:C215)
			OBJECT SET VISIBLE:C603(*;"tipoReferencia";False:C215)
			OBJECT SET VISIBLE:C603(*;"materiaRelacionada";False:C215)
		End if 
		BBL_AccionesThesaurus ("detallesRegistro")
		
		
	: ($t_accion="editar")
		If (Records in set:C195("$materiasSeleccionadas")>0)
			ARRAY TEXT:C222(at_CrossRefWord;0)
			ARRAY TEXT:C222(at_CrossRefType;0)
			CUT NAMED SELECTION:C334([BBL_Thesaurus:68];"$NS_materiasEnLista")
			USE SET:C118("$materiasSeleccionadas")
			CREATE SET:C116([BBL_Thesaurus:68];"$l_materiaActual")
			USE SET:C118("$l_materiaActual")
			SF_Subtable2Array (->[BBL_Thesaurus:68]CrossRefs:3;->[BBL_Thesaurus]CrossRefs'References;->at_CrossRefWord)
			ARRAY TEXT:C222(at_CrossRefType;Size of array:C274(at_CrossRefWord))
			For ($i;1;Size of array:C274(at_CrossRefWord))
				$l_tipoReferencia:=Num:C11(Substring:C12(at_crossRefWord{$i};2;2))
				at_CrossRefType{$i}:=at_popCrossRefType{$l_tipoReferencia}
				at_crossRefWord{$i}:=Substring:C12(at_crossRefWord{$i};5)
			End for 
			WDW_OpenFormWindow (->[BBL_Thesaurus:68];"InputZero";-1;Movable form dialog box:K39:8;__ ("Materias"))
			KRL_ModifyRecord (->[BBL_Thesaurus:68];"InputZero")
			KRL_ReloadAsReadOnly (->[BBL_Thesaurus:68])
			USE NAMED SELECTION:C332("$NS_materiasEnLista")
			COPY SET:C600("$l_materiaActual";"$materiasSeleccionadas")
			BBL_AccionesThesaurus ("detallesRegistro")
		Else 
			BBL_AccionesThesaurus ("agregar")
		End if 
		
	: ($t_accion="eliminar")
		AT_Initialize ($y_tipoRelacion;$y_materiaRelacionada)
		CREATE SET:C116([BBL_Thesaurus:68];"$materiasEnLista")
		USE SET:C118("$materiasSeleccionadas")
		QRY_BusquedaTextosIndexados ([BBL_Thesaurus:68]Materia:13;->[BBL_Items:61]Materias_json:53;Contiene todas las palabras)
		BBL_BuscaMateriaEnItems ([BBL_Thesaurus:68]Materia:13)
		If (Records in selection:C76([BBL_Items:61])>0)
			$l_respuesta:=CD_Dlog (0;__ ("Este encabezado de materias es utilizado en algunos registros.\r¿Desea usted realmente eliminarlo?");__ ("");__ ("Si");__ ("No"))
		Else 
			$l_respuesta:=1
		End if 
		If ($l_respuesta=1)
			START TRANSACTION:C239
			LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
			For ($i_registros;1;Size of array:C274($al_RecNums))
				$l_recNum:=$al_RecNums{$i_registros}
				KRL_GotoRecord (->[BBL_Items:61];$l_recNum;True:C214)
				If (OK=1)
					$ob_Materias:=OB_JsonToObject ([BBL_Items:61]Materias_json:53)
					OB_GET ($ob_Materias;->$at_materias;"materiasCatalogacion_KW")
					$l_elemento:=Find in array:C230($at_materias;[BBL_Thesaurus:68]Materia:13)
					If ($l_elemento>0)
						DELETE FROM ARRAY:C228($at_materias;$l_elemento)
						$ob_Materias:=OB_Create 
						OB_SET ($ob_Materias;->$at_materias;"materiasCatalogacion_KW")
						[BBL_Items:61]Materias_json:53:=OB_Object2Json ($ob_Materias;True:C214)
						SAVE RECORD:C53([BBL_Items:61])
					End if 
				Else 
					$i_registros:=Size of array:C274($al_RecNums)
				End if 
			End for 
			
			If (OK=1)
				KRL_UnloadReadOnly (->[BBL_Items:61])
				KRL_DeleteRecord (->[BBL_Thesaurus:68])
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
				ModernUI_Notificacion (__ ("Eliminación de encabezado de materia");__ ("Un item que utiliza este encabezad está siendo editado\r\rEl encabezado de materia no puede ser eliminado");"OK")
			End if 
		End if 
		USE SET:C118("$materiasEnLista")
		ORDER BY:C49([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13)
		CREATE EMPTY SET:C140([BBL_Thesaurus:68];"$materiasSeleccionadas")
		
	: ($t_accion="imprimir@")
		CUT NAMED SELECTION:C334([BBL_Thesaurus:68];"$NS_materiasEnLista")
		If ($t_accion="imprimirSeleccion")
			USE SET:C118("$materiasSeleccionadas")
		Else 
			ALL RECORDS:C47([BBL_Thesaurus:68])
		End if 
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26="Thesaurus, Orden alfabetico";*)
		QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]MainTable:3;=;Table:C252(->[BBL_Thesaurus:68]))
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DSE")
		If (Records in selection:C76([xShell_Reports:54])>0)
			If (Macintosh option down:C545 | Windows Alt down:C563)
				ARRAY TEXT:C222(atQR_Filter;0)
				vb_NotInReportEditor:=True:C214
				vs_ReportName:=""
				vlQR_MainTable:=68
				vyQR_TablePointer:=->[BBL_Thesaurus:68]
				yBWR_currentTable:=->[BBL_Thesaurus:68]
				QR_EditQuickReportTemplate (->[BBL_Thesaurus:68])
			Else 
				$h_refDocumento:=Create document:C266("Thesaurus, Orden alfabetico")
				CLOSE DOCUMENT:C267($h_refDocumento)
				BLOB TO DOCUMENT:C526(document;[xShell_Reports:54]xReportData_:29)
				QR REPORT:C197([BBL_Thesaurus:68];document)
				DELETE DOCUMENT:C159(document)
			End if 
		Else 
			CD_Dlog (0;__ ("No se encontro el modelo de informe. No es posible imprimir el thesaurus."))
		End if 
		USE NAMED SELECTION:C332("$NS_materiasEnLista")
		
		
	: ($t_accion="detallesRegistro")
		If (Records in set:C195("$materiasSeleccionadas")>0)
			CUT NAMED SELECTION:C334([BBL_Thesaurus:68];"$materiasEnLista")
			USE SET:C118("$materiasSeleccionadas")
			CREATE SET:C116([BBL_Thesaurus:68];"$l_materiaActual")
			
			$y_notasAplicacion->:=[BBL_Thesaurus:68]Notas de aplicación:9
			QRY_BusquedaTextosIndexados ([BBL_Thesaurus:68]Materia:13;->[BBL_Items:61]Materias_json:53;Contiene todas las palabras)
			BBL_BuscaMateriaEnItems ([BBL_Thesaurus:68]Materia:13)
			(OBJECT Get pointer:C1124(Object named:K67:5;"usoMateria"))->:=String:C10(Records in selection:C76([BBL_Items:61]))+__ (" ítem(s) tiene(n) asignada la materia ")+IT_SetTextStyle_Bold (->[BBL_Thesaurus:68]Materia:13;True:C214)
			
			AT_Initialize ($y_tipoRelacion;$y_materiaRelacionada)
			SF_Subtable2Array (->[BBL_Thesaurus:68]CrossRefs:3;->[BBL_Thesaurus]CrossRefs'References;$y_materiaRelacionada)
			If (Size of array:C274($y_materiaRelacionada->)>0)
				ARRAY TEXT:C222($y_tipoRelacion->;Size of array:C274($y_materiaRelacionada->))
				For ($i;1;Size of array:C274($y_materiaRelacionada->))
					$l_tipoRelacion:=Num:C11(Substring:C12($y_materiaRelacionada->{$i};2;2))
					$y_tipoRelacion->{$i}:=at_popCrossRefType{$l_tipoRelacion}
					$y_materiaRelacionada->{$i}:=Substring:C12($y_materiaRelacionada->{$i};5)
				End for 
			End if 
			
			USE NAMED SELECTION:C332("$materiasEnLista")
			COPY SET:C600("$l_materiaActual";"$materiasSeleccionadas")
		End if 
End case 


