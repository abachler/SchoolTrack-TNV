//%attributes = {}
  // BBLci_ProcesaBarCode()
  // Por: Alberto Bachler: 17/09/13, 12:53:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($0)
C_TEXT:C284($1)

C_POINTER:C301($y_nil)
C_BOOLEAN:C305($b_conMiniatura)
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_abajo;$l_altoVentana;$l_arriba;$l_derecha;$l_indexPrefijoDocumento;$l_indexPrefijoLector;$l_indiceBarcode;$l_izquierda;$l_LectorBuscarSobreNombre;$l_LectorPalabraCompleta)
C_LONGINT:C283($l_LectorTipoBusquedaNombre;$l_recnum;$l_recNumLector;$l_recNumLectorActual;$l_recNumRegistro;$l_recNumRegistroActual;$l_refVentana;$l_resultado)
C_TEXT:C284($t_autor;$t_barcode;$t_barCodeSinPrefijo;$t_edicion;$t_grupo;$t_nombreItem;$t_nombreLector;$t_numeroCopia;$t_Prefijo;$t_refRegistro)

If (False:C215)
	C_LONGINT:C283(BBLci_ProcesaBarCode ;$0)
	C_TEXT:C284(BBLci_ProcesaBarCode ;$1)
End if 

ARRAY TEXT:C222($at_ReferenciasRegistros;0)


If (False:C215)
	C_LONGINT:C283(BBLci_ProcesaBarCode ;$0)
	C_TEXT:C284(BBLci_ProcesaBarCode ;$1)
End if 



$t_barcode:=$1
$l_recNumLector:=No current record:K29:2
$l_recNumRegistro:=No current record:K29:2
$l_resultado:=0



Case of 
	: ($t_barcode="0")
		$l_recNumLector:=No current record:K29:2
		$l_recNumRegistro:=No current record:K29:2
		REDUCE SELECTION:C351([BBL_Lectores:72];0)
		REDUCE SELECTION:C351([BBL_Items:61];0)
		REDUCE SELECTION:C351([BBL_Registros:66];0)
		$l_resultado:=0
		
	: (vl_modoConsola=Prestamo)
		$l_recNumLectorActual:=Record number:C243([BBL_Lectores:72])
		$l_recNumLector:=BBLci_BusquedaLector ($t_barcode)
		$l_recNumRegistro:=BBLci_BusquedaRegistro ($t_barcode)
		
		If ($l_recNumRegistro=No current record:K29:2)
			REDUCE SELECTION:C351([BBL_Items:61];0)
			REDUCE SELECTION:C351([BBL_Registros:66];0)
		End if 
		
		If (($l_recNumLector=No current record:K29:2) & ($l_recNumLectorActual>No current record:K29:2))
			KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLectorActual)
		End if 
		
	: ((vl_modoConsola=Devolucion) | (vl_modoConsola=Renovacion))
		$l_recNumRegistro:=BBLci_BusquedaRegistro ($t_barcode)
		
		
	: (vl_modoConsola=Reservas)
		$l_recNumLector:=BBLci_BusquedaLector ($t_barcode)
		
		
	: ((vl_modoConsola=Multa) | (vl_modoConsola=Pago))
		  //mono ticket 134899
		$l_recNumLector:=BBLci_BusquedaLector ($t_barcode)
		If (($l_recNumLector>No current record:K29:2))
			
			KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;True:C214)
			If (Not:C34(Locked:C147([BBL_Lectores:72])))
				BBLci_NuevaMulta_o_Pago ($l_recNumLector)
			Else 
				C_TEXT:C284($usr_mt;$sesion_usr_mt;$nombre_pro_mt)
				C_LONGINT:C283($process_mt)
				LOCKED BY:C353([BBL_Lectores:72];$process_mt;$usr_mt;$sesion_usr_mt;$nombre_pro_mt)
				CD_Dlog (0;__ ("El registro del lector está siendo utilizado por ")+$sesion_usr_mt+__ (" en otro proceso. No se realizaran acciones en el registro hasta que sea liberado"))
			End if 
			KRL_UnloadReadOnly (->[BBL_Lectores:72])
		End if 
		
	: (vl_modoConsola=Busqueda Lector)
		$l_recNumLector:=BBLci_BusquedaLector ($t_barcode)
		
		
