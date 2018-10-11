//%attributes = {}
  // XSvs_ActualizaLocalizacionTabla($l_recNumTableVS:L{;$t_codigoPais:T{;$t_codigoLenguaje:T{;$t_nombreLocalizado:T}}})
  // Actualiza los alias para una tabla
  // - para todas las combinaciones pais/idioma, si se pasa solo el primer argumento (recNum tabla xShellFields) o si $t_codigoPais y $t_codigoLenguaje son vacíos
  // - para todos los idiomas en el país pasado en $t_codigoPais
  // - para todos los países en el lenguaje pasado en $t_codigoLenguaje
  // Si $t_nombreLocalizado es vacío se utiliza el alias definido en la estructura virtual genérica, si no es vacío se sobreescribe el alias con el valor pasado
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 12/02/13, 08:53:14
  // ---------------------------------------------

C_LONGINT:C283($l_iLenguajes;$l_iPaises;$l_recNumAlias;$l_recNumTableVS)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_nombreLocalizado;$t_referenciaTabla)

ARRAY TEXT:C222($at_codigoPaises;0)
ARRAY TEXT:C222($at_codigoLenguaje;0)



$l_recNumTableVS:=$1
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

If ($l_recNumTableVS#Record number:C243([xShell_Tables:51]))
	KRL_GotoRecord (->[xShell_Tables:51];$l_recNumTableVS;False:C215)
Else 
	OK:=1
End if 

Case of 
	: (($t_codigoPais="") & ($t_codigoLenguaje=""))
		  // no se recibió código país ni código lenguaje, se actualizan los alias en todos los paises/idiomas
		LIST TO ARRAY:C288("XS_CountryCodes";$at_codigoPaises)
		LIST TO ARRAY:C288("XS_LangageCodes";$at_codigoLenguaje)
		For ($l_iPaises;1;Size of array:C274($at_codigoPaises))
			$t_codigoPais:=ST_GetWord ($at_codigoPaises{$l_iPaises};1;":")
			For ($l_iLenguajes;1;Size of array:C274($at_codigoLenguaje))
				$t_codigoLenguaje:=ST_GetWord ($at_codigoLenguaje{$l_iLenguajes};1;":")
				  // el método se llama a si mismo pasando ahora $t_codigoPais, $t_codigoLenguaje y $t_nombreLocalizado (que puede ser vacío)
				XSvs_ActualizaLocalizacionTabla ($l_recNumTableVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
			End for 
		End for 
		
	: (($t_codigoPais#"") & ($t_codigoLenguaje=""))
		  // se actualizan los alias en todos los idiomas para el país recibido en $t_codigoPais
		LIST TO ARRAY:C288("XS_LangageCodes";$at_codigoLenguaje)
		For ($l_iLenguajes;1;Size of array:C274($at_codigoLenguaje))
			$t_codigoLenguaje:=ST_GetWord ($at_codigoLenguaje{$l_iLenguajes};1;":")
			  // el método se llama a si mismo pasando ahora $t_codigoPais, $t_codigoLenguaje y $t_nombreLocalizado (que puede ser vacío)
			XSvs_ActualizaLocalizacionTabla ($l_recNumTableVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
		End for 
		
	: (($t_codigoPais="") & ($t_codigoLenguaje#""))
		  // se actualizan los alias en todos los paises para el lenguaje recibido en $t_codigoLenguaje
		LIST TO ARRAY:C288("XS_CountryCodes";$at_codigoPaises)
		For ($l_iPaises;1;Size of array:C274($at_codigoPaises))
			$t_codigoPais:=ST_GetWord ($at_codigoPaises{$l_iPaises};1;":")
			  // el método se llama a si mismo pasando ahora $t_codigoPais, $t_codigoLenguaje y $t_nombreLocalizado (que puede ser vacío)
			XSvs_ActualizaLocalizacionTabla ($l_recNumTableVS;$t_codigoPais;$t_codigoLenguaje;$t_nombreLocalizado)
		End for 
		
	Else 
		
		  // construyo la llave para acceder al campo y cargo el registro en lectura escritura
		$t_referenciaTabla:=String:C10([xShell_Tables:51]NumeroDeTabla:5)+"."+$t_codigoPais+"."+$t_codigoLenguaje
		$l_recNumAlias:=KRL_FindAndLoadRecordByIndex (->[xShell_TableAlias:199]TableRef:1;->$t_referenciaTabla;True:C214)
		If ($l_recNumAlias<0)
			  //si el registro no existe lo creo
			$t_referenciaTabla:=String:C10([xShell_Tables:51]NumeroDeTabla:5)+"."+$t_codigoPais+"."+$t_codigoLenguaje
			CREATE RECORD:C68([xShell_TableAlias:199])
			[xShell_TableAlias:199]TableRef:1:=$t_referenciaTabla
		End if 
		
		If (([xShell_TableAlias:199]Alias:2="") | ($t_nombreLocalizado#""))
			  //si el alias está vacío o si se recibió un valor en $t_nombreLocalizado se actualiza el alias
			Case of 
				: ($t_nombreLocalizado#"")
					[xShell_TableAlias:199]Alias:2:=$t_nombreLocalizado
				: ([xShell_Tables:51]Alias:7#"")
					[xShell_TableAlias:199]Alias:2:=[xShell_Tables:51]Alias:7
				: ([xShell_Tables:51]NombreDeTabla:1#"")
					[xShell_TableAlias:199]Alias:2:=[xShell_Tables:51]NombreDeTabla:1
				Else 
					[xShell_TableAlias:199]Alias:2:=Table name:C256([xShell_Tables:51]NumeroDeTabla:5)
			End case 
		End if 
		If (KRL_RegistroFueModificado (->[xShell_TableAlias:199]))
			SAVE RECORD:C53([xShell_TableAlias:199])
		End if 
		KRL_UnloadReadOnly (->[xShell_TableAlias:199])
End case 

