//%attributes = {}
  // QR_UpdateTemplatesFromFolder()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 12:18:16
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_reconstruirLista)
C_LONGINT:C283($el;$i;$l_modificacion;$l_recNumInforme;$l_segundos)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_nombreDocumento;$t_rutaArchivo;$t_rutaCarpeta;$t_contenidoDocumento;$t_tipoInforme)

ARRAY TEXT:C222($at_ReportFileNames;0)

If (False:C215)
	C_BOOLEAN:C305(QR_UpdateTemplatesFromFolder ;$0)
	C_TEXT:C284(QR_UpdateTemplatesFromFolder ;$1)
	C_LONGINT:C283(QR_UpdateTemplatesFromFolder ;$2)
	C_LONGINT:C283(QR_UpdateTemplatesFromFolder ;$3)
End if 

C_POINTER:C301(vyQR_EndField)
$0:=False:C215
$b_reconstruirLista:=False:C215
$t_rutaCarpeta:=$1
$l_recNumInforme:=$2
$l_modificacion:=$3

If ($l_recNumInforme>=0)
	READ WRITE:C146([xShell_Reports:54])
	GOTO RECORD:C242([xShell_Reports:54];$l_recNumInforme)
Else 
	REDUCE SELECTION:C351([xShell_Reports:54];0)
End if 

DOCUMENT LIST:C474($t_rutaCarpeta;$at_ReportFileNames)

If ($l_recNumInforme>=0)
	$el:=Find in array:C230($at_ReportFileNames;[xShell_Reports:54]ReportName:26)
	If ($el=-1)
		$el:=Find in array:C230($at_ReportFileNames;[xShell_Reports:54]ReportName:26+".4LB")
	End if 
	If ($el=-1)
		If (([xShell_Reports:54]Propietary:9=<>lUSR_CurrentUserID) | (<>lUSR_CurrentUserID<0))
			DELETE RECORD:C58([xShell_Reports:54])
			$b_reconstruirLista:=True:C214
		End if 
	Else 
		$t_nombreDocumento:=$at_ReportFileNames{$el}
		$t_rutaArchivo:=$t_rutaCarpeta+$t_nombreDocumento
		$l_segundos:=SYS_GetFileMSecs ($t_rutaArchivo)
		If (([xShell_Reports:54]Propietary:9=<>lUSR_CurrentUserID) | (<>lUSR_CurrentUserID<0))
			$h_refDocumento:=Open document:C264($t_rutaArchivo)
			RECEIVE PACKET:C104($h_refDocumento;$t_contenidoDocumento;32000)
			CLOSE DOCUMENT:C267($h_refDocumento)
			READ WRITE:C146([xShell_Reports:54])
			LOAD RECORD:C52([xShell_Reports:54])
			If (Locked:C147([xShell_Reports:54]))
				Repeat 
					DELAY PROCESS:C323(Current process:C322;15)
					LOAD RECORD:C52([xShell_Reports:54])
				Until (Not:C34(Locked:C147([xShell_Reports:54])))
			End if 
			[xShell_Reports:54]ReportName:26:=Replace string:C233(Replace string:C233($t_nombreDocumento;".4QR";"");".4LB";"")
			[xShell_Reports:54]Texto:5:=$t_contenidoDocumento
			[xShell_Reports:54]mSeconds:6:=$l_segundos
			[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
			SAVE RECORD:C53([xShell_Reports:54])
			UNLOAD RECORD:C212([xShell_Reports:54])
			READ ONLY:C145([xShell_Reports:54])
			$b_reconstruirLista:=True:C214
			DELETE DOCUMENT:C159($t_rutaArchivo)
			DELETE FROM ARRAY:C228($at_ReportFileNames;$el;1)
		End if 
	End if 
	
Else 
	
	
End if 


For ($i;1;Size of array:C274($at_ReportFileNames))
	$t_rutaArchivo:=$t_rutaCarpeta+$at_ReportFileNames{$i}
	If ($t_rutaArchivo="@.4LB")
		$t_nombreDocumento:=Replace string:C233($at_ReportFileNames{$i};".4LB";"")
		$t_tipoInforme:="4DET"
		$l_segundos:=SYS_GetFileMSecs ($t_rutaArchivo)
		$h_refDocumento:=Open document:C264($t_rutaArchivo)
		RECEIVE PACKET:C104($h_refDocumento;$t_contenidoDocumento;32000)
		CLOSE DOCUMENT:C267($h_refDocumento)
		READ WRITE:C146([xShell_Reports:54])
		CREATE RECORD:C68([xShell_Reports:54])
		[xShell_Reports:54]ReportName:26:=Replace string:C233(Replace string:C233(SYS_cleanCrossPlatformFileName ($t_rutaArchivo);".4QR";"");".4LB";"")
		[xShell_Reports:54]ReportType:2:=$t_tipoInforme
		[xShell_Reports:54]MainTable:3:=Table:C252(vyQR_TablePointer)
		If (vlQR_manyTableNumber>0)
			[xShell_Reports:54]RelatedTable:14:=vlQR_manyTableNumber
			If (Not:C34(Is nil pointer:C315(vyQR_EndField)))
				[xShell_Reports:54]RelatedField:15:=Field:C253(vyQR_EndField)
			End if 
			If (Not:C34(Is nil pointer:C315(vyQR_EndField)))
				[xShell_Reports:54]SourceField:13:=Field:C253(vyQR_StartField)
			End if 
		End if 
		[xShell_Reports:54]Texto:5:=$t_contenidoDocumento
		[xShell_Reports:54]mSeconds:6:=$l_segundos
		[xShell_Reports:54]Propietary:9:=<>lUSR_CurrentUserID
		If (<>lUSR_CurrentUserID<0)
			[xShell_Reports:54]Public:8:=True:C214
		End if 
		[xShell_Reports:54]Creacion_Usuario:34:=<>tUSR_CurrentUser
		[xShell_Reports:54]Modificacion_Usuario:39:=<>tUSR_CurrentUser
		SAVE RECORD:C53([xShell_Reports:54])
		vlQR_ReportRecNum:=Record number:C243([xShell_Reports:54])
		KRL_ReloadAsReadOnly (->[xShell_Reports:54])
		DELETE DOCUMENT:C159($t_rutaArchivo)
		$b_reconstruirLista:=True:C214
	End if 
End for 

$0:=$b_reconstruirLista