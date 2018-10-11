//%attributes = {}
  // VS_buildTableList()
  // Por: Alberto Bachler: 19/03/13, 23:42:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_campoInvisible;$b_indexado;$b_tablaEsInvisible;$b_unico)
C_LONGINT:C283($i_campos;$i_tablas)
C_LONGINT:C283($l_Campos_HL;$l_largoCampo;$l_numeroCampo;$l_numeroTabla;$l_Tablas_HL;$l_tipoCampo)
C_TEXT:C284($t_nombreTabla;$t_nombreTablaVirtual;$t_nombreCampo)


  //building virtual structure list
$l_Tablas_HL:=New list:C375
For ($l_numeroTabla;1;Get last table number:C254)
	If (Is table number valid:C999($l_numeroTabla))
		$t_nombreTabla:=Table name:C256($l_numeroTabla)
		$t_nombreTablaVirtual:=API Get Virtual Table Name ($l_numeroTabla)
		If ($t_nombreTablaVirtual="")
			$t_nombreTablaVirtual:=$t_nombreTabla
		End if 
		GET TABLE PROPERTIES:C687($l_numeroTabla;$b_tablaEsInvisible)
		If ((Not:C34($b_tablaEsInvisible)) & (Table name:C256($l_numeroTabla)#"zz@") & (Table name:C256($l_numeroTabla)#"xShell@") & (Table name:C256($l_numeroTabla)#"xx@"))
			APPEND TO LIST:C376($l_Tablas_HL;$t_nombreTablaVirtual;$l_numeroTabla;0;False:C215)
		End if 
	End if 
End for 
SORT LIST:C391($l_Tablas_HL)

For ($i_tablas;1;Count list items:C380($l_Tablas_HL))
	$l_Campos_HL:=New list:C375
	GET LIST ITEM:C378($l_Tablas_HL;$i_tablas;$l_numeroTabla;$t_nombreTablaVirtual)
	For ($i_campos;1;Get last field number:C255($l_numeroTabla))
		If (Is field number valid:C1000($l_numeroTabla;$i_campos))
			$l_numeroCampo:=Num:C11(String:C10($l_numeroTabla)+String:C10($i_campos;"000"))
			$t_nombreCampo:=API Get Virtual Field Name ($l_numeroTabla;$i_campos)
			If ($t_nombreCampo="")
				$t_nombreCampo:=Field name:C257($l_numeroTabla;$i_campos)
			End if 
			APPEND TO LIST:C376($l_Campos_HL;$t_nombreCampo;$l_numeroCampo;0;False:C215)
		End if 
	End for 
	SORT LIST:C391($l_Campos_HL)
	SET LIST ITEM:C385($l_Tablas_HL;$l_numeroTabla;$t_nombreTablaVirtual;$l_numeroTabla;$l_Campos_HL;False:C215)
End for 
HL_CollapseAll ($l_Tablas_HL)
SAVE LIST:C384($l_Tablas_HL;"XS_Tables")




  //building real structure list
$l_Tablas_HL:=New list:C375
For ($i_tablas;1;Get last table number:C254)
	If (Is table number valid:C999($i_tablas))
		$t_nombreTabla:=Table name:C256($i_tablas)
		APPEND TO LIST:C376($l_Tablas_HL;$t_nombreTabla;$i_tablas;0;False:C215)
	End if 
End for 
SORT LIST:C391($l_Tablas_HL)
For ($i_tablas;1;Count list items:C380($l_Tablas_HL))
	$l_Campos_HL:=New list:C375
	GET LIST ITEM:C378($l_Tablas_HL;$i_tablas;$l_numeroTabla;$t_nombreTabla)
	For ($i_campos;1;Get last field number:C255($l_numeroTabla))
		If (Is field number valid:C1000($l_numeroTabla;$i_campos))
			GET FIELD PROPERTIES:C258($l_numeroTabla;$i_campos;$l_tipoCampo;$l_largoCampo;$b_indexado;$b_unico;$b_campoInvisible)
			If (Not:C34($b_campoInvisible))
				$l_numeroCampo:=Num:C11(String:C10($l_numeroTabla)+String:C10($i_campos;"000"))
				APPEND TO LIST:C376($l_Campos_HL;Field name:C257($l_numeroTabla;$i_campos);$l_numeroCampo;0;False:C215)
			End if 
		End if 
	End for 
	SORT LIST:C391($l_Campos_HL)
	SET LIST ITEM:C385($l_Tablas_HL;$l_numeroTabla;$t_nombreTabla;$l_numeroTabla;$l_Campos_HL;False:C215)
End for 
HL_CollapseAll ($l_Tablas_HL)
SAVE LIST:C384($l_Tablas_HL;"XS_RealTables")