//%attributes = {}
  //ACT_InformeESPPagosAnticipados

  //DLEDEZMA  25-8-2009 Crea un archivo txt con los pagos que cancelaron de forma anticipada cargos además muetra también 
  //un detalle de items seleccionado de forma aparte.








  // Modificado por: Alexis Bustamante (18-02-2016)
  //Se modifica la forma de exportar Los Subtotales.


C_REAL:C285($totalDisp)
C_BOOLEAN:C305($itemsInexistentes)
C_TEXT:C284($text)

C_LONGINT:C283($cargos1;$cargos2;$i)
  //C_INTEGER($cargos1;$cargos2;i)

READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([xxACT_Items:179])
  //


C_REAL:C285($cantColum)
$cantColum:=0

C_POINTER:C301(vQR_pointer1)  //Arreglos subtotal

$year:=Year of:C25(vd_Fecha2)
$month:=Month of:C24(vd_Fecha2)
$day:=Day of:C23(vd_Fecha2)






Case of 
	: (op2_apo=1)
		$fileName:="Pagos_Anticipados_al_"+String:C10($year)+"-"+<>atXS_MonthNames{$month}+"-"+String:C10($day)+"_Apoderados"
	: (op1_ctas=1)
		$fileName:="Pagos_Anticipados_al_"+String:C10($year)+"-"+<>atXS_MonthNames{$month}+"-"+String:C10($day)+"_CuentasCorrientes"
End case 


QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_Fecha1;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Fecha:2<=vd_Fecha2)
QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Nulo:14#True:C214)
CREATE SET:C116([ACT_Pagos:172];"PAGOS1")

KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
CREATE SET:C116([ACT_Transacciones:178];"Trans")
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
CREATE SET:C116([ACT_Cargos:173];"Todo_Cargos")

QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7>vd_Fecha2)
CREATE SET:C116([ACT_Cargos:173];"Cargos Temp")

KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
CREATE SET:C116([ACT_Pagos:172];"PAGOS2")

INTERSECTION:C121("PAGOS1";"PAGOS2";"PAGOS1")

USE SET:C118("Cargos Temp")
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Año:14=<>gyear)
CREATE SET:C116([ACT_Cargos:173];"Cargos Adelantados")
$cargos1:=Records in selection:C76([ACT_Cargos:173])

ARRAY TEXT:C222($glosa_cargos_aparte;0)
ARRAY LONGINT:C221($ref_cargos_aparte;0)
ARRAY LONGINT:C221($aID_Apoderados1;0)
ARRAY LONGINT:C221($aID_Apoderados2;0)
ARRAY LONGINT:C221($aID_Ctas1;0)
ARRAY LONGINT:C221($aID_Ctas2;0)


For ($i;1;Size of array:C274(abACT_PrintItem))
	If (abACT_PrintItem{$i})
		APPEND TO ARRAY:C911($glosa_cargos_aparte;at_cargos{$i})
		APPEND TO ARRAY:C911($ref_cargos_aparte;al_refe_itemscargos{$i})
	End if 
End for 




USE SET:C118("Todo_Cargos")
QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->$ref_cargos_aparte;True:C214)
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Año>$year) esto producía que las matriculas del proximo año que eran emitidas en el año actual

CREATE SET:C116([ACT_Cargos:173];"Cargos Aparte")
Case of 
	: (op2_apo=1)
		  //Para Pruebas
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_Apoderado:18;$aID_Apoderados1)
	: (op1_ctas=1)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_CuentaCorriente:2;$aID_Ctas1)
End case 

DIFFERENCE:C122("Cargos Adelantados";"Cargos Aparte";"Cargos Adelantados")

SET_ClearSets ("Cargos Temp";"Cargos ")
$cargos2:=Records in selection:C76([ACT_Cargos:173])

  //Creación del Archivo TXT
