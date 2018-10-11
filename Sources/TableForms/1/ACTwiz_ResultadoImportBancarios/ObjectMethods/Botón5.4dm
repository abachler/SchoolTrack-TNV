  //aDescRechazo
ARRAY TEXT:C222(<>atACT_DescRechazos;0)
_O_ARRAY STRING:C218(80;<>asACT_RutRechazos;0)
ARRAY LONGINT:C221(<>aIDAvisoRechazo;0)
ARRAY REAL:C219(<>aMontoRechazo;0)  //20141029 RCH

C_TEXT:C284(<>vtACT_TipoImport)
COPY ARRAY:C226(aDescRechazo;<>atACT_DescRechazos)
COPY ARRAY:C226(aRUTRechazo;<>asACT_RutRechazos)
COPY ARRAY:C226(aIDAvisoRechazo;<>aIDAvisoRechazo)
COPY ARRAY:C226(aMontoRechazo;<>aMontoRechazo)  //20141029 RCH
ARRAY TEXT:C222(atACT_Modelos;0)
<>vtACT_TipoImport:=vTipo

READ ONLY:C145([xShell_Reports:54])
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[Personas:7]);*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]Modulo:41="AccountTrack";*)  //20150409 RCH Se agrega filtro
QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]ReportType:2="gSR2";*)  //20150409 RCH Se agrega filtro
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="Carta de Aviso de Rechazo@")
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)

SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;atACT_Modelos)

If (Size of array:C274(atACT_Modelos)>0)
	ok:=1
	If (Size of array:C274(atACT_Modelos)>1)
		SRtbl_ShowChoiceList (0;"Seleccione un modelo...";1;->cs_Apdos;False:C215;->atACT_Modelos)
	Else 
		choiceIdx:=1
	End if 
	If (ok=1)
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		If (Size of array:C274(aRUTRechazo)=0)
			CD_Dlog (0;"No hay apoderados con rechazo...")
		Else 
			CREATE EMPTY SET:C140([Personas:7];"SetPersonasRechazo")
			vLinkingField:=Field:C253(vRUTTable;vRUTField)
			vLinkingTable:=Table:C252(vRUTTable)
			For ($i;1;Size of array:C274(aRUTRechazo))
				C_POINTER:C301($ptr_Id)
				C_LONGINT:C283($vl_valor)
				C_TEXT:C284($vt_valor)
				If (aIDAvisoRechazo{$i}=0)
					If (vLabelLink="ID")
						$vl_valor:=Num:C11(aRUTRechazo{$i})
						$ptr_Id:=->$vl_valor
					Else 
						$vt_valor:=aRUTRechazo{$i}
						$ptr_Id:=->$vt_valor
					End if 
					QUERY:C277(vLinkingTable->;vLinkingField->=$ptr_Id->)
				Else 
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=aIDAvisoRechazo{$i})
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				End if 
				Case of 
					: (Table:C252(vLinkingTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
						QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
					: (Table:C252(vLinkingTable)=Table:C252(->[Alumnos:2]))
						QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
				End case 
				ADD TO SET:C119([Personas:7];"SetPersonasRechazo")
			End for 
			USE SET:C118("SetPersonasRechazo")
			CLEAR SET:C117("SetPersonasRechazo")
			
			READ ONLY:C145([xShell_Reports:54])
			QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[Personas:7]);*)
			QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]isOneRecordReport:11;=;True:C214;*)
			QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=atACT_Modelos{choiceIdx})
			If (Records in selection:C76([xShell_Reports:54])=1)
				If (Records in selection:C76([Personas:7])>0)
					ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
					  //COPY NAMED SELECTION([Personas];"<>Editions")
					CUT NAMED SELECTION:C334([Personas:7];"<>Editions")  //20170315 RCH La selección se crea con CUT
					$processName:="Impresión de: "+[xShell_Reports:54]ReportName:26
					$reportRecNum:=Record number:C243([xShell_Reports:54])
					QR_ImprimeInformeSRP ($reportRecNum)
					CLEAR NAMED SELECTION:C333("<>Editions")
				End if 
			Else 
				CD_Dlog (0;"No fue encontrado el modelo de reporte.")
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;"No fue encontrado algún modelo de reporte desde Personas, un documento por regist"+"ro, llamado "+ST_Qte ("Carta de Aviso de Rechazo@")+".")
End if 
<>vtACT_TipoImport:=""