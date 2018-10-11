//%attributes = {}
  //ACTabc_ExportPorColegio

C_TEXT:C284($1;$fileName)
C_REAL:C285($MontoNum)
C_LONGINT:C283($exporter;$2)
C_BOOLEAN:C305(vb_detenerImp)
vb_detenerImp:=False:C215

$fileName:=$1
$exporter:=$2

If (cbMontoaPagar=1)
	$TableNumtxt:=String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
	$FieldNumtxt:=String:C10(Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
Else 
	$TableNumtxt:=String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
	$FieldNumtxt:=String:C10(Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
End if 

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Familia:78])
$0:=1

$exportador:=Find in field:C653([xxACT_ArchivosBancarios:118]ID:1;$exporter)
If ($exportador#-1)
	vb_continuarExport:=True:C214
	If (vl_SeleccionItem=1)
		C_LONGINT:C283(cs_todasRazones)
		ACTabc_SelectionItem2Export 
		If ((cs_todasRazones=0) & (atACTcfg_Razones#0))
			$fileName:=Substring:C12($fileName;1;3)+"_"+ST_RetornaSiglaDesdeFrase (atACTcfg_Razones{atACTcfg_Razones})+"_"+Substring:C12($fileName;4;Length:C16($fileName))
		End if 
	End if 
	If (vb_continuarExport)
		USE CHARACTER SET:C205("windows-1252";0)
		READ ONLY:C145([xxACT_ArchivosBancarios:118])
		GOTO RECORD:C242([xxACT_ArchivosBancarios:118];$exportador)
		$vl_idFormaDePago:=[xxACT_ArchivosBancarios:118]id_forma_de_pago:13
		$tipo:=[xxACT_ArchivosBancarios:118]Tipo:6
		ACTtrf_ValidaArchivoBancario 
		If ([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=False:C215)
			$offset:=0
			vtCode:=BLOB to text:C555([xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10;$offset;32000)
			vtCode:=ACTtrf_RemoveCheckCode (vtCode)
			$valid:=ACTtrf_IsColegiumTransferFile (vtCode)
			If ($valid)
				  //EXE_Execute (vt_code)
				EXE_Execute (vtCode;False:C215;"";->$fileName;->$TableNumtxt;->$FieldNumtxt)
				
				
				vtCode:=""
			Else 
				$0:=0
			End if 
		Else 
			C_LONGINT:C283($idExporter)
			$idExporter:=[xxACT_ArchivosBancarios:118]ID:1
			ACTtrf_Master (1)
			ACTtrf_Master (2;String:C10($idExporter))
			$0:=ACTabc_ExportMasterTrf ($fileName;$TableNumtxt;$FieldNumtxt;vd_FechaUF;$vl_idFormaDePago)
		End if 
		USE CHARACTER SET:C205(*;0)
	Else 
		$0:=0
	End if 
Else 
	$0:=0
End if 
vfechaPAC:=String:C10(vd_Fecha3;7)
If ($0=1)
	LOG_RegisterEvt ("Exportación de archivo bancario tipo "+$tipo+" "+$fileName+".")
End if 