//%attributes = {}
C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$fileName2;$folderPath;$filePath;$fecha;$numTrans)
C_TEXT:C284($line)
C_LONGINT:C283($i;$Apdo;$linea;$j)
C_TIME:C306($ref)
C_TEXT:C284($diaFecha;$montoTotal;$header)
C_REAL:C285($vr_monto)
C_POINTER:C301(vQR_Pointer1)
C_REAL:C285($vr_valor;$vr_valorInt;$vr_valorDec)

ARRAY LONGINT:C221(al_DiasDePago;0)

ACTcfg_OpcionesRecargosAut ("LeeBlob")
$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
End if 

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])

CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"TodosAvisos")
vtotalPAC:=""
vnumTransPAC:=""

KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
CREATE SET:C116([Personas:7];"TodosPersonas")
DISTINCT VALUES:C339([Personas:7]ACT_DiaCargo:61;al_DiasDePago)

For ($j;1;Size of array:C274(al_DiasDePago))
	$fileName2:=Substring:C12($fileName;1;Length:C16($fileName)-4)+"_"+String:C10(al_DiasDePago{$j})+".txt"
	$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName2)
	If ($ref#?00:00:00?)
		
		USE SET:C118("TodosPersonas")
		USE SET:C118("TodosAvisos")
		QUERY SELECTION:C341([Personas:7];[Personas:7]ACT_DiaCargo:61=al_DiasDePago{$j})
		SELECTION TO ARRAY:C260([Personas:7]No:1;aQR_Longint1)
		QUERY SELECTION WITH ARRAY:C1050([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;aQR_Longint1)
		
		ARRAY TEXT:C222(aQR_Text1;0)
		ARRAY TEXT:C222(aQR_Text2;0)
		ARRAY TEXT:C222(aQR_Text3;0)
		ARRAY TEXT:C222(aQR_Text4;0)
		ARRAY TEXT:C222(aQR_Text5;0)
		ARRAY TEXT:C222(aQR_Text6;0)
		ARRAY TEXT:C222(aQR_Text7;0)
		  //ARRAY TEXT(aQR_Text8;0)
		ARRAY REAL:C219(aQR_Real8;0)
		ARRAY TEXT:C222(aQR_Text9;0)
		ARRAY TEXT:C222(aQR_Text10;0)
		ARRAY TEXT:C222(aQR_Text11;0)
		
		ARRAY LONGINT:C221(aidsAvisos;0)
		ARRAY LONGINT:C221(aidsPersonas;0)
		
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aidsAvisos;"")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información para archivo PAC para el día de cargo "+String:C10(al_DiasDePago{$j})+"...")
		For ($i;1;Size of array:C274(aidsAvisos))
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aidsAvisos{$i})
			
			  //calculos de ac. Se calcula segun fecha de moneda variable
			  //tramo item. Se calcula
			C_LONGINT:C283(vlACT_itemTramo)
			vlACT_itemTramo:=0
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(alACT_idTramo;0)
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
			ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
			If (ACTitems_OpcionesRecalculoTramo ("BuscaItemsUtilizaTramo";->aQR_Longint1)="1")
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;aQR_Longint1)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=vd_FechaUF)
				ACTitems_OpcionesRecalculoTramo ("CalculaMultaParaCargos";->vd_FechaUF)
				AT_Initialize (->alACT_recNumNewC;->alACT_recNumDelC)
			End if 
			  //multas automaticas...
			ACTcfg_OpcionesRecargosAut ("GeneraMultaAutomatica";->aidsAvisos{$i};->vlACTcfg_SelectedItemAut;->vd_FechaUF)
			  //calculos de ac
			
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aidsAvisos{$i})
			$Apdo:=Find in field:C653([Personas:7]No:1;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			If ($Apdo#-1)
				GOTO RECORD:C242([Personas:7];$Apdo)
			Else 
				REDUCE SELECTION:C351([Personas:7];0)
			End if 
			$linea:=Find in array:C230(aidsPersonas;[Personas:7]No:1)
			If ($linea=-1)
				AT_Insert (1;1;->aidsPersonas;->aQR_Text1;->aQR_Text2;->aQR_Text3;->aQR_Text4;->aQR_Text5;->aQR_Text6;->aQR_Text7;->aQR_Real8;->aQR_Text9;->aQR_Text10;->aQR_Text11)
				aidsPersonas{1}:=[Personas:7]No:1
				
				aQR_Text1{1}:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_ID_Banco_Cta:48;"N";3)
				aQR_Text2{1}:="004"
				aQR_Text3{1}:="030"
				aQR_Text4{1}:="D"
				aQR_Text5{1}:=ACTabc_GetFieldWithFormat (Replace string:C233([Personas:7]ACT_RUTTitutal_Cta:50;"-";"");"N";9)+(" "*13)
				aQR_Text6{1}:=" "
				aQR_Text7{1}:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_Titular_Cta:49;"A";10)
				If (vl_otrasMonedas=1)
					aQR_Real8{1}:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMPago";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;vQR_Pointer1;vd_FechaUF))
				Else 
					aQR_Real8{1}:=Abs:C99($FieldPtr->)
				End if 
				aQR_Text9{1}:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4);"00")
				aQR_Text10{1}:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
				aQR_Text11{1}:=".........."
				
			Else 
				If (vl_otrasMonedas=1)
					$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMPago";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;vQR_Pointer1;vd_FechaUF))
				Else 
					$vr_monto:=Abs:C99($FieldPtr->)
				End if 
				aQR_Real8{$linea}:=aQR_Real8{$linea}+$vr_monto
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAC para el día de cargo "+String:C10(al_DiasDePago{$j})+"...")
			
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAC para el día de cargo "+String:C10(al_DiasDePago{$j})+"...")
		For ($i;1;Size of array:C274(aidsPersonas))
			$vr_valor:=Round:C94(aQR_Real8{$i};2)
			$vr_valorInt:=Int:C8($vr_valor)
			$vr_valorDec:=Dec:C9($vr_valor)*100
			$line:=aQR_Text1{$i}+aQR_Text2{$i}+aQR_Text3{$i}+aQR_Text4{$i}+aQR_Text5{$i}+aQR_Text6{$i}+aQR_Text7{$i}+ACTabc_GetFieldWithFormat (String:C10($vr_valorInt);"N";9)+String:C10($vr_valorDec;"00")+aQR_Text9{$i}+aQR_Text10{$i}+aQR_Text11{$i}+"\r\n"
			IO_SendPacket ($ref;$line)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsPersonas);"Generando archivo PAC para el día de cargo "+String:C10(al_DiasDePago{$j})+"...")
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		vtotalPAC:=String:C10(Num:C11(vtotalPAC)+AT_GetSumArray (->aQR_Real8);"|Despliegue_ACT")
		
		  //registro control
		$line:="001"+"004"+"030"+"T"+(" "*33)+ACTabc_GetFieldWithFormat (String:C10(AT_GetSumArray (->aQR_Real8));"N";11)+ACTabc_GetFieldWithFormat (String:C10(Size of array:C274(aQR_Real8));"N";6)+"N"+"0"+("."*18)
		IO_SendPacket ($ref;$line)
		CLOSE DOCUMENT:C267($ref)
		vnumTransPAC:=String:C10(Num:C11(vnumTransPAC)+Size of array:C274(aidsPersonas))
		
		ARRAY LONGINT:C221(aidsAvisos;0)
		ARRAY LONGINT:C221(aidsPersonas;0)
		AT_Initialize (->aQR_Text1;->aQR_Text2;->aQR_Text3;->aQR_Text4;->aQR_Text5;->aQR_Text6;->aQR_Text7;->aQR_Real8;->aQR_Text9;->aQR_Text10;->aQR_Text11)
	Else 
		vb_detenerImp:=True:C214
		$j:=Size of array:C274(al_DiasDePago)
	End if 
	
End for 
SET_ClearSets ("TodosPersonas";"TodosAvisos")