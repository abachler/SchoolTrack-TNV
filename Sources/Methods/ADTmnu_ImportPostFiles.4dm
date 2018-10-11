//%attributes = {}
  //ADTmnu_ImportPostFiles

C_BOOLEAN:C305($vbLocked;$vbInvisible)
C_TIME:C306($vhCreatedAt;$vhModifiedAt)
C_DATE:C307($vdCreatedOn;$vdModifiedOn)
C_BLOB:C604($blob)
C_TEXT:C284($text)

$allowed:=(Num:C11(PREF_fGet (0;"ADT Permite postulaciones archivos";"0"))=1)

If ($allowed)
	vt_g1:=""
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ADTmnu_ImportPost";0;4)
	DIALOG:C40([xxSTR_Constants:1];"ADTmnu_ImportPost")
	CLOSE WINDOW:C154
	If (ok=1)
		If (vt_g1#"")
			$path:=vt_g1
			ARRAY TEXT:C222($aFiles;0)
			DOCUMENT LIST:C474($path;$aFiles)
			If (Size of array:C274($aFiles)>0)
				For ($i;Size of array:C274($aFiles);1;-1)
					$tempWords:=ST_CountWords ($aFiles{$i};0;".")
					$extension:=ST_GetWord ($aFiles{$i};$tempWords;".")
					If ($extension="adt")
						GET DOCUMENT PROPERTIES:C477($path+$aFiles{$i};$vbLocked;$vbInvisible;$vdCreatedOn;$vhCreatedAt;$vdModifiedOn;$vhModifiedAt)
						If ($vbInvisible)
							DELETE FROM ARRAY:C228($aFiles;$i;1)
						End if 
					Else 
						DELETE FROM ARRAY:C228($aFiles;$i;1)
					End if 
				End for 
			End if 
			If (Size of array:C274($aFiles)>0)
				If (SYS_TestPathName ($path+"Archivos No Procesados")#Is a folder:K24:2)
					SYS_CreatePath ($path+"Archivos No Procesados")
				End if 
				READ ONLY:C145([SNT_Preferences:50])
				ALL RECORDS:C47([SNT_Preferences:50])
				FIRST RECORD:C50([SNT_Preferences:50])
				WDW_OpenFormWindow (->[SNT_Preferences:50];"Console";0;Palette form window:K39:9;__ ("Importación de archivos de postulaciones"))
				FORM SET INPUT:C55([SNT_Preferences:50];"Console")
				vt_msg:="Proceso de archivos iniciado el "+String:C10(Current date:C33(*);Internal date short:K1:7)+" a las "+String:C10(Current time:C178(*);HH MM SS:K7:1)+"\r"
				DISPLAY RECORD:C105([SNT_Preferences:50])
				For ($i;1;Size of array:C274($aFiles))
					SET BLOB SIZE:C606($blob;0)
					$text:=""
					DOCUMENT TO BLOB:C525($path+$aFiles{$i};$blob)
					  //20120302 RCH Los caracteres se importaban mal
					  //$text:=BLOB to text($blob;Mac text without length)
					  //If (r2=1)
					  //$text:=Convert to text($blob;"windows-1252")
					  //Else 
					  //$text:=Convert to text($blob;"MacRoman")
					  //End if 
					  //20141113 ASM Los caracteres se importaban mal cuando el archivo venia en UTF-8
					Case of 
						: (r1=1)
							$text:=Convert to text:C1012($blob;"windows-1252")
						: (r2=1)
							$text:=Convert to text:C1012($blob;"MacRoman")
						: (r3=1)
							$text:=Convert to text:C1012($blob;"UTF-8")
					End case 
					
					$del1:=Position:C15("\r"+Char:C90(10);$text)
					$del2:=Position:C15(Char:C90(10);$text)
					Case of 
						: (($del1#0) & ($del1<$del2))
							$delimiter:="\r"+Char:C90(10)
							$text:=Replace string:C233($text;$delimiter;"\r")
						: ($del2#0)
							$delimiter:=Char:C90(10)
							$text:=Replace string:C233($text;$delimiter;"\r")
					End case 
					
					If (r2=1)
						$text:=_O_Win to Mac:C464($text)
					End if 
					$err:=""
					vt_msg:=vt_msg+"Proceso del archivo "+$aFiles{$i}+" iniciado"+"\r"
					DISPLAY RECORD:C105([SNT_Preferences:50])
					$err:=ADTweb_ProcessPostulations ($text)
					If ($err="")
						vt_msg:=vt_msg+"Proceso del archivo "+$aFiles{$i}+" terminado con éxito"+"\r"
					Else 
						vt_msg:=vt_msg+$err+"\r"
					End if 
					If ($err="")
						DELETE DOCUMENT:C159($path+$aFiles{$i})
					Else 
						MOVE DOCUMENT:C540($path+$aFiles{$i};$path+"Archivos No Procesados"+Folder separator:K24:12+$aFiles{$i})
					End if 
					DISPLAY RECORD:C105([SNT_Preferences:50])
				End for 
				vt_msg:=vt_msg+"Proceso de archivos terminado el "+String:C10(Current date:C33(*);Internal date short:K1:7)+" a las "+String:C10(Current time:C178(*);HH MM SS:K7:1)
				DISPLAY RECORD:C105([SNT_Preferences:50])
				IT_1SecDelay (15)
				CLOSE WINDOW:C154
			Else 
				CD_Dlog (0;__ ("No hay archivos importables en el directorio seleccionado."))
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("No está permitida la importación de archivos de postulación. Puede alterar este comportamiento desde Archivo/Configuración/Meta Datos"))
End if 