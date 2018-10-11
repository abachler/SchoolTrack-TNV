//%attributes = {}
  // UD_v20140708_VerificaIndexPK()
If (False:C215)
	  // Por: Alberto Bachler K.: 08-07-14, 08:22:34
	  //  ---------------------------------------------
	  //
	  //
	  //  ---------------------------------------------
End if 


C_BOOLEAN:C305($b_indexado)
_O_C_INTEGER:C282($i_campos;$i_tablas)
C_LONGINT:C283($l_idTermometro;$l_largoCampo;$l_primeraTabla;$l_tipoCampo;$l_ultimaTabla)
C_TEXT:C284($t_nombreCampo;$t_nombreTabla)

ARRAY POINTER:C280($ay_Campos;0)
ARRAY REAL:C219($b_Crear_AutoUUID;0)
<>vb_ImportHistoricos_STX:=True:C214

$l_primeraTabla:=1
$l_ultimaTabla:=Get last table number:C254
$l_idTermometro:=IT_Progress (1;0;0;"Verificando indexación de llaves primarias ...")

For ($i_tablas;$l_primeraTabla;$l_ultimaTabla)
	If (Is table number valid:C999($i_tablas))
		If ($i_tablas=237)
			
		End if 
		$t_nombreTabla:=Table name:C256($i_tablas)
		$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_tablas/$l_ultimaTabla;"Estableciendo llaves primarias en la tabla ..."+$t_nombreTabla)
		For ($i_campos;1;Get last field number:C255($i_tablas))
			If (Is field number valid:C1000($i_tablas;$i_campos))
				$t_nombreCampo:=Field name:C257($i_tablas;$i_campos)
				If ($t_nombreCampo="Auto_UUID")
					GET FIELD PROPERTIES:C258($i_tablas;$i_campos;$l_tipoCampo;$l_largoCampo;$b_indexado)
					If (Not:C34($b_indexado))
						APPEND TO ARRAY:C911($ay_Campos;Field:C253($i_tablas;$i_campos))
						CREATE INDEX:C966(Table:C252($i_tablas)->;$ay_Campos;Default index type:K58:2;"")
					End if 
				End if 
			End if 
		End for 
	End if 
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)

<>vb_ImportHistoricos_STX:=False:C215