If (($cargos1>0) | ($cargos2>0))
	
	If (SYS_IsWindows )
		$fileName:=$fileName+".txt"
	End if 
	
	$folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ACT)+"Informe de Pagos Anticipados"+Folder separator:K24:12
	SYS_CreaCarpeta ($folderPath)
	$filePath:=$folderPath+$fileName
	
	  // crear un nuevo documento con el nombre del mes y el año seleccionado
	ok:=1
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	If (SYS_TestPathName ($filePath)=1)
		DELETE DOCUMENT:C159($filePath)
	End if 
	EM_ErrorManager ("Clear")
	USE CHARACTER SET:C205("windows-1252";0)
	If (ok=1)
		$ref:=Create document:C266($filePath;"TEXT")
		
		ARRAY REAL:C219($aAcumParaTotalF;0)
		ARRAY REAL:C219($aAcumParaSubtotal;0)
		ARRAY LONGINT:C221($ItemsPagados;0)
		ARRAY TEXT:C222($glosasCargos;0)
		ARRAY TEXT:C222($glosasCargos2;0)
		ARRAY LONGINT:C221($aID_Apoderados;0)
		ARRAY LONGINT:C221($aID_Ctas;0)
		ARRAY LONGINT:C221($ameses;0)
		C_REAL:C285($disponible;$todo_disponible)
		
		USE SET:C118("PAGOS1")
		$todo_disponible:=Sum:C1([ACT_Pagos:172]Saldo:15)
		
		ARRAY LONGINT:C221($aRefsitems;0)
		ARRAY LONGINT:C221($aRefsitems2;0)
		  //C_INTEGER($x;$i;$q;$n;$m;$salto)
		C_LONGINT:C283($x;$i;$q;$n;$m;$salto)
		$salto:=0
		C_LONGINT:C283($findo)
		
		USE SET:C118("Cargos Adelantados")
		ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
		
		Case of 
			: (op2_apo=1)
				
				SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;$aTmeses;[ACT_Cargos:173]Año:14;$aTaños;[ACT_Cargos:173]ID_Apoderado:18;$aID_Apoderados2)
				AT_Union (->$aID_Apoderados1;->$aID_Apoderados2;->$aID_Apoderados)
				AT_DistinctsArrayValues (->$aID_Apoderados)
				QUERY WITH ARRAY:C644([Personas:7]No:1;$aID_Apoderados)
				ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
				SELECTION TO ARRAY:C260([Personas:7]No:1;$aID_Apoderados)
				
			: (op1_ctas=1)
				
				SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;$aTmeses;[ACT_Cargos:173]Año:14;$aTaños;[ACT_Cargos:173]ID_CuentaCorriente:2;$aID_Ctas2)
				AT_Union (->$aID_Ctas1;->$aID_Ctas2;->$aID_Ctas)
				AT_DistinctsArrayValues (->$aID_Ctas)
				QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;$aID_Ctas)
				
				If (Sel1_cts_ina=0)
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				End if 
				
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]apellidos_y_nombres:40;>)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$aID_Ctas)
				
		End case 
		
		
		
		C_LONGINT:C283($vlmes)
		C_LONGINT:C283($vlaño)
		
		$vlmes:=0
		$vlaño:=0
		
		  //Arreglos para meses y años
		
		ARRAY LONGINT:C221($aMeses;0)
		ARRAY LONGINT:C221($aAños;0)
		
		For ($x;1;Size of array:C274($aTmeses))
			If (($vlmes#$aTmeses{$x}) | ($vlaño#$aTaños{$x}))
				$vlmes:=$aTmeses{$x}
				$vlaño:=$aTaños{$x}
				APPEND TO ARRAY:C911($aMeses;$vlmes)
				APPEND TO ARRAY:C911($aAños;$vlaño)
			End if 
		End for 
		
		  //Arreglo con nombre de mes y año
		ARRAY TEXT:C222($alSubMeses;0)
		
		APPEND TO ARRAY:C911($alSubMeses;__ ("RUT"))
		
		Case of 
			: (op2_apo=1)
				APPEND TO ARRAY:C911($alSubMeses;__ ("SOSTENEDOR"))
			: (op1_ctas=1)
				APPEND TO ARRAY:C911($alSubMeses;__ ("CTA. CORRIENTE"))
				APPEND TO ARRAY:C911($alSubMeses;__ ("CURSO"))
		End case 
		
		For ($x;1;Size of array:C274($aMeses))
			APPEND TO ARRAY:C911($alSubMeses;<>atxs_monthnames{$aMeses{$x}}+" "+String:C10($aAños{$x}))
		End for 
		
		If ($todo_disponible>0)
			APPEND TO ARRAY:C911($alSubMeses;__ ("DISPONIBLE"))
		End if 
		
		  //ENCABEZADO ITEMS APARTE Y/O CATEGORIAS------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		If (Sel2_Categ=1)
			
			READ ONLY:C145([xxACT_ItemsCategorias:98])
			READ ONLY:C145([xxACT_Items:179])
			ARRAY LONGINT:C221($al_id_categoriaxitem;0)
			ARRAY LONGINT:C221($al_id_categoria;0)
			ARRAY LONGINT:C221($al_items_sin_categoria;0)
			ARRAY TEXT:C222($at_glosa_enca;0)
			
			C_LONGINT:C283($find_result)
			
			For ($n;1;Size of array:C274($ref_cargos_aparte))
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$ref_cargos_aparte{$n})
				APPEND TO ARRAY:C911($al_id_categoriaxitem;[xxACT_Items:179]ID_Categoria:8)
				$find_result:=Find in array:C230($al_id_categoria;$al_id_categoriaxitem{$n})
				
				If (($find_result=-1) & ($al_id_categoriaxitem{$n}#0))
					APPEND TO ARRAY:C911($al_id_categoria;$al_id_categoriaxitem{$n})
					QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=$al_id_categoriaxitem{$n})
					APPEND TO ARRAY:C911($at_glosa_enca;[xxACT_ItemsCategorias:98]Nombre:1)
				End if 
				
			End for 
			
			$al_id_categoriaxitem{0}:=0
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->$al_id_categoriaxitem;"=";->$DA_Return)
			
			For ($n;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($at_glosa_enca;$glosa_cargos_aparte{$DA_Return{$n}})
				APPEND TO ARRAY:C911($al_items_sin_categoria;$ref_cargos_aparte{$DA_Return{$n}})
			End for 
			
			  // Modificado por: Alexis Bustamante (25-02-2016)
			  //Ticket 155574
			For ($x;1;Size of array:C274($at_glosa_enca))
				APPEND TO ARRAY:C911($alSubMeses;ST_CleanString ($at_glosa_enca{$x}))
			End for 
			
		Else 
			
			  // Modificado por: Alexis Bustamante (25-02-2016)
			  //Ticket 155574
			For ($x;1;Size of array:C274($glosa_cargos_aparte))
				APPEND TO ARRAY:C911($alSubMeses;ST_CleanString ($glosa_cargos_aparte{$x}))
			End for 
			
		End if 
		
		APPEND TO ARRAY:C911($alSubMeses;__ (" T O T A L "))
		
		$texto:=AT_array2text (->$alSubMeses;"\t")
		
		IO_SendPacket ($ref;$texto+"\r\n")
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando Archivo con la Información de los Pagos Anticipados..."))
		
		Case of 
			: (op2_apo=1)
				
				  //POR APOERADOS
				
				For ($i;1;Size of array:C274($aID_Apoderados))
					
					USE SET:C118("Cargos Adelantados")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$aID_Apoderados{$i})
					
					If (sel1_cts_ina=0)
						ARRAY LONGINT:C221($al_cc_apo;0)
						AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo)
						QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
						SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
						QRY_QueryWithArray (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo;True:C214)
					End if 
					
					CREATE SET:C116([ACT_Cargos:173];"CargosApo")
					DIFFERENCE:C122("Cargos Adelantados";"CargosApo";"Cargos Adelantados")
					
					QUERY:C277([Personas:7];[Personas:7]No:1=$aID_Apoderados{$i})
					$pagado:=0
					
					ARRAY REAL:C219($aDetalleMontosPagados;0)
					IO_SendPacket ($ref;[Personas:7]RUT:6+"\t"+[Personas:7]Apellidos_y_nombres:30+"\t")
					
					
					vQR_long100:=0
					vQR_long100:=1
					
					For ($n;1;Size of array:C274($aMeses))
						
						USE SET:C118("CargosApo")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$aMeses{$n};*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$aAños{$n})
						
						CREATE SET:C116([ACT_Cargos:173];"CargosApo2")
						DIFFERENCE:C122("CargosApo";"CargosApo2";"CargosApo")
						
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						CREATE SET:C116([ACT_Transacciones:178];"Tran1")
						INTERSECTION:C121("Trans";"Tran1";"Tran1")
						USE SET:C118("Tran1")
						ARRAY LONGINT:C221($aTrans;0)
						
						SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
						
						$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
						
						APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
						APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
					End for 
					
					If ($todo_disponible>0)
						USE SET:C118("PAGOS1")
						QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=$aID_Apoderados{$i})
						$disponible:=Sum:C1([ACT_Pagos:172]Saldo:15)
						APPEND TO ARRAY:C911($aDetalleMontosPagados;$disponible)
						APPEND TO ARRAY:C911($aAcumParaSubtotal;$disponible)
					End if 
					
					  //*****************************************Por Categoría Cargos seleccionados aparte ***************************************************
					If (sel2_Categ=1)
						
						For ($n;1;Size of array:C274($al_id_categoria))
							
							$al_id_categoriaxitem{0}:=$al_id_categoria{$n}
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->$al_id_categoriaxitem;"=";->$DA_Return)
							ARRAY LONGINT:C221($al_items_categoria;0)
							
							For ($m;1;Size of array:C274($DA_Return))
								APPEND TO ARRAY:C911($al_items_categoria;$ref_cargos_aparte{$DA_return{$m}})
							End for 
							
							USE SET:C118("Cargos Aparte")
							QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->$al_items_categoria;True:C214)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$aID_Apoderados{$i})
							
							If (sel1_cts_ina=0)
								ARRAY LONGINT:C221($al_cc_apo;0)
								AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo)
								QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
								QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
								SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
								QRY_QueryWithArray (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo;True:C214)
							End if 
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							CREATE SET:C116([ACT_Transacciones:178];"Tran1")
							INTERSECTION:C121("Trans";"Tran1";"Tran1")
							USE SET:C118("Tran1")
							ARRAY LONGINT:C221($aTrans;0)
							
							SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
							
							$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
							
							APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
							APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
							
						End for 
						
						  // //////////////////////////////////////////////////////////////Cuando hay items de cargo sin Categoria//////////////////////////////////////////////////////////////////////////////////////////////////////
						For ($n;1;Size of array:C274($al_items_sin_categoria))
							USE SET:C118("Cargos Aparte")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$al_items_sin_categoria{$n};*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=$aID_Apoderados{$i})
							
							If (sel1_cts_ina=0)
								ARRAY LONGINT:C221($al_cc_apo;0)
								AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo)
								QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
								QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
								SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
								QRY_QueryWithArray (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo;True:C214)
							End if 
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							CREATE SET:C116([ACT_Transacciones:178];"Tran1")
							INTERSECTION:C121("Trans";"Tran1";"Tran1")
							USE SET:C118("Tran1")
							ARRAY LONGINT:C221($aTrans;0)
							
							SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
							
							$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
							
							APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
							APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
						End for 
						
					Else 
						
						For ($n;1;Size of array:C274($ref_cargos_aparte))
							
							USE SET:C118("Cargos Aparte")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$ref_cargos_aparte{$n};*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=$aID_Apoderados{$i})
							
							If (sel1_cts_ina=0)
								ARRAY LONGINT:C221($al_cc_apo;0)
								AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo)
								QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
								QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
								SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_cc_apo)
								QRY_QueryWithArray (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_cc_apo;True:C214)
							End if 
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							CREATE SET:C116([ACT_Transacciones:178];"Tran1")
							INTERSECTION:C121("Trans";"Tran1";"Tran1")
							USE SET:C118("Tran1")
							ARRAY LONGINT:C221($aTrans;0)
							
							SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
							
							$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
							
							APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
							APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
							
						End for 
						
					End if 
					
					
					  //ENvio de linea del apoderado
					CLEAR SET:C117("CargosApo")
					
					$pagado:=AT_GetSumArray (->$aDetalleMontosPagados)
					APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
					APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
					
					  // Modificado por: Alexis Bustamante (18-02-2016)
					If ($i=1)
						  //Solo en la primera vuelta  se crean los arreglos acorde a la cantidad de columnas
						  //Guardo la cantidad de columnas hasta el total final ->
						  //para utilizar en el calculo de los Subtotal
						$cantColum:=Size of array:C274($aDetalleMontosPagados)
						For (vQr_long10;1;$cantColum)
							vQR_pointer1:=Get pointer:C304("aQR_real"+String:C10(vQr_long10))
							ARRAY REAL:C219(vQR_pointer1->;0)
						End for 
					End if 
					
					  //GUARDAR DESGLOSE de MONTOS
					For (vQR_long10;1;Size of array:C274($aDetalleMontosPagados))
						vQR_pointer1:=Get pointer:C304("aQr_real"+String:C10(vQR_long10))
						APPEND TO ARRAY:C911(vQR_pointer1->;$aDetalleMontosPagados{vQR_long10})
					End for 
					
					
					
					
					
					  //Envio de detalle de pagos por apoderados
					$texto:=AT_array2text (->$aDetalleMontosPagados;"\t";"|Despliegue_ACT_Pagos")
					
					IO_SendPacket ($ref;$texto+"\r\n")
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/(Size of array:C274($aID_Apoderados)))
				End for 
				
			: (op1_ctas=1)
				  //POR CUENTAS
				
				For ($i;1;Size of array:C274($aID_Ctas))
					
					USE SET:C118("Cargos Adelantados")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$aID_Ctas{$i})
					
					CREATE SET:C116([ACT_Cargos:173];"CargosCta")
					DIFFERENCE:C122("Cargos Adelantados";"Cargoscta";"Cargos Adelantados")
					
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$aID_Ctas{$i})
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
					$pagado:=0
					
					ARRAY REAL:C219($aDetalleMontosPagados;0)
					C_TEXT:C284($vt_ncc)
					
					If ([ACT_CuentasCorrientes:175]Estado:4=True:C214)
						$vt_ncc:=[Alumnos:2]curso:20
					Else 
						$vt_ncc:="INACTIVO"
					End if 
					
					IO_SendPacket ($ref;[Alumnos:2]RUT:5+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$vt_ncc+"\t")
					
					
					For ($n;1;Size of array:C274($aMeses))
						USE SET:C118("CargosCta")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$aMeses{$n};*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$aAños{$n})
						CREATE SET:C116([ACT_Cargos:173];"CargosCta2")
						DIFFERENCE:C122("CargosCta";"CargosCta2";"CargosCta")
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						CREATE SET:C116([ACT_Transacciones:178];"Tran1")
						INTERSECTION:C121("Trans";"Tran1";"Tran1")
						USE SET:C118("Tran1")
						ARRAY LONGINT:C221($aTrans;0)
						SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
						$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
						APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
						APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
					End for 
					
					  //ver como aplica el disponible por alumno
					  //If ($todo_disponible>0)
					  //
					  //USE SET("PAGOS1")
					  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]ID_Apoderado=$aID_Apoderados{$i})
					  //
					  //$disponible:=Sum([ACT_Pagos]Saldo)
					  //
					  //APPEND TO ARRAY($aDetalleMontosPagados;$disponible)
					  //APPEND TO ARRAY($aAcumParaSubtotal;$disponible)
					  //
					  //End if 
					
					If (sel2_Categ=1)
						
						For ($n;1;Size of array:C274($al_id_categoria))
							
							$al_id_categoriaxitem{0}:=$al_id_categoria{$n}
							ARRAY LONGINT:C221($DA_Return;0)
							AT_SearchArray (->$al_id_categoriaxitem;"=";->$DA_Return)
							ARRAY LONGINT:C221($al_items_categoria;0)
							
							For ($m;1;Size of array:C274($DA_Return))
								APPEND TO ARRAY:C911($al_items_categoria;$ref_cargos_aparte{$DA_return{$m}})
							End for 
							
							USE SET:C118("Cargos Aparte")
							QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->$al_items_categoria;True:C214)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$aID_Ctas{$i})
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							CREATE SET:C116([ACT_Transacciones:178];"Tran1")
							INTERSECTION:C121("Trans";"Tran1";"Tran1")
							USE SET:C118("Tran1")
							ARRAY LONGINT:C221($aTrans;0)
							
							SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
							$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
							APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
							APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
						End for 
						
						  // //////////////////////////////////////////////////////////////Cuando hay items de cargo sin Categoria//////////////////////////////////////////////////////////////////////////////////////////////////////
						For ($n;1;Size of array:C274($al_items_sin_categoria))
							USE SET:C118("Cargos Aparte")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$al_items_sin_categoria{$n};*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CuentaCorriente:2=$aID_Ctas{$i})
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							CREATE SET:C116([ACT_Transacciones:178];"Tran1")
							INTERSECTION:C121("Trans";"Tran1";"Tran1")
							USE SET:C118("Tran1")
							ARRAY LONGINT:C221($aTrans;0)
							SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
							$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
							APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
							APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
							
						End for 
						
						
					Else 
						
						For ($n;1;Size of array:C274($ref_cargos_aparte))
							USE SET:C118("Cargos Aparte")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$ref_cargos_aparte{$n};*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CuentaCorriente:2=$aID_Ctas{$i})
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							CREATE SET:C116([ACT_Transacciones:178];"Tran1")
							INTERSECTION:C121("Trans";"Tran1";"Tran1")
							USE SET:C118("Tran1")
							ARRAY LONGINT:C221($aTrans;0)
							
							SELECTION TO ARRAY:C260([ACT_Transacciones:178];$aTrans)
							
							$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$aTrans;->[ACT_Transacciones:178]Debito:6)
							
							APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
							APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
						End for 
					End if 
					
					
					CLEAR SET:C117("CargosCta")
					$pagado:=AT_GetSumArray (->$aDetalleMontosPagados)
					APPEND TO ARRAY:C911($aDetalleMontosPagados;$pagado)
					APPEND TO ARRAY:C911($aAcumParaSubtotal;$pagado)
					
					
					  // Modificado por: Alexis Bustamante (18-02-2016)
					If ($i=1)
						  //Solo en la primera vuelta  se crean los arreglos acorde a la cantidad de columnas
						  //Guardo la cantidad de columnas hasta el total final ->
						  //para utilizar en el calculo de los Subtotal
						$cantColum:=Size of array:C274($aDetalleMontosPagados)
						For (vQr_long10;1;$cantColum)
							vQR_pointer1:=Get pointer:C304("aQR_real"+String:C10(vQr_long10))
							ARRAY REAL:C219(vQR_pointer1->;0)
						End for 
					End if 
					
					  //GUARDAR DESGLOSE de MONTOS 
					For (vQR_long10;1;Size of array:C274($aDetalleMontosPagados))
						vQR_pointer1:=Get pointer:C304("aQr_real"+String:C10(vQR_long10))
						APPEND TO ARRAY:C911(vQR_pointer1->;$aDetalleMontosPagados{vQR_long10})
					End for 
					
					$texto:=AT_array2text (->$aDetalleMontosPagados;"\t";"|Despliegue_ACT_Pagos")
					
					IO_SendPacket ($ref;$texto+"\r\n")
					
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/(Size of array:C274($aID_Ctas)))
				End for 
				
		End case 
		
		ARRAY REAL:C219($aSubtotal;0)
		C_LONGINT:C283($cant;$cant2;$posicion)
		
		If (sel2_Categ=1)
			$cant:=(Size of array:C274($aMeses))+(Size of array:C274($al_id_categoria))+(Size of array:C274($al_items_sin_categoria))+1
		Else 
			$cant:=(Size of array:C274($aMeses))+(Size of array:C274($ref_cargos_aparte))+1
		End if 
		
		If ($todo_disponible>0)
			$cant:=$cant+1
		End if 
		
		Case of 
			: (op2_apo=1)
				$cant2:=Size of array:C274($aID_Apoderados)
			: (op1_ctas=1)
				$cant2:=Size of array:C274($aID_Ctas)
		End case 
		
		C_REAL:C285($monto_sumado_col)
		
		  // Modificado por: Alexis Bustamante (18-02-2016)
		  //Para que se Sume (Vertical) por Columnas.
		ARRAY REAL:C219($aR_Colum;0)
		ARRAY TEXT:C222($aT_Colum;0)
		For (vQR_long99;1;$cantColum)
			vQR_pointer1:=Get pointer:C304("aQr_real"+String:C10(vQR_long99))
			COPY ARRAY:C226(vQR_pointer1->;$aR_Colum)
			vQR_real1:=AT_GetSumArray (->$aR_Colum)
			APPEND TO ARRAY:C911($aT_Colum;String:C10(vQR_real1))
		End for 
		
		
		
		If (op2_apo=1)
			IO_SendPacket ($ref;"\t"+__ ("TOTAL")+"\t")
		Else 
			IO_SendPacket ($ref;"\t"+"\t"+__ ("TOTAL")+"\t")
		End if 
		
		$texto:=AT_array2text (->$aT_Colum;"\t";"|Despliegue_ACT_Pagos")
		IO_SendPacket ($ref;$texto+"\r\n")
		
		IO_SendPacket ($ref;" "+"\r\n"+"\r\n")
		
		C_REAL:C285($total)
		
		  //$total:=(AT_GetSumArray (->$aAcumParaTotalF))+$disponible
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		SET_ClearSets ("Cargos adelantados";"Cargos aparte";"Trans";"Tran1";"PAGOS1";"PAGOS2")
		
		CLOSE DOCUMENT:C267($ref)
		
		ACTcd_DlogWithShowOnDisk ($filePath;0;__ ("El Detalle de los Pagos ")+$fileName+__ (" ha concluido.")+"\r\r"+__ ("Lo encontrará en: ")+"\r"+$folderPath+"\r\r"+__ ("Le recomendamos abrirla con Microsoft Excel."))
	Else 
		CD_Dlog (0;__ ("Se produjo un error al intentar crear el archivo. El archivo puede estar abierto por otra aplicación, si es así, ciérrelo e intente nuevamente."))
		
	End if 
	USE CHARACTER SET:C205(*;0)
Else 
	CD_Dlog (0;__ ("No se encontraron cargos pagados a detallar dentro del periodo seleccionado"))
End if 

