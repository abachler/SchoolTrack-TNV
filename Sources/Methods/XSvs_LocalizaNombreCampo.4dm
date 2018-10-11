//%attributes = {}
  // XSvs_LocalizaNombreCampo (campo:Y{;codigoPais:T{;codigoLenguaje:T{;nombrelocalizado:T}}})
  // Por: Alberto Bachler: 20/02/13, 16:54:31
  //  ---------------------------------------------
  // localiza el nombre del campo pasado como puntero en función de los parametros recibidos
  //  •Si no se pasa el argumento nombreLocalizado(o si es vacío)se localizan los nombres de campos utilizando el valor del campo [xShell_Field]Alias si no es vacío o el nombre definido en la estructura si [xShell_Fields]Alias es vacío.
  //  •Si pasa el argumento codigoPais sin pasar codigoLenguaje(o si se pasa vacío)se localizan los nombre de los campos en todos los idiomas para el país indicado
  //  •Si pasa el argumento codigoLenguaje sin pasar codigoPais(o si se pasa vacío)se localizan los nombre de los campos para todos los países en el idioma indicad
  //  •Si no se pasan los argumentos codigoPais ni codigoLenguaje se localizan los nombres de campos en todos los idiomas para todos los países
  //
  //  ---------------------------------------------



C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($l_iLenguajes;$l_iPaises;$l_numeroCampo;$l_numeroTabla;$l_recNumAlias;$l_recNumCampoVS;$l_recNumTableVS)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_nombreLocalizado;$t_referenciaCampo;$t_referenciaTabla)

ARRAY TEXT:C222($at_codigoLenguaje;0)
ARRAY TEXT:C222($at_codigoPaises;0)
If (False:C215)
	C_POINTER:C301(XSvs_LocalizaNombreCampo ;$1)
	C_TEXT:C284(XSvs_LocalizaNombreCampo ;$2)
	C_TEXT:C284(XSvs_LocalizaNombreCampo ;$3)
	C_TEXT:C284(XSvs_LocalizaNombreCampo ;$4)
End if 

  // CODIGO
$y_Campo:=$1
Case of 
	: (Count parameters:C259=4)
		$t_codigoPais:=$2
		$t_codigoLenguaje:=$3
		$t_nombreLocalizado:=$4
		
	: (Count parameters:C259=3)
		$t_codigoPais:=$2
		$t_codigoLenguaje:=$3
		
	: (Count parameters:C259=2)
		$t_codigoPais:=$2
	Else 
		
End case 
$l_numeroTabla:=Table:C252($y_Campo)
$l_numeroCampo:=Field:C253($y_Campo)

READ ONLY:C145([xShell_Fields:52])
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1;=;$l_numeroTabla;*)
QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2;=;$l_numeroCampo)
$l_recNumCampoVS:=Record number:C243([xShell_Fields:52])

If ($l_recNumCampoVS>0)
	Case of 
		: (($t_codigoPais="") & ($t_codigoLenguaje=""))
			  // no se recibió código país ni código lenguaje, se actualizan los alias en todos los paises/idiomas
			LIST TO ARRAY:C288("XS_CountryCodes";$at_codigoPaises)
			LIST TO ARRAY:C288("XS_LangageCodes";$at_codigoLenguaje)
			For ($l_iPaises;1;Size of array:C274($at_codigoPaises))
				$t_codigoPais:=ST_GetWord ($at_codigoPaises{$l_iPaises};1;":")
				For ($l_iLenguajes;1;Size of array:C274($at_codigoLenguaje))
					$t_codigoLenguaje:=ST_GetWord ($at_codigoLenguaje{$l_iLenguajes};1;":")
					XSvs_ActualizaLocalizacionCampo ($l_recNumCampoVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
				End for 
			End for 
			
		: (($t_codigoPais#"") & ($t_codigoLenguaje=""))
			  // se actualizan los alias en todos los idiomas para el país recibido en $t_codigoPais
			LIST TO ARRAY:C288("XS_LangageCodes";$at_codigoLenguaje)
			For ($l_iLenguajes;1;Size of array:C274($at_codigoLenguaje))
				$t_codigoLenguaje:=ST_GetWord ($at_codigoLenguaje{$l_iLenguajes};1;":")
				XSvs_ActualizaLocalizacionCampo ($l_recNumCampoVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
			End for 
			
		: (($t_codigoPais="") & ($t_codigoLenguaje#""))
			  // se actualizan los alias en todos los paises para el lenguaje recibido en $t_codigoLenguaje
			LIST TO ARRAY:C288("XS_CountryCodes";$at_codigoPaises)
			For ($l_iPaises;1;Size of array:C274($at_codigoPaises))
				$t_codigoPais:=ST_GetWord ($at_codigoPaises{$l_iPaises};1;":")
				XSvs_ActualizaLocalizacionCampo ($l_recNumCampoVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
			End for 
			
		Else 
			
			  // construyo la llave para acceder al campo y cargo el registro en lectura escritura
			$t_referenciaCampo:=String:C10([xShell_Fields:52]NumeroTabla:1)+"."+String:C10([xShell_Fields:52]NumeroCampo:2)+"."+$t_codigoPais+"."+$t_codigoLenguaje
			$l_recNumAlias:=KRL_FindAndLoadRecordByIndex (->[xShell_FieldAlias:198]FieldRef:5;->$t_referenciaCampo;True:C214)
			If ($l_recNumAlias<0)
				  //si el registro no existe lo creo
				$t_referenciaTabla:=String:C10([xShell_Fields:52]NumeroTabla:1)+"."+$t_codigoPais+"."+$t_codigoLenguaje
				CREATE RECORD:C68([xShell_FieldAlias:198])
				[xShell_FieldAlias:198]Referencia_tablaCampo:1:=[xShell_Fields:52]ReferenciaTablaCampo:7
				[xShell_FieldAlias:198]TableRef:2:=$t_referenciaTabla
				[xShell_FieldAlias:198]FieldRef:5:=$t_referenciaCampo
			End if 
			
			If (([xShell_FieldAlias:198]Alias:3="") | ($t_nombreLocalizado#""))
				  //si el alias está vacío o si se recibió un valor en $t_nombreLocalizado se actualiza el alias
				Case of 
					: ([xShell_Fields:52]Alias:4#"")
						[xShell_FieldAlias:198]Alias:3:=[xShell_Fields:52]Alias:4
					: ([xShell_Fields:52]NombreCampo:3#"")
						[xShell_FieldAlias:198]Alias:3:=[xShell_Fields:52]NombreCampo:3
					Else 
						[xShell_Fields:52]Alias:4:=Field name:C257([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
				End case 
			End if 
			
			SAVE RECORD:C53([xShell_FieldAlias:198])
			KRL_UnloadReadOnly (->[xShell_FieldAlias:198])
			
	End case 
End if 
