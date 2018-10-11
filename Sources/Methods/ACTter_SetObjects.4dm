//%attributes = {}
  //ACTter_SetObjects

$vb_continuar:=True:C214
If (Old:C35([ACT_Terceros:138]Es_empresa:2)#([ACT_Terceros:138]Es_empresa:2))
	$vb_consultar:=False:C215
	If (Old:C35([ACT_Terceros:138]Es_empresa:2))
		If (([ACT_Terceros:138]Razon_Social:3#"") | ([ACT_Terceros:138]Giro:8#""))
			$vb_consultar:=True:C214
		End if 
	Else 
		If (([ACT_Terceros:138]Apellido_Paterno:16#"") | ([ACT_Terceros:138]Apellido_Materno:17#"") | ([ACT_Terceros:138]Nombres:18#"") | ([ACT_Terceros:138]Sexo:19#"") | ([ACT_Terceros:138]Fecha_de_Nacimiento:28#!00-00-00!))
			$vb_consultar:=True:C214
		End if 
	End if 
	If ($vb_consultar)
		$resp:=CD_Dlog (0;__ ("Al cambiar el tipo de tercero algunos datos ingresados se perderán.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		If ($resp=2)
			$vb_continuar:=False:C215
			[ACT_Terceros:138]Es_empresa:2:=Old:C35([ACT_Terceros:138]Es_empresa:2)
		End if 
	End if 
End if 

If ($vb_continuar)
	$page:=Selected list items:C379(hlTab_ACT_Terceros)
	AL_SetScroll (xAL_ACT_Terc_UF_P;0;0)
	  //AL_SetScroll (xAL_ACT_Terc_UF_E;0;0)
	
	If ($page=1)
		C_LONGINT:C283($leftOriginal;$topOriginal;$moveLeft;$moveTop;$left;$top;$right;$bottom)
		C_TEXT:C284($objectNames)
		
		$leftOriginal:=24
		OBJECT SET VISIBLE:C603(*;"Empresa@";False:C215)
		OBJECT SET VISIBLE:C603(*;"Persona@";False:C215)
		If ([ACT_Terceros:138]Es_empresa:2)
			$objectNames:="Empresa"
			$topOriginal:=651
		Else 
			$objectNames:="Persona"
			$topOriginal:=771
		End if 
		If (($leftOriginal#-1) & ($topOriginal#-1))
			$moveLeft:=24-$leftOriginal
			$moveTop:=111-$topOriginal
			OBJECT GET COORDINATES:C663(*;$objectNames;$left;$top;$right;$bottom)
			If (($left=$leftOriginal) & ($top=$topOriginal))
				OBJECT MOVE:C664(*;$objectNames+"@";$moveLeft;$moveTop)
			End if 
		End if 
		OBJECT SET VISIBLE:C603(*;$objectNames+"@";True:C214)
		
	End if 
	
	If ([ACT_Terceros:138]Es_empresa:2)
		  //$ptr_alpAreaSeleccionada:=->xAL_ACT_Terc_UF_E
		$ptr_alpAreaSeleccionada:=->xAL_ACT_Terc_UF_P
		[ACT_Terceros:138]Apellido_Paterno:16:=""
		[ACT_Terceros:138]Apellido_Materno:17:=""
		[ACT_Terceros:138]Nombres:18:=""
		[ACT_Terceros:138]Sexo:19:=""
		[ACT_Terceros:138]Nacionalidad:27:=""
		[ACT_Terceros:138]Fecha_de_Nacimiento:28:=!00-00-00!
		ARRAY INTEGER:C220($ai_Lines;0)
		$err:=AL_GetSelect (xAL_ACT_Terc_Cargas;$ai_Lines)
		IT_SetButtonState ((Size of array:C274($ai_Lines)>0);->bDeleteLineC)
		$err:=AL_GetSelect (xAL_ACT_Terc_Items;$ai_Lines)
		IT_SetButtonState ((Size of array:C274($ai_Lines)>0);->bDeleteLineI)
		IT_SetButtonState (True:C214;->bInsertLine;->bInsertLineI)
		
		OBJECT SET VISIBLE:C603(*;"Pactado@";True:C214)
		
		Case of 
			: ($page=3)
				$page:=Selected list items:C379(hlTab_ACT_TercerosGen)
				AL_SetScroll (xAL_ACT_Terc_Cargas;0;0)
				AL_SetScroll (xAL_ACT_Terc_Items;0;0)
				AL_SetScroll (xALP_ACT_Terc_CtasXItems;0;0)
				Case of 
					: ($page=1)
						OBJECT SET VISIBLE:C603(*;"Pactado_1@";True:C214)
						OBJECT SET VISIBLE:C603(*;"Pactado_2@";False:C215)
						OBJECT SET VISIBLE:C603(*;"Pactado_3@";False:C215)
					: ($page=2)
						OBJECT SET VISIBLE:C603(*;"Pactado_1@";False:C215)
						OBJECT SET VISIBLE:C603(*;"Pactado_2@";True:C214)
						OBJECT SET VISIBLE:C603(*;"Pactado_3@";False:C215)
					: ($page=3)
						OBJECT SET VISIBLE:C603(*;"Pactado_1@";False:C215)
						OBJECT SET VISIBLE:C603(*;"Pactado_2@";False:C215)
						OBJECT SET VISIBLE:C603(*;"Pactado_3@";True:C214)
					Else 
						$page:=1
						SELECT LIST ITEMS BY POSITION:C381(hlTab_ACT_TercerosGen;$page)
						OBJECT SET VISIBLE:C603(*;"Pactado_1@";True:C214)
						OBJECT SET VISIBLE:C603(*;"Pactado_2@";False:C215)
						OBJECT SET VISIBLE:C603(*;"Pactado_3@";False:C215)
				End case 
				
		End case 
		
	Else 
		$ptr_alpAreaSeleccionada:=->xAL_ACT_Terc_UF_P
		Case of 
			: ($page=1)
				SELECT LIST ITEMS BY POSITION:C381(hlTab_ACT_Terceros;1)
				
			: ($page=3)
				SELECT LIST ITEMS BY POSITION:C381(hlTab_ACT_Terceros;1)
				FORM GOTO PAGE:C247(1)
		End case 
		[ACT_Terceros:138]Razon_Social:3:=""
		  //[ACT_Terceros]Giro:=""
		IT_SetButtonState (False:C215;->bDeleteLineC;->bInsertLine;->bDeleteLineI)
	End if 
	UFLD_LoadFields (->[ACT_Terceros:138];->[ACT_Terceros:138]UserFields:26;->[ACT_Terceros]UserFields'Value;$ptr_alpAreaSeleccionada)
	
	SET LIST ITEM PROPERTIES:C386(hlTab_ACT_Terceros;3;([ACT_Terceros:138]Es_empresa:2);1;0)
	  //Faltan detalles
	  //SET LIST ITEM PROPERTIES(hlTab_ACT_Terceros;3;False;1;0)
	
	REDRAW WINDOW:C456
End if 