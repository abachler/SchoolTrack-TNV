WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_CopiarConfiguracion";0;-Palette form window:K39:9;"Opciones de Copiado")
DIALOG:C40([xShell_Dialogs:114];"XS_CopiarConfiguracion")
CLOSE WINDOW:C154
If (ok=1)
	If ((vtXS_CountryFrom#vtXS_Countryto) | (vtXS_LangageFrom#vtXS_Langageto))
		If ((cb_CopyBlobs=1) & (cb_CopyFields=1) & (cb_CopyCommands=1) & (cb_CopyRSRList=1) & (cb_CopyRSRSTR=1) & (cb_CopyRSRText=1))
			Case of 
				: ((cb_CopiarATodosPaises=1) & (cb_CopiarATodosLang=1))
					$p:=IT_UThermometer (1;0;"Copiando configuración completa de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
					$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
					For ($i;1;Count list items:C380(hl_Paises))
						GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
						$country:=ST_GetWord ($text;1;":")
						For ($j;1;Count list items:C380(hl_Langages))
							GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
							$langage:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->$country;->$langage)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando configuración completa de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+$langage+"...")
								XS_CopyXShellConfig ("all";$country;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
					End for 
					IT_UThermometer (-2;$p)
				: (cb_CopiarATodosPaises=1)
					$p:=IT_UThermometer (1;0;"Copiando configuración completa de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
					$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
					For ($i;1;Count list items:C380(hl_Paises))
						GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
						$country:=ST_GetWord ($text;1;":")
						$dest:=KRL_MakeStringAccesKey (->$country;->vtXS_Langageto)
						If ($dest#$origin)
							IT_UThermometer (0;$p;"Copiando configuración completa de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+vtXS_Langageto+"...")
							XS_CopyXShellConfig ("all";$country;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
						End if 
					End for 
					IT_UThermometer (-2;$p)
				: (cb_CopiarATodosLang=1)
					$p:=IT_UThermometer (1;0;"Copiando configuración completa de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
					$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
					For ($i;1;Count list items:C380(hl_Langages))
						GET LIST ITEM:C378(hl_Langages;$i;$ref;$text)
						$langage:=ST_GetWord ($text;1;":")
						$dest:=KRL_MakeStringAccesKey (->vtXS_Countryto;->$langage)
						If ($dest#$origin)
							IT_UThermometer (0;$p;"Copiando configuración completa de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+$langage+"...")
							XS_CopyXShellConfig ("all";vtXS_Countryto;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
						End if 
					End for 
					IT_UThermometer (-2;$p)
				Else 
					$p:=IT_UThermometer (1;0;"Copiando configuración completa de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+vtXS_Langageto+"...")
					XS_CopyXShellConfig ("all";vtXS_Countryto;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
					IT_UThermometer (-2;$p)
			End case 
		Else 
			If (cb_CopyBlobs=1)
				Case of 
					: ((cb_CopiarATodosPaises=1) & (cb_CopiarATodosLang=1))
						$p:=IT_UThermometer (1;0;"Copiando blobs de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							For ($j;1;Count list items:C380(hl_Langages))
								GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
								$langage:=ST_GetWord ($text;1;":")
								$dest:=KRL_MakeStringAccesKey (->$country;->$langage)
								If ($dest#$origin)
									IT_UThermometer (0;$p;"Copiando blobs de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+$langage+"...")
									XS_CopyXShellConfig ("blobs";$country;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
								End if 
							End for 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosPaises=1)
						$p:=IT_UThermometer (1;0;"Copiando blobs de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->$country;->vtXS_Langageto)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando blobs de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+vtXS_Langageto+"...")
								XS_CopyXShellConfig ("blobs";$country;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosLang=1)
						$p:=IT_UThermometer (1;0;"Copiando blobs de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Langages))
							GET LIST ITEM:C378(hl_Langages;$i;$ref;$text)
							$langage:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->vtXS_Countryto;->$langage)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando blobs de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+$langage+"...")
								XS_CopyXShellConfig ("blobs";vtXS_Countryto;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					Else 
						$p:=IT_UThermometer (1;0;"Copiando blobs de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+vtXS_Langageto+"...")
						XS_CopyXShellConfig ("blobs";vtXS_Countryto;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
						IT_UThermometer (-2;$p)
				End case 
			End if 
			If (cb_CopyFields=1)
				Case of 
					: ((cb_CopiarATodosPaises=1) & (cb_CopiarATodosLang=1))
						$p:=IT_UThermometer (1;0;"Copiando tablas y campos de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							For ($j;1;Count list items:C380(hl_Langages))
								GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
								$langage:=ST_GetWord ($text;1;":")
								$dest:=KRL_MakeStringAccesKey (->$country;->$langage)
								If ($dest#$origin)
									IT_UThermometer (0;$p;"Copiando tablas y campos de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+$langage+"...")
									XS_CopyXShellConfig ("fields";$country;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
								End if 
							End for 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosPaises=1)
						$p:=IT_UThermometer (1;0;"Copiando tablas y campos de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->$country;->vtXS_Langageto)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando tablas y campos de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+vtXS_Langageto+"...")
								XS_CopyXShellConfig ("fields";$country;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosLang=1)
						$p:=IT_UThermometer (1;0;"Copiando tablas y campos de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Langages))
							GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
							$langage:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->vtXS_Countryto;->$langage)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando tablas y campos de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+$langage+"...")
								XS_CopyXShellConfig ("fields";vtXS_Countryto;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					Else 
						$p:=IT_UThermometer (1;0;"Copiando tablas y campos de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+vtXS_Langageto+"...")
						XS_CopyXShellConfig ("fields";vtXS_Countryto;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
						IT_UThermometer (-2;$p)
				End case 
			End if 
			If (cb_CopyCommands=1)
				Case of 
					: ((cb_CopiarATodosPaises=1) & (cb_CopiarATodosLang=1))
						$p:=IT_UThermometer (1;0;"Copiando comandos ejecutables de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							For ($j;1;Count list items:C380(hl_Langages))
								GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
								$langage:=ST_GetWord ($text;1;":")
								$dest:=KRL_MakeStringAccesKey (->$country;->$langage)
								If ($dest#$origin)
									IT_UThermometer (0;$p;"Copiando comandos ejecutables de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+$langage+"...")
									XS_CopyXShellConfig ("commands";$country;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
								End if 
							End for 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosPaises=1)
						$p:=IT_UThermometer (1;0;"Copiando comandos ejecutables de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->$country;->vtXS_Langageto)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando comandos ejecutables de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+vtXS_Langageto+"...")
								XS_CopyXShellConfig ("commands";$country;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosLang=1)
						$p:=IT_UThermometer (1;0;"Copiando comandos ejecutables de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Langages))
							GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
							$langage:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->vtXS_Countryto;->$langage)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando comandos ejecutables de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+$langage+"...")
								XS_CopyXShellConfig ("commands";vtXS_Countryto;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					Else 
						$p:=IT_UThermometer (1;0;"Copiando comandos ejecutables de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+vtXS_Langageto+"...")
						XS_CopyXShellConfig ("commands";vtXS_Countryto;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
						IT_UThermometer (-2;$p)
				End case 
			End if 
			If (cb_CopyRSRList=1)
				Case of 
					: ((cb_CopiarATodosPaises=1) & (cb_CopiarATodosLang=1))
						$p:=IT_UThermometer (1;0;"Copiando recursos lista de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							For ($j;1;Count list items:C380(hl_Langages))
								GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
								$langage:=ST_GetWord ($text;1;":")
								$dest:=KRL_MakeStringAccesKey (->$country;->$langage)
								If ($dest#$origin)
									IT_UThermometer (0;$p;"Copiando recursos lista de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+$langage+"...")
									XS_CopyXShellConfig ("lists";$country;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
								End if 
							End for 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosPaises=1)
						$p:=IT_UThermometer (1;0;"Copiando recursos lista de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->$country;->vtXS_Langageto)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando recursos lista de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+vtXS_Langageto+"...")
								XS_CopyXShellConfig ("lists";$country;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosLang=1)
						$p:=IT_UThermometer (1;0;"Copiando recursos lista de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Langages))
							GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
							$langage:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->vtXS_Countryto;->$langage)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando recursos lista de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+$langage+"...")
								XS_CopyXShellConfig ("lists";vtXS_Countryto;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					Else 
						$p:=IT_UThermometer (1;0;"Copiando recursos lista de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+vtXS_Langageto+"...")
						XS_CopyXShellConfig ("lists";vtXS_Countryto;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
						IT_UThermometer (-2;$p)
				End case 
			End if 
			If (cb_CopyRSRSTR=1)
				Case of 
					: ((cb_CopiarATodosPaises=1) & (cb_CopiarATodosLang=1))
						$p:=IT_UThermometer (1;0;"Copiando recursos STR# de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							For ($j;1;Count list items:C380(hl_Langages))
								GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
								$langage:=ST_GetWord ($text;1;":")
								$dest:=KRL_MakeStringAccesKey (->$country;->$langage)
								If ($dest#$origin)
									IT_UThermometer (0;$p;"Copiando recursos STR# de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+$langage+"...")
									XS_CopyXShellConfig ("strs";$country;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
								End if 
							End for 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosPaises=1)
						$p:=IT_UThermometer (1;0;"Copiando recursos STR# de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->$country;->vtXS_Langageto)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando recursos STR# de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+vtXS_Langageto+"...")
								XS_CopyXShellConfig ("strs";$country;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosLang=1)
						$p:=IT_UThermometer (1;0;"Copiando recursos STR# de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Langages))
							GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
							$langage:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->vtXS_Countryto;->$langage)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando recursos STR# de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+$langage+"...")
								XS_CopyXShellConfig ("strs";vtXS_Countryto;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					Else 
						$p:=IT_UThermometer (1;0;"Copiando recursos STR# de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+vtXS_Langageto+"...")
						XS_CopyXShellConfig ("strs";vtXS_Countryto;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
						IT_UThermometer (-2;$p)
				End case 
			End if 
			If (cb_CopyRSRText=1)
				Case of 
					: ((cb_CopiarATodosPaises=1) & (cb_CopiarATodosLang=1))
						$p:=IT_UThermometer (1;0;"Copiando recursos TEXT de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							For ($j;1;Count list items:C380(hl_Langages))
								GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
								$langage:=ST_GetWord ($text;1;":")
								$dest:=KRL_MakeStringAccesKey (->$country;->$langage)
								If ($dest#$origin)
									IT_UThermometer (0;$p;"Copiando recursos TEXT de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+$langage+"...")
									XS_CopyXShellConfig ("texts";$country;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
								End if 
							End for 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosPaises=1)
						$p:=IT_UThermometer (1;0;"Copiando recursos TEXT de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Paises))
							GET LIST ITEM:C378(hl_Paises;$i;$ref;$text)
							$country:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->$country;->vtXS_Langageto)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando recursos TEXT de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+$country+" - "+vtXS_Langageto+"...")
								XS_CopyXShellConfig ("texts";$country;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					: (cb_CopiarATodosLang=1)
						$p:=IT_UThermometer (1;0;"Copiando recursos TEXT de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a ")
						$origin:=KRL_MakeStringAccesKey (->vtXS_CountryFrom;->vtXS_LangageFrom)
						For ($i;1;Count list items:C380(hl_Langages))
							GET LIST ITEM:C378(hl_Langages;$j;$ref;$text)
							$langage:=ST_GetWord ($text;1;":")
							$dest:=KRL_MakeStringAccesKey (->vtXS_Countryto;->$langage)
							If ($dest#$origin)
								IT_UThermometer (0;$p;"Copiando recursos TEXT de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+$langage+"...")
								XS_CopyXShellConfig ("texts";vtXS_Countryto;$langage;vtXS_CountryFrom;vtXS_LangageFrom)
							End if 
						End for 
						IT_UThermometer (-2;$p)
					Else 
						$p:=IT_UThermometer (1;0;"Copiando recursos TEXT de "+vtXS_CountryFrom+" - "+vtXS_LangageFrom+" a "+vtXS_Countryto+" - "+vtXS_Langageto+"...")
						XS_CopyXShellConfig ("texts";vtXS_Countryto;vtXS_Langageto;vtXS_CountryFrom;vtXS_LangageFrom)
						IT_UThermometer (-2;$p)
				End case 
			End if 
		End if 
	End if 
End if 