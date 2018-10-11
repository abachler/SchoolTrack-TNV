//%attributes = {}
  //ACTabc_ExportPATManquehue

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$folderPath;$filePath;$line)
C_LONGINT:C283($i;$Apdo;$linea;$j)
C_TIME:C306($ref)
C_BOOLEAN:C305($cond)
C_POINTER:C301(vQR_Pointer)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Boletas:181])

If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
	vQR_Pointer:=->[ACT_Cargos:173]Saldo:23
Else 
	vQR_Pointer:=->[ACT_Cargos:173]Monto_Neto:5
End if 

vQR_Real2:=0
vfechaPAT:=String:C10(Current date:C33(*);7)

_O_ARRAY STRING:C218(2;aIndicador;0)
ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aNumTarjeta;0)
_O_ARRAY STRING:C218(5;aVencTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
_O_ARRAY STRING:C218(80;aCodPAT;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY LONGINT:C221(aidsPersonas;0)
ARRAY LONGINT:C221(aidsAvisos;0)
ARRAY TEXT:C222(aTelefono;0)
ARRAY TEXT:C222(aCodInterno;0)
ARRAY TEXT:C222(aBoleta;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aidsAvisos;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información para archivo PAT...")
For ($i;1;Size of array:C274(aidsAvisos))
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aidsAvisos{$i})
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	CREATE SET:C116([ACT_Cargos:173];"setCargos1")
	ARRAY LONGINT:C221(aQR_Longint1;0)
	AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->aQR_Longint1)
	
	For ($j;1;Size of array:C274(aQR_Longint1))
		USE SET:C118("setCargos1")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=aQR_Longint1{$j})
		$Apdo:=Find in field:C653([ACT_CuentasCorrientes:175]ID:1;aQR_Longint1{$j})
		If ($Apdo#-1)
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$Apdo)
		Else 
			REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
		End if 
		$linea:=Find in array:C230(aidsPersonas;[ACT_CuentasCorrientes:175]ID:1)
		
		ARRAY LONGINT:C221(aQR_Longint2;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2;"")
		vQR_Real1:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->aQR_Longint2;vQR_Pointer;vd_FechaUF))
		vQR_Real2:=vQR_Real2+vQR_Real1
		
		If (vQR_Real1>0)
			If ($linea=-1)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
				KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
				FIRST RECORD:C50([ACT_Boletas:181])
				
				AT_Insert (1;1;->aIndicador;->aMonto;->aNumTarjeta;->aNombre;->aRUT;->aCodPAT;->aVencTarjeta;->aidsPersonas)
				INSERT IN ARRAY:C227(aTelefono;1;1)
				INSERT IN ARRAY:C227(aCodInterno;1;1)
				INSERT IN ARRAY:C227(aBoleta;1;1)
				aidsPersonas{1}:=[ACT_CuentasCorrientes:175]ID:1
				aIndicador{1}:="V"
				aMonto{1}:=vQR_Real1
				aNumTarjeta{1}:=ACTpp_CRYPTTC ("xxACT_GetDecryptTC";->[Personas:7]ACT_Numero_TC:54)
				$cond:=(([Personas:7]ACT_MesVenc_TC:57#"") & ([Personas:7]ACT_AñoVenc_TC:58#""))
				aVencTarjeta{1}:=[Personas:7]ACT_MesVenc_TC:57+ST_Boolean2Str ($cond;"/")+Substring:C12([Personas:7]ACT_AñoVenc_TC:58;3)
				aNombre{1}:=[Personas:7]ACT_Titular_TC:55
				aRUT{1}:=ST_Uppercase ([Personas:7]ACT_RUTTitular_TC:56)
				aCodPAT{1}:=[Personas:7]ACT_CodMandatoPAT:63
				aTelefono{1}:=Replace string:C233(ST_CleanString ([Personas:7]Telefono_domicilio:19);"\r";"")
				aCodInterno{1}:=[Alumnos:2]Codigo_interno:6
				aBoleta{1}:=String:C10([ACT_Boletas:181]Numero:11)
			Else 
				aMonto{$linea}:=aMonto{$linea}+vQR_Real1
			End if 
		End if 
	End for 
	CLEAR SET:C117("setCargos1")
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aidsAvisos);"Recopilando información para archivo PAT...")
End for 
vtotalPAT:=String:C10(vQR_Real2;"|Despliegue_ACT_Pagos")

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAT";$fileName)
If ($ref#?00:00:00?)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo PAT...")
	For ($i;1;Size of array:C274(aIndicador))
		$line:=aIndicador{$i}+";"+String:C10(aMonto{$i})+";"+aNumTarjeta{$i}+";"+aVencTarjeta{$i}+";"+";"+aNombre{$i}+";"+";"+aTelefono{$i}+";"+aCodInterno{$i}+";"+aRUT{$i}+";"+aBoleta{$i}+"\r"
		IO_SendPacket ($ref;$line)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aIndicador);"Generando archivo PAT...")
	End for 
	CLOSE DOCUMENT:C267($ref)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	vnumTransPAT:=String:C10(Size of array:C274(aIndicador))
	AT_Initialize (->aIndicador;->aMonto;->aNumTarjeta;->aNombre;->aRUT;->aCodPAT;->aVencTarjeta;->aidsPersonas;->aidsAvisos)
	ARRAY TEXT:C222(aTelefono;0)
	ARRAY TEXT:C222(aCodInterno;0)
	ARRAY TEXT:C222(aBoleta;0)
Else 
	vb_detenerImp:=True:C214
End if 