End case 



If (($l_recNumLector>No current record:K29:2) & ($l_recNumRegistro>No current record:K29:2))
	$t_refRegistro:="L"+String:C10($l_recNumLector)
	If (Find in array:C230($at_ReferenciasRegistros;$t_refRegistro)=-1)
		APPEND TO ARRAY:C911($at_ReferenciasRegistros;$t_refRegistro)
	End if 
	
	$t_refRegistro:="D"+String:C10($l_recNumRegistro)
	If (Find in array:C230($at_ReferenciasRegistros;$t_refRegistro)=-1)
		APPEND TO ARRAY:C911($at_ReferenciasRegistros;$t_refRegistro)
	End if 
	
	
	If (Size of array:C274($at_ReferenciasRegistros)>1)
		$l_recNumLectorActual:=Record number:C243([BBL_Lectores:72])
		$l_recNumRegistroActual:=Record number:C243([BBL_Registros:66])
		ARRAY TEXT:C222(atBBL_CodigosBarra_nombre;Size of array:C274($at_ReferenciasRegistros))
		ARRAY PICTURE:C279(apBBL_CodigosBarra_imagen;Size of array:C274($at_ReferenciasRegistros))
		For ($i_registros;1;Size of array:C274($at_ReferenciasRegistros))
			$l_recnum:=Num:C11(Substring:C12($at_ReferenciasRegistros{$i_registros};2))
			Case of 
				: ($at_ReferenciasRegistros{$i_registros}="L@")
					GOTO RECORD:C242([BBL_Lectores:72];$l_recnum)
					$t_nombreLector:=ST_ClearSpaces ([BBL_Lectores:72]Apellido_paterno:12+" "+[BBL_Lectores:72]Apellido_materno:13+" "+[BBL_Lectores:72]Nombres:11)
					IT_SetTextStyle_Bold (->$t_nombreLector)
					IT_SetTextSize (->$t_nombreLector;13)
					IT_SetTextColor_Name (->$t_nombreLector;"Blue")
					$t_grupo:=[BBL_Lectores:72]Grupo:2
					IT_SetTextStyle_Bold (->$t_grupo)
					IT_SetTextSize (->$t_grupo;11)
					IT_SetTextColor_Name (->$t_grupo;"Black")
					atBBL_CodigosBarra_nombre{$i_registros}:=$t_nombreLector+"\r"+$t_grupo
					If (Picture size:C356([BBL_Lectores:72]Fotografia:32)>0)
						apBBL_CodigosBarra_imagen{$i_registros}:=[BBL_Lectores:72]Fotografia:32
					Else 
						Case of 
							: ([BBL_Lectores:72]Número_de_Profesor:30>0)
								apBBL_CodigosBarra_imagen{$i_registros}:=[Profesores:4]Fotografia:59
							: ([BBL_Lectores:72]Número_de_Persona:31>0)
								apBBL_CodigosBarra_imagen{$i_registros}:=[Personas:7]Fotografia:43
							: ([BBL_Lectores:72]Número_de_alumno:6>0)
								apBBL_CodigosBarra_imagen{$i_registros}:=[Alumnos:2]Fotografía:78
						End case 
					End if 
					If ($l_recNumRegistroActual>No current record:K29:2)
						KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistroActual)
					Else 
						REDUCE SELECTION:C351([BBL_Registros:66];0)
					End if 
					
				: ($at_ReferenciasRegistros{$i_registros}="D@")
					GOTO RECORD:C242([BBL_Registros:66];$l_recnum)
					RELATE ONE:C42([BBL_Registros:66]Número_de_item:1)
					$t_nombreItem:=[BBL_Items:61]Primer_título:4
					IT_SetTextStyle_Bold (->$t_nombreItem)
					IT_SetTextSize (->$t_nombreItem;13)
					IT_SetTextColor_Name (->$t_nombreItem;"Blue")
					$t_autor:=[BBL_Items:61]Primer_autor:6
					IT_SetTextStyle_Bold (->$t_autor)
					IT_SetTextSize (->$t_autor;11)
					IT_SetTextColor_Name (->$t_autor;"Black")
					$t_edicion:=[BBL_Items:61]Primer_editor:8+", "+[BBL_Items:61]Edicion:11+", "+[BBL_Items:61]Primer_editor:8
					IT_SetTextStyle_Bold (->$t_edicion)
					IT_SetTextSize (->$t_edicion;11)
					IT_SetTextColor_Name (->$t_edicion;"Black")
					$t_numeroCopia:=__ ("Copia # ")+String:C10([BBL_Registros:66]Número_de_copia:2)
					IT_SetTextStyle_Bold (->$t_numeroCopia)
					IT_SetTextSize (->$t_numeroCopia;11)
					IT_SetTextColor_Name (->$t_numeroCopia;"Black")
					atBBL_CodigosBarra_nombre{$i_registros}:=$t_nombreItem+"\r"+$t_autor+"\r"+$t_edicion+"\r"+$t_numeroCopia
					$b_conMiniatura:=True:C214
					DOCL_DocumentosAsociados (->[BBL_Items:61];String:C10([BBL_Items:61]Numero:1);"";$b_conMiniatura)
					REDUCE SELECTION:C351([DocumentLibrary:234];1)
					If (Records in selection:C76([DocumentLibrary:234])>0)
						apBBL_CodigosBarra_imagen{$i_registros}:=[DocumentLibrary:234]Thumbnail:4
						apBBL_CodigosBarra_imagen{$i_registros}:=apBBL_CodigosBarra_imagen{$i_registros}*0
					End if 
					If ($l_recNumLectorActual>No current record:K29:2)
						KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLectorActual)
					Else 
						REDUCE SELECTION:C351([BBL_Lectores:72];0)
					End if 
			End case 
		End for 
	End if 
