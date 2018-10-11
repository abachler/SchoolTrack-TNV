//%attributes = {}
  //ACTabc_ExportCUPSBenito

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath;$fecha;$vt_fVencimiento)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283(vl_idUt;$i)
C_REAL:C285($vr_montoAviso)
C_DATE:C307($vd_vencimientoAviso)
ARRAY LONGINT:C221(al_idCentroPadres;0)
  //APPEND TO ARRAY(al_idCentroPadres;27)
  //APPEND TO ARRAY(al_idCentroPadres;16)
  //2009
APPEND TO ARRAY:C911(al_idCentroPadres;45)

ARRAY LONGINT:C221(al_idItems;0)
ARRAY LONGINT:C221(al_idItemsMenosCP;0)
ARRAY LONGINT:C221(al_idItemCP;0)
ARRAY LONGINT:C221(al_rnAvisos;0)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Cargos:173])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=String:C10(Sum:C1($FieldPtr->);"|Despliegue_ACT")

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)

vl_idUt:=IT_UThermometer (1;0;"Exportando archivo cuponera. Un momento por favor...")
ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
vnumTransCUP:=String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")

USE SET:C118("AvisosTodos")
KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
FIRST RECORD:C50([ACT_Cargos:173])
While (Not:C34(End selection:C36([ACT_Cargos:173])))
	If (Find in array:C230(al_idCentroPadres;[ACT_Cargos:173]Ref_Item:16)=-1)
		APPEND TO ARRAY:C911(al_idItemsMenosCP;[ACT_Cargos:173]ID:1)
	Else 
		APPEND TO ARRAY:C911(al_idItemCP;[ACT_Cargos:173]ID:1)
	End if 
	NEXT RECORD:C51([ACT_Cargos:173])
End while 
REDUCE SELECTION:C351([ACT_Cargos:173];0)

