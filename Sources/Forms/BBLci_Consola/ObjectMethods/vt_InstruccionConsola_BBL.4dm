  // BBLci_Consola.vt_InstruccionConsola_BBL()
  // Por: Alberto Bachler K.: 06-12-13, 19:40:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_IdRegistro;$l_ItemPalabraCompletaAutor;$l_ItemPalabraCompletaMateria;$l_ItemPalabraCompletaTitulo;$l_ItemTipoBusquedaAutor;$l_ItemTipoBusquedaMateria;$l_ItemTipoBusquedaTitulo;$l_LectorBuscarSobreNombre;$l_LectorPalabraCompleta;$l_LectorTipoBusquedaNombre)
C_LONGINT:C283($l_numeroRegistro;$l_recNumItem;$l_recNumLector;$l_recNumlectorActual;$l_recNumRegistro;$l_recNumRegistroActual;$l_resultado;$l_tabla)
C_PICTURE:C286($p_noImagen)
C_POINTER:C301($y_tabla;$y_variableImagen)
C_TEXT:C284($t_IdNacional1;$t_IdNacional2;$t_IdNacional3;$t_tip)




Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		
	: ((Form event:C388=On Data Change:K2:15) & (vt_InstruccionConsola_BBL#""))
		
		$l_recNumlectorActual:=Record number:C243([BBL_Lectores:72])
		$l_recNumRegistroActual:=Record number:C243([BBL_Registros:66])
		
		$l_resultado:=No current record:K29:2
		
		If (vt_InstruccionConsola_BBL="0")
			$l_recNumLector:=No current record:K29:2
			$l_recNumRegistro:=No current record:K29:2
			$l_recNumItem:=No current record:K29:2
			REDUCE SELECTION:C351([BBL_Items:61];0)
			REDUCE SELECTION:C351([BBL_Registros:66];0)
			REDUCE SELECTION:C351([BBL_Lectores:72];0)
		Else 
			If (vt_InstruccionConsola_BBL#"")
				If (vl_RefCampoBusqueda_BBLci#MultiCriterio_Item)
					$l_tabla:=Table:C252(vy_CampoBusqueda_BBLci)
				End if 
				
				Case of 
					: (vl_RefCampoBusqueda_BBLci=NombreLector)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorBuscarSobreNombre";->$l_LectorBuscarSobreNombre)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorTipoBusquedaNombre";->$l_LectorTipoBusquedaNombre)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorPalabraCompleta";->$l_LectorPalabraCompleta)
						QRY_BusquedaPorPalabrasClave ($y_tabla;vy_CampoBusqueda_BBLci;vt_InstruccionConsola_BBL;$l_LectorTipoBusquedaNombre;$l_LectorPalabraCompleta)
						ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]NombreCompleto:3;>)
						
					: (vl_RefCampoBusqueda_BBLci=IdentificadorNacional1)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						$t_IdNacional1:=vt_InstruccionConsola_BBL
						KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]RUT:7;->$t_IdNacional1)
						
					: (vl_RefCampoBusqueda_BBLci=IdentificadorNacional2)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						$t_IdNacional3:=vt_InstruccionConsola_BBL
						KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]IDNacional_2:33;->$t_IdNacional2;False:C215)
						
					: (vl_RefCampoBusqueda_BBLci=IdentificadorNacional1)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						$t_IdNacional3:=vt_InstruccionConsola_BBL
						KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]IDNacional_3:34;->$t_IdNacional3;False:C215)
						
					: (vl_RefCampoBusqueda_BBLci=NumeroRegistro)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						$l_numeroRegistro:=Num:C11(vt_InstruccionConsola_BBL)
						KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]No_Registro:25;->$l_numeroRegistro;False:C215)
						If ([BBL_Registros:66]No_Registro:25>0)
							KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;False:C215)
							If (Records in selection:C76([BBL_Items:61])=1)
								$l_resultado:=1
							End if 
						End if 
					: (vl_RefCampoBusqueda_BBLci=IdRegistro)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						$l_IdRegistro:=Num:C11(vt_InstruccionConsola_BBL)
						KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]ID:3;->$l_IdRegistro;False:C215)
						If ([BBL_Registros:66]ID:3>0)
							KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;False:C215)
							If (Records in selection:C76([BBL_Items:61])=1)
								$l_resultado:=1
							End if 
						End if 
					: (vl_RefCampoBusqueda_BBLci=MultiCriterio_Item)
						$y_tabla:=->[BBL_Items:61]
						READ ONLY:C145($y_tabla->)
						CREATE EMPTY SET:C140([BBL_Items:61];"items")
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaTitulo";->$l_ItemTipoBusquedaTitulo)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaTitulo";->$l_ItemPalabraCompletaTitulo)
						QRY_BusquedaPorPalabrasClave (->[BBL_Items:61];->[BBL_Items:61]Titulos:5;vt_InstruccionConsola_BBL;$l_ItemTipoBusquedaTitulo;$l_ItemPalabraCompletaTitulo)
						CREATE SET:C116([BBL_Items:61];"consulta")
						UNION:C120("items";"consulta";"items")
						
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaAutor";->$l_ItemTipoBusquedaAutor)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaAutor";->$l_ItemPalabraCompletaAutor)
						QRY_BusquedaPorPalabrasClave (->[BBL_Items:61];->[BBL_Items:61]Autores:7;vt_InstruccionConsola_BBL;$l_ItemTipoBusquedaAutor;$l_ItemPalabraCompletaAutor)
						ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_autor:6;>;[BBL_Items:61]Primer_título:4;>)
						CREATE SET:C116([BBL_Items:61];"consulta")
						UNION:C120("items";"consulta";"items")
						
						
						  ///codigo de barra para las reservas ticket 158458  JVP
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaAutor";->$l_ItemTipoBusquedaAutor)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaAutor";->$l_ItemPalabraCompletaAutor)
						QRY_BusquedaPorPalabrasClave (->[BBL_Registros:66];->[BBL_Registros:66]Barcode_SinFormato:26;vt_InstruccionConsola_BBL;$l_ItemTipoBusquedaAutor;$l_ItemPalabraCompletaAutor)
						KRL_RelateSelection (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;"")
						
						ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_autor:6;>;[BBL_Items:61]Primer_título:4;>)
						CREATE SET:C116([BBL_Items:61];"consulta")
						UNION:C120("items";"consulta";"items")
						
						  ///
						
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaMateria";->$l_ItemTipoBusquedaMateria)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaMateria";->$l_ItemPalabraCompletaMateria)
						QRY_BusquedaPorPalabrasClave (->[BBL_Items:61];->[BBL_Items:61]Materias_json:53;vt_InstruccionConsola_BBL;$l_ItemTipoBusquedaMateria;$l_ItemPalabraCompletaMateria)
						CREATE SET:C116([BBL_Items:61];"consulta")
						UNION:C120("items";"consulta";"items")
						USE SET:C118("items")
						CLEAR SET:C117("items")
						ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_título:4;>)
						
					: (vl_RefCampoBusqueda_BBLci=TituloItem)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						READ ONLY:C145($y_tabla->)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaTitulo";->$l_ItemTipoBusquedaTitulo)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaTitulo";->$l_ItemPalabraCompletaTitulo)
						QRY_BusquedaPorPalabrasClave ($y_tabla;vy_CampoBusqueda_BBLci;vt_InstruccionConsola_BBL;$l_ItemTipoBusquedaTitulo;$l_ItemPalabraCompletaTitulo)
						ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_título:4;>)
						
					: (vl_RefCampoBusqueda_BBLci=AutorItem)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						READ ONLY:C145($y_tabla->)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaAutor";->$l_ItemTipoBusquedaAutor)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaAutor";->$l_ItemPalabraCompletaAutor)
						QRY_BusquedaPorPalabrasClave ($y_tabla;vy_CampoBusqueda_BBLci;vt_InstruccionConsola_BBL;$l_ItemTipoBusquedaAutor;$l_ItemPalabraCompletaAutor)
						ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_autor:6;>;[BBL_Items:61]Primer_título:4;>)
						
					: (vl_RefCampoBusqueda_BBLci=Materias)
						$y_tabla:=Table:C252(Table:C252(vy_CampoBusqueda_BBLci))
						READ ONLY:C145($y_tabla->)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemTipoBusquedaMateria";->$l_ItemTipoBusquedaMateria)
						OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemPalabraCompletaMateria";->$l_ItemPalabraCompletaMateria)
						QRY_BusquedaPorPalabrasClave ($y_tabla;vy_CampoBusqueda_BBLci;vt_InstruccionConsola_BBL;$l_ItemTipoBusquedaMateria;$l_ItemPalabraCompletaMateria)
						ORDER BY:C49([BBL_Items:61];[BBL_Items:61]Primer_título:4;>)
						
					: (($l_Tabla=Table:C252(->[BBL_Lectores:72])) | ($l_tabla=Table:C252(->[BBL_Registros:66])))
						$l_resultado:=BBLci_ProcesaBarCode (vt_InstruccionConsola_BBL)
				End case 
				
				  // conservo las referencias a los registros de lectores y items para restaurarlos después de mostrar la lista 
				  // (donde la selección puede cambiar)
				If (Not:C34(Is nil pointer:C315($y_tabla)))
					$l_recNumLector:=Record number:C243([BBL_Lectores:72])
					$l_recNumRegistro:=Record number:C243([BBL_Registros:66])
					$l_recNumItem:=Record number:C243([BBL_Items:61])
					Case of 
						: ((Table:C252($y_tabla)=Table:C252(->[BBL_Lectores:72])) & (Records in selection:C76([BBL_Lectores:72])>0))
							UNLOAD RECORD:C212([BBL_Lectores:72])
							$l_resultado:=BBLci_SeleccionLectores 
							If ($l_resultado=1)
								$l_recNumLector:=Record number:C243([BBL_Lectores:72])
								KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
							Else 
								$l_recNumLector:=-1
							End if 
							If ($l_recNumItem>No current record:K29:2)
								KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
							End if 
							
						: ((Table:C252($y_tabla)=Table:C252(->[BBL_Items:61])) & (Records in selection:C76([BBL_Items:61])>0))
							UNLOAD RECORD:C212([BBL_Items:61])
							$l_resultado:=BBLci_SeleccionItems 
							If ($l_resultado=1)
								$l_recNumItem:=Record number:C243([BBL_Items:61])
								KRL_GotoRecord (->[BBL_Items:61];$l_recNumItem;False:C215)
							Else 
								$l_recNumItem:=No current record:K29:2
							End if 
							If ($l_recNumLector>No current record:K29:2)
								KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;False:C215)
							End if 
					End case 
				End if 
			End if 
			
			
			
			If ($l_resultado=1)
				$l_recNumLector:=Record number:C243([BBL_Lectores:72])
				$l_recNumRegistro:=Record number:C243([BBL_Registros:66])
				$l_recNumItem:=Record number:C243([BBL_Items:61])
				
				$y_variableImagen:=OBJECT Get pointer:C1124(Object named:K67:5;"item_imagen")
				If ($l_recNumItem>No current record:K29:2)
					DOCL_DocumentosAsociados (->[BBL_Items:61];String:C10([BBL_Items:61]Numero:1);"";True:C214)
					$y_variableImagen->:=[DocumentLibrary:234]Thumbnail:4
				Else 
					$y_variableImagen->:=$p_noImagen
				End if 
				
				Case of 
					: (vl_ModoConsola=Prestamo)
						If (($l_recNumlectorActual#$l_recNumLector) & ($l_recNumLector>No current record:K29:2))
							$l_recNumRegistro:=No current record:K29:2
							REDUCE SELECTION:C351([BBL_Registros:66];0)
							REDUCE SELECTION:C351([BBL_Items:61];0)
							$y_variableImagen->:=$p_noImagen
						End if 
						BBLci_ModosBusquedaObjeto ("LR")
						Case of 
							: (($l_recNumLector>No current record:K29:2) & ($l_recNumRegistro=No current record:K29:2))
								  // el usuario debe ingresar el codigo de barra de un registro (o de un lector si desea cambiarlo)
								
							: (($l_recNumRegistro>No current record:K29:2) & ($l_recNumLector=No current record:K29:2))
								  // el usuario debe ingresar el codigo de barra de un lector
								If ([BBL_Registros:66]Prestado_hasta:14#!00-00-00!)
									BBLci_Devolucion ($l_recNumRegistro)
								Else 
									
								End if 
								
							: (($l_recNumLector>=0) & ($l_recNumRegistro>=0))
								  // se registra el préstamo
								BBLci_Prestamo_Devolucion ($l_recNumLector;$l_recNumRegistro)
								
						End case 
						
					: (vl_ModoConsola=Devolucion)
						BBLci_Devolucion ($l_recNumRegistro)
						
					: (vl_ModoConsola=Renovacion)
						Case of 
							: ($l_recNumRegistro>No current record:K29:2)
								BBLci_Renovacion ($l_recNumRegistro)
							: (($l_recNumRegistro=No current record:K29:2) & ($l_recNumLector>No current record:K29:2))
								BBLci_Renovacion ($l_recNumRegistro)
						End case 
						
					: (vl_ModoConsola=Reservas)  // Reservar
						Case of 
							: (($l_recNumLector>No current record:K29:2) & ($l_recNumItem>No current record:K29:2))
								BBLci_Reserva ($l_recNumLector;$l_recNumItem)
								
							: (($l_recNumLector=No current record:K29:2) & ($l_recNumlectorActual=No current record:K29:2))
								BBLci_ModosBusquedaObjeto ("L")
								OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorModoBusqueda";->vl_RefCampoBusqueda_BBLci)
								BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
								
							: ($l_recNumItem=No current record:K29:2)
								BBLci_ModosBusquedaObjeto ("I")
								OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_ItemModoBusqueda";->vl_RefCampoBusqueda_BBLci)
								BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
						End case 
						
						
					: (vl_ModoConsola=Busqueda Lector)  // Buscar lector
						  // el usuario debe ingresar el codigo de barra de un lector
						BBLci_ModosBusquedaObjeto ("L")
						BBLci_InfoCampoBusqueda (vl_RefCampoBusqueda_BBLci;->$t_tip;->vy_CampoBusqueda_BBLci)
				End case 
				
				vt_InstruccionConsola_BBL:=""
				GOTO OBJECT:C206(vt_InstruccionConsola_BBL)
				
			Else 
				vt_InstruccionConsola_BBL:=""
				GOTO OBJECT:C206(vt_InstruccionConsola_BBL)
			End if 
			
		End if 
		
		
		BBLci_InformacionesLector ("set")
		BBLci_InformacionesItem ("set")
		
		
		
		
		
	: (Form event:C388=On Losing Focus:K2:8)
		vt_InstruccionConsola_BBL:=""
		GOTO OBJECT:C206(vt_InstruccionConsola_BBL)
End case 