End if 


Case of 
	: (Size of array:C274($at_ReferenciasRegistros)>0)
		$l_refVentana:=WDW_OpenPopupWindow (->vt_InstruccionConsola_BBL;->[BBL_Prestamos:60];"DesambiguacionBarCode")
		GET WINDOW RECT:C443($l_izquierda;$l_arriba;$l_derecha;$l_abajo;$l_refVentana)
		$l_altoVentana:=(Size of array:C274(atBBL_CodigosBarra_nombre)+1)*78
		SET WINDOW RECT:C444($l_izquierda;$l_arriba;$l_derecha;$l_arriba+$l_altoVentana;$l_refVentana)
		DIALOG:C40([BBL_Prestamos:60];"DesambiguacionBarCode")
		CLOSE WINDOW:C154
		If (OK=1)
			Case of 
				: ($at_ReferenciasRegistros{vl_ObjetoSeleccionado}="L@")
					$l_recNumLector:=Num:C11(Substring:C12($at_ReferenciasRegistros{vl_ObjetoSeleccionado};2))
					KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
					$l_resultado:=1
					
				: ($at_ReferenciasRegistros{vl_ObjetoSeleccionado}="D@")
					$l_recnumRegistro:=Num:C11(Substring:C12($at_ReferenciasRegistros{vl_ObjetoSeleccionado};2))
					KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro;False:C215)
					KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;True:C214)
					$l_resultado:=1
			End case 
		Else 
			REDUCE SELECTION:C351([BBL_Lectores:72];0)
			REDUCE SELECTION:C351([BBL_Items:61];0)
			REDUCE SELECTION:C351([BBL_Registros:66];0)
			If ($l_recNumLectorActual>No current record:K29:2)
				KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLectorActual)
			End if 
			If ($l_recNumRegistroActual>No current record:K29:2)
				KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistroActual)
			End if 
		End if 
		
	: (($l_recNumLector>No current record:K29:2) & ($l_recNumRegistro=No current record:K29:2))
		  // no hay ninguna ambigüedad. El codigo de barra corresponde a un lector
		KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
		$l_resultado:=1
		
	: (($l_recNumLector=No current record:K29:2) & ($l_recNumRegistro>No current record:K29:2))
		  // no hay ninguna ambigüedad. El codigo de barra corresponde a un registro
		KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro;False:C215)
		KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;True:C214)
		$l_resultado:=1
End case 

$0:=$l_resultado

