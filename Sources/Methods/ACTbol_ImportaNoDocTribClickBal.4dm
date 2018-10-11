//%attributes = {}
  //ACTbol_ImportaNoDocTribClickBal

C_BOOLEAN:C305($b_ExistenNoImportados)
C_DATE:C307($d_FechaDocumento)
C_LONGINT:C283($i;$l_agno;$l_Dia;$l_mes;$l_NoDocumento;$l_pos;$l_therm)
C_TIME:C306($h_ref)
C_REAL:C285($r_Importe)
C_TEXT:C284($t_Apoderado;$t_delimiter;$t_FechaDocumento;$t_folder;$t_lineaArchivo;$t_LocDocumento;$t_NoImportados;$t_NomNoImportado)

ARRAY TEXT:C222($at_Documentos;0)
ARRAY TEXT:C222($at_DocumentosImportar;0)
ARRAY TEXT:C222($at_NoImportados;0)

If (SYS_IsWindows )
	USE CHARACTER SET:C205("windows-1252";1)
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";1)
	USE CHARACTER SET:C205("MacRoman";0)
End if 

$t_folder:=xfGetDirName ("Seleccione directorio")
If ($t_folder#"")
	DOCUMENT LIST:C474($t_folder;$at_Documentos)
	While ($l_pos#-1)
		$l_pos:=Find in array:C230($at_Documentos;"@.xls@")
		If ($l_pos#-1)
			DELETE FROM ARRAY:C228($at_Documentos;$l_pos)
		End if 
	End while 
	
	SRtbl_ShowChoiceList (0;"Seleccione archivos para importación";2;->brepositorio;True:C214;->$at_Documentos)
	
	If (Size of array:C274(aLinesSelected)>0)
		
		For ($i;1;Size of array:C274(aLinesSelected))
			APPEND TO ARRAY:C911($at_DocumentosImportar;$at_Documentos{aLinesSelected{$i}})
		End for 
		
		$l_therm:=IT_UThermometer (1;0;"Recopilando informción de Documentos Tributarios...")
		  //creo set con los documentos con numero cero
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=0;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
		CREATE SET:C116([ACT_Boletas:181];"Documentos")
		IT_UThermometer (-2;$l_therm)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Importando números de documentos...")
		For ($i;1;Size of array:C274($at_DocumentosImportar))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_DocumentosImportar))
			
			$t_LocDocumento:=$t_folder+$at_DocumentosImportar{$i}
			$t_delimiter:=ACTabc_DetectDelimiter ($t_LocDocumento)
			$h_ref:=Open document:C264($t_LocDocumento;Read mode:K24:5)
			
			RECEIVE PACKET:C104($h_ref;$t_lineaArchivo;$t_delimiter)
			RECEIVE PACKET:C104($h_ref;$t_lineaArchivo;$t_delimiter)
			
			While ($t_lineaArchivo#"")
				$l_NoDocumento:=Num:C11(ST_GetWord ($t_lineaArchivo;1;"\t"))
				$t_Apoderado:=ST_GetWord ($t_lineaArchivo;4;"\t")
				$t_FechaDocumento:=ST_GetWord ($t_lineaArchivo;3;"\t")
				$r_Importe:=Num:C11(ST_GetWord ($t_lineaArchivo;6;"\t"))
				
				$l_agno:=Num:C11(Substring:C12($t_FechaDocumento;1;4))
				$l_mes:=Num:C11(Substring:C12($t_FechaDocumento;6;2))
				$l_Dia:=Num:C11(Substring:C12($t_FechaDocumento;9;2))
				$d_FechaDocumento:=DT_GetDateFromDayMonthYear ($l_Dia;$l_mes;$l_agno)
				
				  //busco documentos y apoderados
				QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=$t_Apoderado)
				If (Records in selection:C76([Personas:7])>0)
					USE SET:C118("Documentos")
					QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3=$d_FechaDocumento;*)
					QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Apoderado:14=[Personas:7]No:1;*)
					QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Monto_Total:6=$r_Importe)
					
					If (Records in selection:C76([ACT_Boletas:181])=0)
						APPEND TO ARRAY:C911($at_NoImportados;$t_lineaArchivo+"\t"+"Documento no encontrado. problemas con el importe o la fecha del documento.")
					Else 
						KRL_ReloadInReadWriteMode (->[ACT_Boletas:181])
						[ACT_Boletas:181]Numero:11:=$l_NoDocumento
						SAVE RECORD:C53([ACT_Boletas:181])
						KRL_ReloadAsReadOnly (->[ACT_Boletas:181])
					End if 
				Else 
					APPEND TO ARRAY:C911($at_NoImportados;$t_lineaArchivo+"\t"+"Apoderado no encontrado.")
				End if 
				RECEIVE PACKET:C104($h_ref;$t_lineaArchivo;$t_delimiter)
			End while 
			
			CLOSE DOCUMENT:C267($h_ref)
			
			  //Creo archivo con los documentos no importados
			If (Size of array:C274($at_DocumentosImportar)>0)
				
				$t_NomNoImportado:="NoImportados_"+$at_DocumentosImportar{$i}
				$t_NoImportados:=$t_folder+$t_NomNoImportado
				
				If (SYS_TestPathName ($t_NoImportados)=1)
					DELETE DOCUMENT:C159($t_NoImportados)
				End if 
				
				$h_ref:=Create document:C266($t_NoImportados;"TEXT")
				IO_SendPacket ($h_ref;AT_array2text (->$at_NoImportados;"\r")+"\r")
				$b_ExistenNoImportados:=True:C214
				CLOSE DOCUMENT:C267($h_ref)
			End if 
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		If ($b_ExistenNoImportados)
			ACTcd_DlogWithShowOnDisk ($t_NoImportados;0;"Existen documentos que no se pudieron importar"+"\r\r"+" los encontrará en : "+"\r"+$t_NoImportados+"\r\r"+"Le recomendamos abrirla con Microsoft Excel.")
		End if 
	Else 
		CD_Dlog (0;__ ("Debe seleccionar un documento para importar."))
	End if 
Else 
	CD_Dlog (0;__ ("Debe seleccionar una carpeta."))
End if 

USE CHARACTER SET:C205(*;0)
USE CHARACTER SET:C205(*;1)
