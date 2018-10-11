//%attributes = {}
  //ACTac_OpcionesGenerales

C_TEXT:C284($vt_accion;$1)
C_BOOLEAN:C305($0;$vb_retorno)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4)

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 

READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])

Case of 
	: ($vt_accion="ACTac_Recalcular")  //20180801 RCH Ticket 213280
		C_BOOLEAN:C305($b_hecho)
		For ($i;1;Size of array:C274($ptr1->))
			$b_hecho:=ACTac_Recalcular ($ptr1->{$i};Current date:C33(*);False:C215;True:C214)
			If (Not:C34($b_hecho))
				$vb_retorno:=True:C214  //en uso
				$i:=Size of array:C274($ptr1->)
			End if 
		End for 
		
	: ($vt_accion="RecalculaAvisos")
		ACTac_RecalculaAvisos ("DeclaraInitVars")
		
		  //20150605 RCH Se agregan ventana de información al usuario de avance de proceso...
		If (Size of array:C274($ptr1->)>15)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recalculando Avisos de Cobranza...")
		End if 
		
		For ($i;1;Size of array:C274($ptr1->))
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$ptr1->{$i})
			ACTac_RecalculaAvisos ("AgregarElemento";->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
			ACTac_Recalcular ($ptr1->{$i};Current date:C33(*);False:C215;True:C214)
			
			If (Size of array:C274($ptr1->)>15)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($ptr1->))
			End if 
			
		End for 
		
		If (Size of array:C274($ptr1->)>15)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
		ACTac_RecalculaAvisos ("RecalculaAviso")
		
	: ($vt_accion="SoloCargosEnMonedaPais")
		ARRAY TEXT:C222($at_monedas;0)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$ptr1->)
		KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
		AT_DistinctsFieldValues (->[ACT_Cargos:173]Moneda:28;->$at_monedas)
		Case of 
			: (Size of array:C274($at_monedas)=1)
				If ($at_monedas{1}=ST_GetWord (ACT_DivisaPais ;1;";"))
					$vb_retorno:=True:C214
				End if 
		End case 
		
	: ($vt_accion="CreaRegistroActividadesEliminaciónAviso")
		C_TEXT:C284($vt_responsable;$vt_nombre)
		$vt_responsable:=ST_Boolean2Str ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0;"Apoderado";"Tercero")
		$vt_nombre:=ST_Boolean2Str ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0;KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]Apellidos_y_nombres:30);KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;->[ACT_Terceros:138]Nombre_Completo:9))
		LOG_RegisterEvt ("Eliminación de aviso número: "+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+" para el "+$vt_responsable+": "+$vt_nombre+", para el período "+String:C10([ACT_Avisos_de_Cobranza:124]Agno:7;"0000")+String:C10([ACT_Avisos_de_Cobranza:124]Mes:6;"00"))
		
	: ($vt_accion="CargaModelosDeInforme")
		C_LONGINT:C283($table;$vl_idAviso)
		ARRAY TEXT:C222(atACT_ModelosAviso;0)
		ARRAY LONGINT:C221(abACT_ModeloID;0)
		$table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
		
		READ ONLY:C145([xShell_Reports:54])
		
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table)
		SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACT_ModelosAviso;[xShell_Reports:54]ID:7;abACT_ModeloID)
		ARRAY PICTURE:C279(apACT_ModeloSel;Size of array:C274(atACT_ModelosAviso))
		ARRAY BOOLEAN:C223(abACT_ModeloSel;Size of array:C274(atACT_ModelosAviso))
		For ($i;1;Size of array:C274(abACT_ModeloSel))
			apACT_ModeloSel{$i}:=apACT_ModeloSel{$i}*0
			abACT_ModeloSel{$i}:=False:C215
		End for 
		SORT ARRAY:C229(atACT_ModelosAviso;apACT_ModeloSel;abACT_ModeloSel;abACT_ModeloID;>)
		If (Size of array:C274(atACT_ModelosAviso)=1)
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ModeloSel{1})
			abACT_ModeloSel{1}:=True:C214
			atACT_ModelosAviso:=1
		Else 
			$vl_idAviso:=0
			$vl_idAviso:=Num:C11(PREF_fGet (0;"ACT_AvisoSeleccionado2Print";String:C10($vl_idAviso)))
			If ($vl_idAviso#0)
				$pos:=Find in array:C230(abACT_ModeloID;$vl_idAviso)
				If ($pos#-1)
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ModeloSel{$pos})
					abACT_ModeloSel{$pos}:=True:C214
					atACT_ModelosAviso:=$pos
				Else 
					PREF_Set (0;"ACT_AvisoSeleccionado2Print";"0")
				End if 
			End if 
		End if 
		
	: ($vt_accion="FiltraAvisosGenArchivoBancario")
		If (cb_IncluirSaldosAnteriores=1)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)  //20131205 RCH se estaban considerando los cargos proyectados 
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<=vdACT_Fecha2)
			If (cb_CalcularParaTodosLosAvisos=0)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*))
			End if 
			CREATE SET:C116([ACT_Cargos:173];"setCargos2")
			UNION:C120($ptr1->;"setCargos2";$ptr1->)
		End if 
		
	: ($vt_accion="BuscaExportadoArchivoTransferencia")
		ARRAY LONGINT:C221(alACT_ABArchivoID;0)
		ARRAY TEXT:C222(atACT_ABArchivoNombre;0)
		READ ONLY:C145([xxACT_ArchivosBancarios:118])
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ImpExp:5=$ptr1->;*)
		QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=$ptr2->;*)
		QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]Rol_BD:8=<>gRolBD)
		Case of 
			: (Records in selection:C76([xxACT_ArchivosBancarios:118])=1)
				SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]ID:1;alACT_ABArchivoID;[xxACT_ArchivosBancarios:118]Nombre:3;atACT_ABArchivoNombre)
				$ptr3->:=atACT_ABArchivoNombre{1}
				$ptr4->:=alACT_ABArchivoID{1}
				_O_ENABLE BUTTON:C192(bExportadores)
			: (Records in selection:C76([xxACT_ArchivosBancarios:118])>0)
				SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]ID:1;alACT_ABArchivoID;[xxACT_ArchivosBancarios:118]Nombre:3;atACT_ABArchivoNombre)
				$ptr3->:=__ ("Seleccionar...")
				$ptr4->:=0
				_O_ENABLE BUTTON:C192(bExportadores)
			Else 
				If ($ptr1->)
					$ptr3->:=__ ("No hay importadores definidos para ")+atACT_formas_de_pago{atACT_formas_de_pago}
				Else 
					$ptr3->:=__ ("No hay exportadores definidos para ")+atACT_formas_de_pago{atACT_formas_de_pago}
				End if 
				$ptr4->:=0
				_O_DISABLE BUTTON:C193(bExportadores)
		End case 
		
		If ($ptr4->#0)
			$vb_retorno:=True:C214
		Else 
			$vb_retorno:=False:C215
		End if 
		
	: ($vt_accion="CreaArregloDesdeRecNumCargo")
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->;"")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;<)
		
		ARRAY LONGINT:C221($ptr2->;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$ptr2->;"")
		
End case 

$0:=$vb_retorno