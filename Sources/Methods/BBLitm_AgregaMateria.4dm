//%attributes = {}
  // BBLitm_AgregaMateria()
  // Por: Alberto Bachler: 17/09/13, 13:21:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_elemento;$l_iditem;$l_tipoReferenciaMARC)
C_TEXT:C284($t_llaveMARC;$t_materia;$t_referenciaMARC;$t_refjSon)
C_OBJECT:C1216($ob_Materias)

ARRAY TEXT:C222($at_materias;0)


If (False:C215)
	C_LONGINT:C283(BBLitm_AgregaMateria ;$1)
	C_TEXT:C284(BBLitm_AgregaMateria ;$2)
End if 

$l_iditem:=$1
$t_materia:=$2
READ ONLY:C145([BBL_ItemMarcFields:205])
READ ONLY:C145([BBL_Thesaurus:68])

If ($t_materia#"")
	If (Find in field:C653([BBL_Thesaurus:68]Materia:13;$t_materia)<0)
		CREATE RECORD:C68([BBL_Thesaurus:68])
		[BBL_Thesaurus:68]Materia:13:=$t_materia
		[BBL_Thesaurus:68]Tipo:8:=650
		SAVE RECORD:C53([BBL_Thesaurus:68])
	End if 
	
	If (([BBL_Items:61]Materias_json:53="") | ([BBL_Items:61]Materias_json:53="undefined"))  //MONO ticket 161866
		[BBL_Items:61]Materias_json:53:="{}"
	End if 
	$ob_Materias:=OB_JsonToObject ([BBL_Items:61]Materias_json:53)
	
	If (OB Is defined:C1231($ob_Materias))  //MONO ticket 161866
		OB_GET ($ob_Materias;->$at_materias;"materiasCatalogacion_KW")
		$l_elemento:=Find in array:C230($at_materias;$t_materia)
		If ($l_elemento<0)
			APPEND TO ARRAY:C911($at_materias;$t_materia)
			OB_SET ($ob_Materias;->$at_materias;"materiasCatalogacion_KW")
			[BBL_Items:61]Materias_json:53:=OB_Object2Json ($ob_Materias;True:C214)
			
			If (<>gUsaMARC)
				$l_tipoReferenciaMARC:=KRL_GetNumericFieldData (->[BBL_Thesaurus:68]Materia:13;->$t_materia;->[BBL_Thesaurus:68]Tipo:8)
				If ($l_tipoReferenciaMARC>0)
					  // si la palabra clave actual es una materia válida (está en el thesaurus)
					$t_referenciaMARC:=String:C10($l_tipoReferenciaMARC;"000")+"a"
					$t_llaveMARC:=String:C10($l_IdItem)+"."+String:C10($l_tipoReferenciaMARC)+"_"+$t_referenciaMARC
					QUERY:C277([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]ID_Item:1=$l_IdItem;*)
					QUERY:C277([BBL_ItemMarcFields:205]; & [BBL_ItemMarcFields:205]CompoundIndex:4=$t_llaveMARC)
					QUERY SELECTION:C341([BBL_ItemMarcFields:205];[BBL_ItemMarcFields:205]Dato:6=$t_materia)
					If (Records in selection:C76([BBL_ItemMarcFields:205])=0)
						CREATE RECORD:C68([BBL_ItemMarcFields:205])
						[BBL_ItemMarcFields:205]Dato:6:=$t_materia
						[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Items:61]Numero:1
						[BBL_ItemMarcFields:205]FieldRef:2:=$l_tipoReferenciaMARC
						[BBL_ItemMarcFields:205]SubFieldRef:3:=$t_referenciaMARC
						[BBL_ItemMarcFields:205]TableNum:7:=61
						[BBL_ItemMarcFields:205]FieldNum:8:=0
						SAVE RECORD:C53([BBL_ItemMarcFields:205])
					End if 
				End if 
			End if 
		End if 
	End if 
End if 
KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205];->[BBL_Thesaurus:68])


