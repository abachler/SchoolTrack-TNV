//%attributes = {}
  //ACTcc_GeneraCargos

  //^REGISTOR DE CAMBIOS
  //20080318 RCH 
  //Problema: Cuando se generaba por opcion 3 y ya había un aviso emitido por la matriz, al emitir el nuevo aviso también se emitían los cargos asociados a la matriz. 
  //Solucion implementada: Cuando no se crea el documento de cargo, se busca un documento de cargo para la cuenta, para la matriz, para el mes y año del documento NO emitido.


  //Declaraciones (ABK 2011/01/08)
C_LONGINT:C283(vl_AvisosEncontrados;vl_CargosEncontrados)
  // Fin declaraciones (ABK 2011/01/08)
C_BOOLEAN:C305($b_TerminarDeGenerar)
$b_TerminarDeGenerar:=True:C214

MESSAGES OFF:C175

C_BOOLEAN:C305(Generar;vbACT_Generando;vbACT_TerminardeGenerar;vb_calcularCtas)
vbACT_Generando:=False:C215  //se inicializa en false la variable por problemas que ocurrían en algunas oportunidades al emitir avisos de cobranza. ACTcc_EmisionAvisos no esperaba que este proceso terminara y finalizaba antes que este.
vbACT_TerminardeGenerar:=False:C215
vb_calcularCtas:=True:C214
C_BLOB:C604($1;xBlob)
C_DATE:C307($date)
C_LONGINT:C283($startAtMonth;$endAtMonth;$matrixId;$itemID;$vl_proc)
_O_C_INTEGER:C282($diaGeneracion;$diaVencimiento)
ARRAY LONGINT:C221(aLong1;0)
ARRAY LONGINT:C221($aRecNums;0)
ARRAY LONGINT:C221(alACT_CuentasTomadas;0)
ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)
C_PICTURE:C286($2)

ACTcfg_OpcionesDescuentos ("DeclaraArreglosCalc")  //20161202 ASM Ticket 171933
ACTinit_LoadPrefs   //lectura de las preferencias generales
ACTcc_OpcionesCalculoCtaCte ("InitArrays")
ACTcfg_ItemsMatricula ("InicializaYLee")

ARRAY LONGINT:C221(alACT_NewDctoCargo;0)
alACT_NewDctoCargo:=1

$Termometro:=True:C214
xBlob:=$1
If (Count parameters:C259>1)
	vpXS_IconModule:=$2
	vsBWR_CurrentModule:=$3
End if 
If (Count parameters:C259>=4)
	$Termometro:=$4
End if 

If (Count parameters:C259>=5)
	$b_TerminarDeGenerar:=$5
End if 

  //BLOB_Blob2Vars (->xBlob;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso;->bc_EliminaDesctos;->vsACT_CtaContable;->vsACT_CentroContable;->vsACT_CCtaContable;->vsACT_CCentroContable;->vbACT_ImputacionUNica;->vsACT_CodAuxCta;->vsACT_CodAuxCCta;->cbACT_NoDocTrib;->vdACT_FechaUFSel;->vdACT_AñoAviso2;->atACT_NombreMonedaEm;->adACT_fechasEm;->vbACT_montoAnual;->vlACT_numeroCuotas)
ACTcar_OpcionesGenerales ("CargaVarsParaGeneracion";->xBlob)
$ExecuteOnServer:=bc_ExecuteOnServer
$fromMonth:=aMeses
$toMonth:=aMeses2
If (vdACT_AñoAviso=0)
	vdACT_AñoAviso:=Year of:C25(Current date:C33(*))
End if 
$matrixId:=vlACT_SelectedMatrixID
$itemID:=vlACT_selectedItemId
$diaGeneracion:=viACT_DiaGeneracion
$ufDate:=vdACT_FechaUFSel

COPY ARRAY:C226(aLong1;$aRecNums)
READ WRITE:C146([ACT_CuentasCorrientes:175])
CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$aRecNums;"")
CREATE SET:C116([ACT_CuentasCorrientes:175];"todas")
APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1:=[ACT_CuentasCorrientes:175]ID:1)
DIFFERENCE:C122("todas";"LockedSet";"todas")
USE SET:C118("LockedSet")
LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];alACT_CuentasTomadas;"")
USE SET:C118("todas")
CLEAR SET:C117("todas")
LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$aRecNums;"")
COPY ARRAY:C226($aRecNums;aLong1)

