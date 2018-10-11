//%attributes = {}
  //ACTabc_ExportPACMontessori

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!

vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_LONGINT:C283($i;$Apdo;$vl_total)
C_TEXT:C284($fileName;$folderPath;$filePath;$fecha;$linea;$separador;$fechaEmision)
C_TIME:C306($ref)
C_REAL:C285($vr_monto)

ARRAY LONGINT:C221(al_AviRRNN;0)
ARRAY LONGINT:C221(aidsAvisos;0)
ARRAY LONGINT:C221(al_idApdosMonte;0)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
End if 
$separador:="|"
vFechaPAC:=String:C10(Current date:C33(*);7)
vtotalPAC:=""
vnumTransPAC:=""

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)
If ($ref#?00:00:00?)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];al_AviRRNN;"")
	COPY ARRAY:C226(al_AviRRNN;aidsAvisos)
	
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	
	ARRAY TEXT:C222(at_AviNumero;0)
	ARRAY TEXT:C222(at_AviSegFechaPago;0)
	ARRAY TEXT:C222(at_FamCodInterno;0)
	ARRAY TEXT:C222(at_AviMonAPagar;0)
	ARRAY TEXT:C222(at_AviMonIVA;0)
	ARRAY TEXT:C222(at_CarDetalle;0)
	ARRAY TEXT:C222(at_PerEmail;0)
	ARRAY TEXT:C222(at_FamNombre;0)
	ARRAY TEXT:C222(at_PerTelefono;0)
	
	For ($i;1;$vl_total)
		C_TEXT:C284($vt_glosa)
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];al_AviRRNN{$i})
		apdoRecNum:=Find in field:C653([Personas:7]No:1;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		If (apdoRecNum#-1)
			GOTO RECORD:C242([Personas:7];apdoRecNum)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			If (KRL_isSameField (vQR_Pointer1;->[ACT_Cargos:173]Saldo:23))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			End if 
			$fechaEmision:=String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18))+"/"+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18))+"/"+String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18))
			If (Records in selection:C76([ACT_Cargos:173])>0)
				ARRAY LONGINT:C221(aQR_Longint2;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2;"")
				$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->aQR_Longint2;vQR_Pointer1;vd_FechaUF))
				KRL_RelateSelection (->[Alumnos:2]Apoderado_Cuentas_Número:28;->[Personas:7]No:1;"")
				QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
				APPEND TO ARRAY:C911(at_AviNumero;String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
				APPEND TO ARRAY:C911(at_AviMonAPagar;String:C10($vr_monto))
				APPEND TO ARRAY:C911(at_AviMonIVA;String:C10(Sum:C1([ACT_Cargos:173]Monto_IVA:20)))
				APPEND TO ARRAY:C911(at_AviSegFechaPago;$fechaEmision)
				APPEND TO ARRAY:C911(at_FamCodInterno;[Familia:78]Codigo_interno:14)
				APPEND TO ARRAY:C911(at_FamNombre;[Familia:78]Nombre_de_la_familia:3)
				APPEND TO ARRAY:C911(at_PerEmail;[Personas:7]eMail:34)
				APPEND TO ARRAY:C911(at_PerTelefono;Replace string:C233(Replace string:C233([Personas:7]Telefono_domicilio:19;"\r";"");"\r";""))
				APPEND TO ARRAY:C911(at_CarDetalle;Uppercase:C13("pension "+DT_GetMonthNameFromDate ([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)))
				
				vtotalPAC:=String:C10(Num:C11(vtotalPAC)+$vr_monto)
				vnumTransPAC:=String:C10(Num:C11(vnumTransPAC)+1)
			End if 
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$vl_total;"Exportando datos...")
	End for 
	
	For ($i;1;Size of array:C274(at_AviNumero))
		$linea:=""
		$linea:=$linea+at_AviNumero{$i}+$separador
		$linea:=$linea+at_FamCodInterno{$i}+$separador
		$linea:=$linea+at_AviMonAPagar{$i}+$separador
		$linea:=$linea+at_AviMonIVA{$i}+$separador
		$linea:=$linea+at_CarDetalle{$i}+$separador
		$linea:=$linea+at_AviSegFechaPago{$i}+$separador
		$linea:=$linea+at_PerEmail{$i}+$separador
		$linea:=$linea+$separador
		$linea:=$linea+at_FamNombre{$i}+$separador
		$linea:=$linea+at_FamNombre{$i}+$separador
		$linea:=$linea+at_PerTelefono{$i}+$separador
		$linea:=$linea+$separador
		$linea:=$linea+$separador+"\r"
		IO_SendPacket ($ref;$linea)
	End for 
	AT_Initialize (->at_AviNumero;->at_FamCodInterno;->at_AviMonAPagar;->at_AviMonIVA;->at_CarDetalle;->at_AviSegFechaPago;->at_PerEmail;->at_FamNombre;->at_PerTelefono)
	vtotalPAC:=String:C10(Num:C11(vtotalPAC);"|Despliegue_ACT")
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($ref)
Else 
	vb_detenerImp:=True:C214
End if 

