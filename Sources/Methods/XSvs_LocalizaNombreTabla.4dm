//%attributes = {}
  // XSvs_LocalizaNombreTabla (tabla:Y{;codigoPais:T{;codigoLenguaje:T{;nombrelocalizado:T}}})
  // Por: Alberto Bachler: 20/02/13, 17:15:16
  //  ---------------------------------------------
  // localiza el nombre del tabla pasado como puntero en función de los demás parámetros
  //   •Si no se pasa el argumento nombreLocalizado(o si es vacío)se utiliza el tabla se localizan los nombres de tablas utilizando el valor del campo [xShell_Tablas]Alias si no es vacío o el nombre definido en la estructura si [xShell_Tablas]Alias si es vacío.
  //   •Si pasa el argumento codigoPais sin pasar codigoLenguaje(o si se pasa vacío)se localizan los nombre de los tablas en todos los idiomas para el país indicado
  //   •Si pasa el argumento codigoLenguaje sin pasar codigoPais(o si se pasa vacío)se localizan los nombre de los tablas para todos los países en el idioma indicad
  //   •Si no se pasan los argumentos codigoPais ni codigoLenguaje se localizan los nombres de tablas en todos los idiomas para todos los países.  
  //  ---------------------------------------------



C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($l_iLenguajes;$l_iPaises;$l_recNumAlias;$l_recNumTableVS;$l_numeroTabla)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_nombreLocalizado;$t_referenciaTabla)

ARRAY TEXT:C222($at_codigoLenguaje;0)
ARRAY TEXT:C222($at_codigoPaises;0)
If (False:C215)
	C_POINTER:C301(XSvs_LocalizaNombreTabla ;$1)
	C_TEXT:C284(XSvs_LocalizaNombreTabla ;$2)
	C_TEXT:C284(XSvs_LocalizaNombreTabla ;$3)
	C_TEXT:C284(XSvs_LocalizaNombreTabla ;$4)
End if 


$y_tabla:=$1
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

$l_numeroTabla:=Table:C252($y_tabla)
$l_recNumTableVS:=Find in field:C653([xShell_Tables:51]NumeroDeTabla:5;$l_numeroTabla)

If ($l_recNumTableVS>0)
	
	Case of 
		: (($t_codigoPais="") & ($t_codigoLenguaje=""))
			  // no se recibió código país ni código lenguaje, se actualizan los alias en todos los paises/idiomas
			LIST TO ARRAY:C288("XS_CountryCodes";$at_codigoPaises)
			LIST TO ARRAY:C288("XS_LangageCodes";$at_codigoLenguaje)
			For ($l_iPaises;1;Size of array:C274($at_codigoPaises))
				$t_codigoPais:=ST_GetWord ($at_codigoPaises{$l_iPaises};1;":")
				For ($l_iLenguajes;1;Size of array:C274($at_codigoLenguaje))
					$t_codigoLenguaje:=ST_GetWord ($at_codigoLenguaje{$l_iLenguajes};1;":")
					XSvs_ActualizaLocalizacionTabla ($l_recNumTableVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
				End for 
			End for 
			
		: (($t_codigoPais#"") & ($t_codigoLenguaje=""))
			  // se actualizan los alias en todos los idiomas para el país recibido en $t_codigoPais
			LIST TO ARRAY:C288("XS_LangageCodes";$at_codigoLenguaje)
			For ($l_iLenguajes;1;Size of array:C274($at_codigoLenguaje))
				$t_codigoLenguaje:=ST_GetWord ($at_codigoLenguaje{$l_iLenguajes};1;":")
				XSvs_ActualizaLocalizacionTabla ($l_recNumTableVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
			End for 
			
		: (($t_codigoPais="") & ($t_codigoLenguaje#""))
			  // se actualizan los alias en todos los paises para el lenguaje recibido en $t_codigoLenguaje
			LIST TO ARRAY:C288("XS_CountryCodes";$at_codigoPaises)
			For ($l_iPaises;1;Size of array:C274($at_codigoPaises))
				$t_codigoPais:=ST_GetWord ($at_codigoPaises{$l_iPaises};1;":")
				XSvs_ActualizaLocalizacionTabla ($l_recNumTableVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
			End for 
			
		Else 
			
			  // construyo la llave para acceder al campo y cargo el registro en lectura escritura
			$t_referenciaTabla:=String:C10([xShell_Fields:52]NumeroTabla:1)+"."+$t_codigoPais+"."+$t_codigoLenguaje
			$l_recNumAlias:=KRL_FindAndLoadRecordByIndex (->[xShell_TableAlias:199]TableRef:1;->$t_referenciaTabla;True:C214)
			If ($l_recNumAlias<0)
				  //si el registro no existe lo creo
				$t_referenciaTabla:=String:C10([xShell_Tables:51]NumeroDeTabla:5)+"."+$t_codigoPais+"."+$t_codigoLenguaje
				CREATE RECORD:C68([xShell_TableAlias:199])
				[xShell_TableAlias:199]TableRef:1:=$t_referenciaTabla
				[xShell_TableAlias:199]PaisLenguaje:4:=$t_codigoPais+"."+$t_codigoLenguaje
			End if 
			
			If (([xShell_TableAlias:199]Alias:2="") | ($t_nombreLocalizado#""))
				  //si el alias está vacío o si se recibió un valor en $t_nombreLocalizado se actualiza el alias
				Case of 
					: ($t_nombreLocalizado#"")
						[xShell_TableAlias:199]Alias:2:=$t_nombreLocalizado
					: ([xShell_Tables:51]Alias:7#"")
						[xShell_TableAlias:199]Alias:2:=[xShell_Tables:51]Alias:7
					: ([xShell_Tables:51]NombreDeTabla:1#"")
						[xShell_FieldAlias:198]Alias:3:=[xShell_Tables:51]NombreDeTabla:1
					Else 
						[xShell_TableAlias:199]Alias:2:=Table name:C256([xShell_Tables:51]NumeroDeTabla:5)
				End case 
			End if 
			
			SAVE RECORD:C53([xShell_TableAlias:199])
			KRL_UnloadReadOnly (->[xShell_TableAlias:199])
	End case 
End if 