If ($Termometro)
	If (Application type:C494#4D Server:K5:6)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando/actualizando deudas..."))
	Else 
		$vl_proc:=IT_UThermometer (1;0;__ ("Generando/actualizando deudas..."))
	End if 
End if 

$year:=vdACT_AñoAviso
$year2:=vdACT_AñoAviso2
If ($year#$year2)
	$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
Else 
	$toMonth:=$toMonth-$fromMonth+1
End if 
$iterations:=$toMonth*Size of array:C274($aRecNums)
If ($iterations>=30)
	$div:=30
Else 
	$div:=1
End if 
$currentIteration:=0
$indexPrev:=0
For ($monthIndex;1;$toMonth)  //Loop por los meses a generar
	If (Int:C8(($monthIndex+$fromMonth+$indexPrev-1)/13)>$indexPrev)
		$indexPrev:=Int:C8(($monthIndex+$fromMonth+$indexPrev-1)/13)
		$month:=$monthIndex-(12*$indexPrev)+$fromMonth-1
		$year:=$year+1
	Else 
		$month:=$monthIndex-(12*$indexPrev)+$fromMonth-1
	End if 
	
	If (ACTcm_IsMonthOpenFromMonthYear ($month;$year))
		$date:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($diaGeneracion;$month;$year))
		
		$fechaVencimiento:=!00-00-00!
		
		For ($recnumIndex;1;Size of array:C274($aRecNums))  //Loop por las ctas ctes.
			
			$currentIteration:=$currentIteration+1
			
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aRecNums{$recNumIndex})
			If (Not:C34(Locked:C147([ACT_CuentasCorrientes:175])))
				ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
				SET QUERY DESTINATION:C396(Into variable:K19:4;vl_AvisosEncontrados)
				
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6=$month;*)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Agno:7=$year)
				
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;vl_CargosEncontrados)
				
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
				
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				  // busqueda o creación del documento de cargo
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
				  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]ID_Matriz=[ACT_CuentasCorrientes]ID_Matriz;*)
				  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Año=$year;*)
				  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Mes=$month)
				$key:=String:C10([ACT_CuentasCorrientes:175]ID:1)+"."+String:C10($year)+"."+String:C10($month)+"."+String:C10([ACT_CuentasCorrientes:175]ID_Matriz:7)
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]Key_Emision:25=$key)
				QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Tercero:24=0)
				CREATE SET:C116([ACT_Documentos_de_Cargo:174];"DocCargo")
				
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				
				$CrearDocCargo:=False:C215
				
				Case of 
						
					: ((vl_AvisosEncontrados#0) & (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0))
						$CrearDocCargo:=True:C214
					: (Records in selection:C76([ACT_Documentos_de_Cargo:174])=0)
						$CrearDocCargo:=True:C214
					: ((Records in selection:C76([ACT_Documentos_de_Cargo:174])>0) & (Records in selection:C76([ACT_Cargos:173])>0) & (b2=1))
						$CrearDocCargo:=True:C214
					: ((Records in selection:C76([ACT_Documentos_de_Cargo:174])>0) & (Records in selection:C76([ACT_Cargos:173])>0) & (b3=1) & (bc_ReplaceSameDescription=0))
						$CrearDocCargo:=True:C214
					: ((Records in selection:C76([ACT_Documentos_de_Cargo:174])>0) & (Records in selection:C76([ACT_Cargos:173])>0) & (b3=1) & (bc_ReplaceSameDescription=1))
						SET QUERY DESTINATION:C396(Into variable:K19:4;$CargosIguales)
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Glosa:12=vsACT_Glosa;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=-1;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
						If ($CargosIguales=0)
							$CrearDocCargo:=True:C214
						End if 
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
				End case 
				If ($CrearDocCargo)
					CREATE RECORD:C68([ACT_Documentos_de_Cargo:174])
					[ACT_Documentos_de_Cargo:174]ID_Documento:1:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
					[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6:=[ACT_CuentasCorrientes:175]ID:1
					[ACT_Documentos_de_Cargo:174]ID_Alumno:11:=[ACT_CuentasCorrientes:175]ID_Alumno:3
					[ACT_Documentos_de_Cargo:174]ID_Apoderado:12:=[ACT_CuentasCorrientes:175]ID_Apoderado:9
					Case of 
						: (b1=1)
							$matriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
							QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=$matriz)
							$moneda:=[ACT_Matrices:177]Moneda:9
						: (b2=1)
							$matriz:=-2
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$ItemID)
							$moneda:=[xxACT_Items:179]Moneda:10
						: (b3=1)
							$matriz:=-1
							$moneda:=vsACT_Moneda
					End case 
					[ACT_Documentos_de_Cargo:174]ID_Matriz:2:=$matriz
					[ACT_Documentos_de_Cargo:174]Moneda:23:=$moneda
					[ACT_Documentos_de_Cargo:174]Año:14:=$year
					[ACT_Documentos_de_Cargo:174]Mes:13:=$month
					[ACT_Documentos_de_Cargo:174]FechaGeneracion:7:=$date
					[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=$fechaVencimiento
					SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
					SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCta)
					LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
				Else 
					  //READ WRITE([ACT_Documentos_de_Cargo])
					  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
					  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Año=$year;*)
					  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Mes=$month;*)
					  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]FechaEmision=!00-00-00!)
					READ WRITE:C146([ACT_Documentos_de_Cargo:174])
					  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
					  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]ID_Matriz=[ACT_CuentasCorrientes]ID_Matriz;*)
					  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Año=$year;*)
					  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]Mes=$month;*)
					  //QUERY([ACT_Documentos_de_Cargo]; & ;[ACT_Documentos_de_Cargo]FechaEmision=!00-00-00!)
					  //$key:=String([ACT_CuentasCorrientes]ID)+"."+String($year)+"."+String($month)+"."+String([ACT_CuentasCorrientes]ID_Matriz)
					  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]Key_Emision=$key)
					USE SET:C118("DocCargo")
					CLEAR SET:C117("DocCargo")
					QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]FechaEmision:21=!00-00-00!)
					
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocsCta)
					LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
				End if 
				Case of 
					: (vl_AvisosEncontrados>0)
						Case of 
							: (b1=1)
								SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocs)
								For ($i_Docs;1;Size of array:C274($aRecNumDocs))
									GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$aRecNumDocs{$i_Docs})
									QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1;*)
									QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
									QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year;*)
									QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
									QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
									SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumsCargos)
									If (bc_EliminaDesctos=1)
										READ WRITE:C146([xxACT_DesctosXItem:103])
										FIRST RECORD:C50([ACT_Cargos:173])
										While (Not:C34(End selection:C36([ACT_Cargos:173])))
											QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
											DELETE RECORD:C58([xxACT_DesctosXItem:103])
											NEXT RECORD:C51([ACT_Cargos:173])
										End while 
										READ ONLY:C145([xxACT_DesctosXItem:103])
									End if 
									If (Size of array:C274($aRecNumsCargos)>0)
										For ($i_Cargos;1;Size of array:C274($aRecNumsCargos))
											GOTO RECORD:C242([ACT_Cargos:173];$aRecNumsCargos{$i_Cargos})
											QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
											$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
											ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes:175]ID_Matriz:7)
											QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
											QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
											UNLOAD RECORD:C212([ACT_Cargos:173])
											If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
												$itemnomatriz:=False:C215
											Else 
												$itemnomatriz:=True:C214
											End if 
											READ WRITE:C146([ACT_Cargos:173])
											ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};$idmatriz;$itemnomatriz;$ufDate;"";False:C215;$monthIndex)
											KRL_UnloadReadOnly (->[ACT_Cargos:173])
										End for 
									Else 
										READ WRITE:C146([ACT_CuentasCorrientes:175])
										QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)
										ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes:175]ID_Matriz:7)
									End if 
								End for 
								For ($Docs;1;Size of array:C274($aRecNumDocs))
									ACTcc_RecalculaCargosyDocs ($aRecNumDocs{$Docs};$month;$year;$date;$fechaVencimiento;True:C214;False:C215;False:C215;$ufDate;$monthIndex)
								End for 
							: (b2=1)
								ACTcfg_OpcionesArraysItemsM ("InsertaElementosDesdeID";->$itemID)
								For ($Docs;1;Size of array:C274($aRecNumDocsCta))
									ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;True:C214;False:C215;False:C215;$ufDate;$monthIndex)
								End for 
							: (b3=1)
								ACTcfg_OpcionesArraysItemsM ("InsertaElementosDesdeID";->$itemID)
								For ($Docs;1;Size of array:C274($aRecNumDocsCta))
									ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;False:C215;False:C215;True:C214;$ufDate;$monthIndex)
								End for 
						End case 
					: (b1=1)  // generar cargos utilizando la matriz asignada
						SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$aRecNumDocs)
						For ($i_Docs;1;Size of array:C274($aRecNumDocs))
							GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$aRecNumDocs{$i_Docs})
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumsCargos)
							If (bc_EliminaDesctos=1)
								READ WRITE:C146([xxACT_DesctosXItem:103])
								FIRST RECORD:C50([ACT_Cargos:173])
								While (Not:C34(End selection:C36([ACT_Cargos:173])))
									QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
									DELETE RECORD:C58([xxACT_DesctosXItem:103])
									NEXT RECORD:C51([ACT_Cargos:173])
								End while 
								READ ONLY:C145([xxACT_DesctosXItem:103])
							End if 
							If (Size of array:C274($aRecNumsCargos)>0)
								For ($i_Cargos;1;Size of array:C274($aRecNumsCargos))
									GOTO RECORD:C242([ACT_Cargos:173];$aRecNumsCargos{$i_Cargos})
									QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
									$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7
									ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes:175]ID_Matriz:7)
									QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
									QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
									UNLOAD RECORD:C212([ACT_Cargos:173])
									If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
										$itemnomatriz:=False:C215
									Else 
										$itemnomatriz:=True:C214
									End if 
									READ WRITE:C146([ACT_Cargos:173])
									ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};$idmatriz;$itemnomatriz;$ufDate;"";False:C215;$monthIndex)
									KRL_UnloadReadOnly (->[ACT_Cargos:173])
								End for 
							Else 
								READ WRITE:C146([ACT_CuentasCorrientes:175])
								QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)
								ACTcfg_loadMatrixItems ([ACT_CuentasCorrientes:175]ID_Matriz:7)
							End if 
						End for 
						For ($Docs;1;Size of array:C274($aRecNumDocs))
							ACTcc_RecalculaCargosyDocs ($aRecNumDocs{$Docs};$month;$year;$date;$fechaVencimiento;True:C214;False:C215;False:C215;$ufDate;$monthIndex)
						End for 
					: (b2=1)  // generar cargos utilizando el item de cargo seleccionado
						ACTcfg_OpcionesArraysItemsM ("InsertaElementosDesdeID";->$itemID)
						For ($Docs;1;Size of array:C274($aRecNumDocsCta))
							ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;True:C214;False:C215;False:C215;$ufDate;$monthIndex)
						End for 
					: (b3=1)  // generar cargo extraordinario      
						ACTcfg_OpcionesArraysItemsM ("InsertaElementosDesdeID";->$itemID)
						For ($Docs;1;Size of array:C274($aRecNumDocsCta))
							ACTcc_RecalculaCargosyDocs ($aRecNumDocsCta{$Docs};$month;$year;$date;$fechaVencimiento;False:C215;False:C215;True:C214;$ufDate;$monthIndex)
						End for 
				End case 
			Else 
				$existe:=Find in array:C230(alACT_CuentasTomadas;Record number:C243([ACT_CuentasCorrientes:175]))
				  //20130107 RCH Cuando la cuenta era tomada dentro del for no se alertaba correctamente.
				  //If ($existe#-1)
				If ($existe=-1)
					AT_Insert (1;1;->alACT_CuentasTomadas)
					alACT_CuentasTomadas{1}:=Record number:C243([ACT_CuentasCorrientes:175])
					$existe:=Find in array:C230(aLong1;alACT_CuentasTomadas{1})
					AT_Delete ($existe;1;->aLong1)
				End if 
			End if 
			If ($Termometro)
				If (Application type:C494#4D Server:K5:6)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Generando/actualizando deudas para el mes de ")+atACT_Meses{$month}+__ (" de ")+String:C10($year)+"...")
				End if 
			End if 
		End for 
	End if 
End for 

If (alACT_NewDctoCargo=1)
	For ($i;1;Size of array:C274(alACT_NewDctoCargo))
		ACTcc_CalculaDocumentoCargo (alACT_NewDctoCargo{$i})
	End for 
End if 
ARRAY LONGINT:C221(alACT_NewDctoCargo;0)
alACT_NewDctoCargo:=0

If ($Termometro)
	If (Application type:C494#4D Server:K5:6)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		If ($vl_proc#0)
			IT_UThermometer (-2;$vl_proc)
		End if 
	End if 
End if 

KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
KRL_UnloadReadOnly (->[ACT_Transacciones:178])

vbACT_Generando:=True:C214
If ($b_TerminarDeGenerar)
	  //DELAY PROCESS(Current process;60)  `permitir que el proceso que llama a este lea vbACT_Generando
	While (Not:C34(vbACT_TerminardeGenerar))
		IDLE:C311
		DELAY PROCESS:C323(Current process:C322;5)
	End while 
	If (vb_calcularCtas)  //si se está sólo generando se recalculan las cuentas. Si se está emitiendo no se recalcula
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->vb_calcularCtas)
		ACTcfg_ItemsMatricula ("ActualizaCampoDesdeProyectado")
	End if 
End if 
