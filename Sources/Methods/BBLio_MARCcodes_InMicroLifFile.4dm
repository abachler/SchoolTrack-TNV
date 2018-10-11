//%attributes = {}
  //BBLio_MARCcodes_InMicroLifFile

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : Procédure 545
	  //Autor: Alberto Bachler
	  //Creada el 10/6/96 a 12:05 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283(nbrec)
C_POINTER:C301($1)
$Created:=0
$procesed:=0
$docRef:=Open document:C264("";"TEXT";Read mode:K24:5)
$size:=Get document size:C479(document)
<>dbles:=""
$copies:=0
_O_ARRAY STRING:C218(3;$aHeaders;0)
_O_ARRAY STRING:C218(3;asBBL_MarcField;0)
_O_ARRAY STRING:C218(4;asBBL_MarcFieldSubField;0)
_O_ARRAY STRING:C218(1;asBBL_MarcSubField;0)
$recordDelim:=Character code:C91("`")
If (ok=1)
	RECEIVE PACKET:C104($docRef;vtBBL_CurrentRecord;Char:C90($recordDelim))
	$packetSize:=Length:C16(vtBBL_CurrentRecord)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Detectando encabezados microlif..."))
	  //WDW_Open (300;50;5;720)
	While (vtBBL_CurrentRecord#"")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$packetSize/$size;__ ("Detectando encabezados microlif..."))
		
		ARRAY TEXT:C222($aRecord;0)
		$delim:=Char:C90(94)
		vtBBL_CurrentRecord:=Replace string:C233(Replace string:C233(vtBBL_CurrentRecord;Char:C90(10);"");"\r";"")
		AT_Text2Array (->$aRecord;vtBBL_CurrentRecord;$delim)
		$hdr:=Find in array:C230($aRecord;"LDR@")
		If ($hdr>0)
			DELETE FROM ARRAY:C228($aRecord;$hdr)
		End if 
		For ($i;1;9)
			$ref:=String:C10($i;"000")+"@"
			$hdr:=Find in array:C230($aRecord;$ref)
			If ($hdr>0)
				DELETE FROM ARRAY:C228($aRecord;$hdr)
			End if 
		End for 
		SORT ARRAY:C229($aRecord;>)
		
		For ($i;1;Size of array:C274($aRecord))
			$sMARCField:=Substring:C12($aRecord{$i};1;3)
			$iMarcField:=Num:C11($sMARCField)
			If ($iMARCfield>0)
				$indicadores:=Substring:C12($aRecord{$i};4;2)
				$content:=Substring:C12($aRecord{$i};6)
				ARRAY TEXT:C222($aSubfieldsContents;0)
				AT_Text2Array (->$aSubfieldsContents;$content;"_")
				For ($iSubField;1;Size of array:C274($aSubfieldsContents))
					If ($aSubfieldsContents{$iSubField}#"")
						$subfieldRef:=Substring:C12($aSubfieldsContents{$iSubField};1;1)
						$el:=Find in array:C230(asBBL_MarcFieldSubField;$sMARCField+$subfieldRef)
						If ($el=-1)
							APPEND TO ARRAY:C911(asBBL_MarcField;$sMARCField)
							APPEND TO ARRAY:C911(asBBL_MarcFieldSubField;$sMARCField+$subfieldRef)
							APPEND TO ARRAY:C911(asBBL_MarcSubField;$subfieldRef)
						End if 
					End if 
				End for 
			Else 
				  //trace
			End if 
		End for 
		
		RECEIVE PACKET:C104($docRef;vtBBL_CurrentRecord;Char:C90($recordDelim))
		$packetSize:=$packetSize+Length:C16(vtBBL_CurrentRecord)
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($docRef)
	  //CLOSE WINDOW
End if 

SORT ARRAY:C229(asBBL_MarcFieldSubField;>)
$docRef:=Create document:C266("";"TEXT")
For ($i;1;Size of array:C274(asBBL_MarcFieldSubField))
	SEND PACKET:C103($docRef;asBBL_MarcFieldSubField{$i}+"\r")
End for 
CLOSE DOCUMENT:C267($docRef)




