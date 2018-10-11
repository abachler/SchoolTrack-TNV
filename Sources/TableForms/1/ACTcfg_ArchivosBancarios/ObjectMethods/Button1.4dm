C_TEXT:C284($reg;$resto)
ARRAY TEXT:C222(atACT_RegistrosDoc;0)
C_BOOLEAN:C305($lf;$cr)

$lf:=False:C215
$cr:=False:C215
$ref:=Open document:C264("";Read mode:K24:5)
If ((ok=1) & ($ref#?00:00:00?))
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando datos bancarios..."))
	$continue:=True:C214
	$i:=1
	Case of 
		: (r1=1)
			$cr:=True:C214
			$lf:=False:C215
		: (r2=1)
			$cr:=True:C214
			$lf:=True:C214
		: (r3=1)
			RECEIVE PACKET:C104($ref;$reg;vl_LargoReg+2)
			If ($reg[[Length:C16($reg)]]=Char:C90(10))
				$lf:=True:C214
			Else 
				If ($reg[[Length:C16($reg)]]="\r")
					$cr:=True:C214
				End if 
			End if 
	End case 
	SET DOCUMENT POSITION:C482($ref;0)
	While ($continue)
		RECEIVE PACKET:C104($ref;$reg;vl_LargoReg)
		RECEIVE PACKET:C104($ref;$resto;"\r")
		If ($lf)
			SET DOCUMENT POSITION:C482($ref;Get document position:C481($ref)+1)
		End if 
		If ((ok=1) & (Length:C16($reg)=vl_LargoReg))
			INSERT IN ARRAY:C227(atACT_RegistrosDoc;Size of array:C274(atACT_RegistrosDoc)+1;1)
			atACT_RegistrosDoc{$i}:=$reg
			$continue:=True:C214
		Else 
			$continue:=False:C215
		End if 
		$i:=$i+1
	End while 
	CLOSE DOCUMENT:C267($ref)
	
	ARRAY POINTER:C280(apACT_ArreglosImportacion;0)
	For ($i;1;Size of array:C274(alACT_Campo))
		Case of 
			: (atACT_Tipo{$i}="N")
				INSERT IN ARRAY:C227(apACT_ArreglosImportacion;Size of array:C274(apACT_ArreglosImportacion)+1;1)
				apACT_ArreglosImportacion{$i}:=Bash_Get_Array_By_Type (Is longint:K8:6)
			: (atACT_Tipo{$i}="AN")
				INSERT IN ARRAY:C227(apACT_ArreglosImportacion;Size of array:C274(apACT_ArreglosImportacion)+1;1)
				apACT_ArreglosImportacion{$i}:=Bash_Get_Array_By_Type (Is text:K8:3)
			: (atACT_Tipo{$i}="F")
				INSERT IN ARRAY:C227(apACT_ArreglosImportacion;Size of array:C274(apACT_ArreglosImportacion)+1;1)
				apACT_ArreglosImportacion{$i}:=Bash_Get_Array_By_Type (Is date:K8:7)
			: (atACT_Tipo{$i}="H")
				INSERT IN ARRAY:C227(apACT_ArreglosImportacion;Size of array:C274(apACT_ArreglosImportacion)+1;1)
				apACT_ArreglosImportacion{$i}:=Bash_Get_Array_By_Type (Is time:K8:8)
		End case 
	End for 
	ARRAY LONGINT:C221($alACT_FillerPos;0)
	$w:=1
	$filler:=Find in array:C230(atACT_Descripcion;"Filler")
	While ($filler#-1)
		INSERT IN ARRAY:C227($alACT_FillerPos;Size of array:C274($alACT_FillerPos)+1;1)
		$alACT_FillerPos{$w}:=$filler
		$w:=$w+1
		$filler:=Find in array:C230(atACT_Descripcion;"Filler";$filler+1)
	End while 
	ARRAY LONGINT:C221(CamposRegistro;0)
	$p:=1
	For ($w;$alACT_FillerPos{vl_PreviosReg}+1;$alACT_FillerPos{Size of array:C274($alACT_FillerPos)-vl_PosterioresReg})
		INSERT IN ARRAY:C227(CamposRegistro;Size of array:C274(CamposRegistro)+1;1)
		CamposRegistro{$p}:=$w
		$p:=$p+1
	End for 
	For ($i;vl_PreviosReg+1;Size of array:C274(atACT_RegistrosDoc)-vl_PosterioresReg)
		$register:=atACT_RegistrosDoc{$i}
		ARRAY LONGINT:C221(alACT_ArreglosUsados;0)
		For ($j;1;Size of array:C274(CamposRegistro))
			$PosIni:=alACT_PosIni{CamposRegistro{$j}}
			$PosFinal:=alACT_PosFinal{CamposRegistro{$j}}
			$extract:=Substring:C12($register;$PosIni;$PosFinal-$PosIni+1)
			Case of 
				: (atACT_Tipo{CamposRegistro{$j}}="N")
					INSERT IN ARRAY:C227(apACT_ArreglosImportacion{CamposRegistro{$j}}->;Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)+1;1)
					INSERT IN ARRAY:C227(alACT_ArreglosUsados;Size of array:C274(alACT_ArreglosUsados)+1;1)
					alACT_ArreglosUsados{$j}:=CamposRegistro{$j}
					apACT_ArreglosImportacion{CamposRegistro{$j}}->{Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)}:=Num:C11($extract)
				: (atACT_Tipo{CamposRegistro{$j}}="AN")
					INSERT IN ARRAY:C227(apACT_ArreglosImportacion{CamposRegistro{$j}}->;Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)+1;1)
					INSERT IN ARRAY:C227(alACT_ArreglosUsados;Size of array:C274(alACT_ArreglosUsados)+1;1)
					alACT_ArreglosUsados{$j}:=CamposRegistro{$j}
					apACT_ArreglosImportacion{CamposRegistro{$j}}->{Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)}:=$extract
				: (atACT_Tipo{CamposRegistro{$j}}="F")
					INSERT IN ARRAY:C227(apACT_ArreglosImportacion{CamposRegistro{$j}}->;Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)+1;1)
					INSERT IN ARRAY:C227(alACT_ArreglosUsados;Size of array:C274(alACT_ArreglosUsados)+1;1)
					alACT_ArreglosUsados{$j}:=CamposRegistro{$j}
					apACT_ArreglosImportacion{CamposRegistro{$j}}->{Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)}:=Num:C11($extract)
				: (atACT_Tipo{CamposRegistro{$j}}="H")
					INSERT IN ARRAY:C227(apACT_ArreglosImportacion{CamposRegistro{$j}}->;Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)+1;1)
					INSERT IN ARRAY:C227(alACT_ArreglosUsados;Size of array:C274(alACT_ArreglosUsados)+1;1)
					alACT_ArreglosUsados{$j}:=CamposRegistro{$j}
					apACT_ArreglosImportacion{CamposRegistro{$j}}->{Size of array:C274(apACT_ArreglosImportacion{CamposRegistro{$j}}->)}:=Num:C11($extract)
			End case 
		End for 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/(Size of array:C274(atACT_RegistrosDoc)-vl_PosterioresReg);__ ("Importando datos bancarios..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcfg_PresentaDatos";0;4;__ ("Datos Importados"))
	DIALOG:C40([xxSTR_Constants:1];"ACTcfg_PresentaDatos")
	CLOSE WINDOW:C154
	For ($i;1;Size of array:C274(apACT_ArreglosImportacion))
		Bash_Return_Variable (apACT_ArreglosImportacion{$i})
	End for 
End if 