If ((Size of array:C274(al_idItemCP)>0) & (Size of array:C274(al_idItemsMenosCP)>0))
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionCta")
			DIFFERENCE:C122("AvisosTodos";"selectionCta";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
			
			QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
			
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosDeApdo")
			COPY ARRAY:C226(al_idItemsMenosCP;al_idItems)
			For ($i;3;9)
				ARRAY LONGINT:C221(al_rnAvisos;0)
				USE SET:C118("avisosDeApdo")
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$i)
				$vr_montoAviso:=0
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					FIRST RECORD:C50([ACT_Cargos:173])
					While (Not:C34(End selection:C36([ACT_Cargos:173])))
						If (Find in array:C230(al_idItems;[ACT_Cargos:173]ID:1)#-1)
							Case of 
								: (Field:C253($FieldPtr)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
									$vr_montoAviso:=$vr_montoAviso+[ACT_Cargos:173]Monto_Neto:5
								: (Field:C253($FieldPtr)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
									$vr_montoAviso:=$vr_montoAviso+Abs:C99([ACT_Cargos:173]Saldo:23)
							End case 
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							If (Find in array:C230(al_rnAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))=-1)
								APPEND TO ARRAY:C911(al_rnAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))
							End if 
						End if 
						NEXT RECORD:C51([ACT_Cargos:173])
					End while 
					CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];al_rnAvisos)
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6;>)
					$fecha:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
					$vt_fVencimiento:="00"
					$vd_vencimientoAviso:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
					Case of 
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (5;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="00"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (10;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="01"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (15;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="02"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (20;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="03"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (25;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="04"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (30;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="05"
						Else   //30
							$vt_fVencimiento:="06"
					End case 
					  //$text:=ST_RigthChars (("0"*6)+String([ACT_Avisos_de_Cobranza]ID_Aviso);6)+ST_LeftChars (ST_Uppercase ([Personas]Apellidos_y_nombres)+(" "*40);40)+ST_RigthChars (("0"*8)+Substring([Personas]RUT;1;Length([Personas]RUT)-1);8)+ST_RigthChars ("0"+Substring(ST_Uppercase ([Personas]RUT);Length([Personas]RUT)-1);1)+$vt_fVencimiento+ST_RigthChars ("00"+String($i-2);2)+"07"+ST_RigthChars (("0"*10)+String($vr_montoAviso);10)+ST_LeftChars (ST_Uppercase ([Personas]ACT_DireccionEC)+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Alumnos]Curso)+(" "*6);6)+ST_LeftChars (ST_Uppercase ([Familia]Nombre_de_la_familia)+(" "*40);40)+"\r"
					$text:=ST_RigthChars (("0"*6)+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1);6)+ST_LeftChars (ST_Uppercase ([Personas:7]Apellidos_y_nombres:30)+(" "*41);41)+ST_RigthChars (("0"*8)+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);8)+ST_RigthChars ("0"+Substring:C12(ST_Uppercase ([Personas:7]RUT:6);Length:C16([Personas:7]RUT:6)-1);1)+" "+$vt_fVencimiento+" "+ST_RigthChars ("00"+String:C10($i-2);2)+" "+"01"+" "+ST_RigthChars (("0"*10)+String:C10($vr_montoAviso);10)+" "+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_DireccionEC:67)+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Alumnos:2]curso:20)+(" "*6);6)+" "+ST_LeftChars (ST_Uppercase ([Familia:78]Nombre_de_la_familia:3)+(" "*40);40)+"\r"
					IO_SendPacket ($ref;$text)
				End if 
			End for 
			
			ARRAY LONGINT:C221(al_rnAvisos;0)
			COPY ARRAY:C226(al_idItemCP;al_idItems)
			For ($i;1;3)
				ARRAY LONGINT:C221(al_rnAvisos;0)
				USE SET:C118("avisosDeApdo")
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=($i*2)+2)
				$vr_montoAviso:=0
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					FIRST RECORD:C50([ACT_Cargos:173])
					While (Not:C34(End selection:C36([ACT_Cargos:173])))
						If (Find in array:C230(al_idItems;[ACT_Cargos:173]ID:1)#-1)
							Case of 
								: (Field:C253($FieldPtr)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
									$vr_montoAviso:=$vr_montoAviso+[ACT_Cargos:173]Monto_Neto:5
								: (Field:C253($FieldPtr)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
									$vr_montoAviso:=$vr_montoAviso+Abs:C99([ACT_Cargos:173]Saldo:23)
							End case 
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							If (Find in array:C230(al_rnAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))=-1)
								APPEND TO ARRAY:C911(al_rnAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))
							End if 
						End if 
						NEXT RECORD:C51([ACT_Cargos:173])
					End while 
					CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];al_rnAvisos)
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6;>)
					$fecha:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
					$vt_fVencimiento:="00"
					$vd_vencimientoAviso:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
					Case of 
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (5;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="00"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (10;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="01"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (15;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="02"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (20;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="03"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (25;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="04"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (30;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="05"
						Else   //30
							$vt_fVencimiento:="06"
					End case 
					  //$text:=ST_RigthChars (("0"*6)+String([ACT_Avisos_de_Cobranza]ID_Aviso);6)+ST_LeftChars (ST_Uppercase ([Personas]Apellidos_y_nombres)+(" "*40);40)+ST_RigthChars (("0"*8)+Substring([Personas]RUT;1;Length([Personas]RUT)-1);8)+ST_RigthChars ("0"+Substring(ST_Uppercase ([Personas]RUT);Length([Personas]RUT)-1);1)+$vt_fVencimiento+"01"+"01"+ST_RigthChars (("0"*10)+String($vr_montoAviso);10)+ST_LeftChars (ST_Uppercase (ST_Uppercase ([Personas]ACT_DireccionEC))+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Alumnos]Curso)+(" "*6);6)+ST_LeftChars (ST_Uppercase ([Familia]Nombre_de_la_familia)+(" "*40);40)+"\r"
					$text:=ST_RigthChars (("0"*6)+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1);6)+ST_LeftChars (ST_Uppercase ([Personas:7]Apellidos_y_nombres:30)+(" "*41);41)+ST_RigthChars (("0"*8)+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);8)+ST_RigthChars ("0"+Substring:C12(ST_Uppercase ([Personas:7]RUT:6);Length:C16([Personas:7]RUT:6)-1);1)+" "+$vt_fVencimiento+" "+"01"+" "+"01"+" "+ST_RigthChars (("0"*10)+String:C10($vr_montoAviso);10)+" "+ST_LeftChars (ST_Uppercase (ST_Uppercase ([Personas:7]ACT_DireccionEC:67))+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Alumnos:2]curso:20)+(" "*6);6)+" "+ST_LeftChars (ST_Uppercase ([Familia:78]Nombre_de_la_familia:3)+(" "*40);40)+"\r"
					IO_SendPacket ($ref;$text)
				End if 
			End for 
			
			ARRAY LONGINT:C221(al_rnAvisos;0)
			COPY ARRAY:C226(al_idItemsMenosCP;al_idItems)
			For ($i;10;12)
				ARRAY LONGINT:C221(al_rnAvisos;0)
				USE SET:C118("avisosDeApdo")
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6=$i)
				$vr_montoAviso:=0
				If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					FIRST RECORD:C50([ACT_Cargos:173])
					While (Not:C34(End selection:C36([ACT_Cargos:173])))
						If (Find in array:C230(al_idItems;[ACT_Cargos:173]ID:1)#-1)
							Case of 
								: (Field:C253($FieldPtr)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
									$vr_montoAviso:=$vr_montoAviso+[ACT_Cargos:173]Monto_Neto:5
								: (Field:C253($FieldPtr)=Field:C253(->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
									$vr_montoAviso:=$vr_montoAviso+Abs:C99([ACT_Cargos:173]Saldo:23)
							End case 
							QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
							If (Find in array:C230(al_rnAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))=-1)
								APPEND TO ARRAY:C911(al_rnAvisos;Record number:C243([ACT_Avisos_de_Cobranza:124]))
							End if 
						End if 
						NEXT RECORD:C51([ACT_Cargos:173])
					End while 
					CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];al_rnAvisos)
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Mes:6;>)
					$fecha:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
					$vt_fVencimiento:="00"
					$vd_vencimientoAviso:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
					Case of 
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (5;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="00"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (10;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="01"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (15;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="02"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (20;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="03"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (25;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="04"
						: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (30;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
							$vt_fVencimiento:="05"
						Else   //30
							$vt_fVencimiento:="06"
					End case 
					  //$text:=ST_RigthChars (("0"*6)+String([ACT_Avisos_de_Cobranza]ID_Aviso);6)+ST_LeftChars (ST_Uppercase ([Personas]Apellidos_y_nombres)+(" "*40);40)+ST_RigthChars (("0"*8)+Substring([Personas]RUT;1;Length([Personas]RUT)-1);8)+ST_RigthChars ("0"+Substring(ST_Uppercase ([Personas]RUT);Length([Personas]RUT)-1);1)+$vt_fVencimiento+ST_RigthChars ("00"+String($i-9);2)+"03"+ST_RigthChars (("0"*10)+String($vr_montoAviso);10)+ST_LeftChars (ST_Uppercase ([Personas]ACT_DireccionEC)+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Alumnos]Curso)+(" "*6);6)+ST_LeftChars (ST_Uppercase ([Familia]Nombre_de_la_familia)+(" "*40);40)+"\r"
					$text:=ST_RigthChars (("0"*6)+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1);6)+ST_LeftChars (ST_Uppercase ([Personas:7]Apellidos_y_nombres:30)+(" "*41);41)+ST_RigthChars (("0"*8)+Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);8)+ST_RigthChars ("0"+Substring:C12(ST_Uppercase ([Personas:7]RUT:6);Length:C16([Personas:7]RUT:6)-1);1)+" "+$vt_fVencimiento+" "+ST_RigthChars ("00"+String:C10($i-9);2)+" "+"01"+" "+ST_RigthChars (("0"*10)+String:C10($vr_montoAviso);10)+" "+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_DireccionEC:67)+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Alumnos:2]curso:20)+(" "*6);6)+" "+ST_LeftChars (ST_Uppercase ([Familia:78]Nombre_de_la_familia:3)+(" "*40);40)+"\r"
					IO_SendPacket ($ref;$text)
				End if 
			End for 
			CLEAR SET:C117("avisosDeApdo")
			CLEAR SET:C117("selectionCta")
			USE SET:C118("AvisosTodos")
		End if 
		USE SET:C118("AvisosTodos")
	End while 
	CLOSE DOCUMENT:C267($ref)
	
	CLEAR SET:C117("AvisosTodos")
Else 
	vb_detenerImp:=True:C214
End if 
ARRAY LONGINT:C221(al_idItems;0)
ARRAY LONGINT:C221(al_idItemsMenosCP;0)
ARRAY LONGINT:C221(al_idItemCP;0)
ARRAY LONGINT:C221(al_rnAvisos;0)
ARRAY LONGINT:C221(al_idCentroPadres;0)
IT_UThermometer (-2;vl_idUt)