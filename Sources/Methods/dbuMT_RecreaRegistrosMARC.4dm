//%attributes = {}
  // dbuMT_RecreaRegistrosMARC()
  // Por: Alberto Bachler: 17/09/13, 13:34:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i;$i_registros;$j)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_refjSon;$t_valor)

ARRAY INTEGER:C220($al_numeroTablas;0)
ARRAY LONGINT:C221($al_recNumDefinicionMARC;0)
ARRAY TEXT:C222($at_materias;0)

<>CreandoMARC:=True:C214
DELAY PROCESS:C323(Current process:C322;15)
KRL_ClearTable (->[BBL_ItemMarcFields:205])

READ ONLY:C145([xxBBL_MarcRecordStructure:75])
QUERY:C277([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7#0;*)
QUERY:C277([xxBBL_MarcRecordStructure:75]; & ;[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6#0;*)
QUERY:C277([xxBBL_MarcRecordStructure:75]; & ;[xxBBL_MarcRecordStructure:75]Equivalencia_Principal:10=True:C214)
CREATE SET:C116([xxBBL_MarcRecordStructure:75];"MARCtodos")
DISTINCT VALUES:C339([xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6;$al_numeroTablas)

For ($j;1;Size of array:C274($al_numeroTablas))
	$y_tabla:=Table:C252($al_numeroTablas{$j})
	READ WRITE:C146($y_tabla->)
	ALL RECORDS:C47($y_tabla->)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando registros MARC - Etapa ")+String:C10($j)+__ ("..."))
	For ($i_registros;1;Records in selection:C76($y_tabla->))
		USE SET:C118("MARCtodos")
		QUERY SELECTION:C341([xxBBL_MarcRecordStructure:75];[xxBBL_MarcRecordStructure:75]MediaTrack_TableNumber:6=$al_numeroTablas{$j})
		LONGINT ARRAY FROM SELECTION:C647([xxBBL_MarcRecordStructure:75];$al_recNumDefinicionMARC;"")
		For ($i;1;Size of array:C274($al_recNumDefinicionMARC))
			GOTO RECORD:C242([xxBBL_MarcRecordStructure:75];$al_recNumDefinicionMARC{$i})
			$t_valor:=ST_Coerce_to_Text (Field:C253($al_numeroTablas{$j};[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7);False:C215)
			If ($t_valor#"")
				Case of 
					: ($al_numeroTablas{$j}=61)
						CREATE RECORD:C68([BBL_ItemMarcFields:205])
						[BBL_ItemMarcFields:205]Dato:6:=$t_valor
						[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Items:61]Numero:1
						[BBL_ItemMarcFields:205]FieldRef:2:=Num:C11([xxBBL_MarcRecordStructure:75]FieldNumber:1)
						[BBL_ItemMarcFields:205]SubFieldRef:3:=[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8
						[BBL_ItemMarcFields:205]TableNum:7:=61
						[BBL_ItemMarcFields:205]FieldNum:8:=[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7
						[BBL_ItemMarcFields:205]ID_Copia:9:=0
						SAVE RECORD:C53([BBL_ItemMarcFields:205])
					: ($al_numeroTablas{$j}=66)
						CREATE RECORD:C68([BBL_ItemMarcFields:205])
						[BBL_ItemMarcFields:205]Dato:6:=$t_valor
						[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Registros:66]Número_de_item:1
						[BBL_ItemMarcFields:205]FieldRef:2:=Num:C11([xxBBL_MarcRecordStructure:75]FieldNumber:1)
						[BBL_ItemMarcFields:205]SubFieldRef:3:=[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8
						[BBL_ItemMarcFields:205]TableNum:7:=66
						[BBL_ItemMarcFields:205]FieldNum:8:=[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7
						[BBL_ItemMarcFields:205]ID_Copia:9:=[BBL_Registros:66]ID:3
						SAVE RECORD:C53([BBL_ItemMarcFields:205])
					: ($al_numeroTablas{$j}=65)
						ALL RECORDS:C47([BBL_Items:61])
						While (Not:C34(End selection:C36([BBL_Items:61])))
							CREATE RECORD:C68([BBL_ItemMarcFields:205])
							[BBL_ItemMarcFields:205]Dato:6:=$t_valor
							[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Items:61]Numero:1
							[BBL_ItemMarcFields:205]FieldRef:2:=Num:C11([xxBBL_MarcRecordStructure:75]FieldNumber:1)
							[BBL_ItemMarcFields:205]SubFieldRef:3:=[xxBBL_MarcRecordStructure:75]FieldSubFieldRef:8
							[BBL_ItemMarcFields:205]TableNum:7:=61
							[BBL_ItemMarcFields:205]FieldNum:8:=[xxBBL_MarcRecordStructure:75]MediaTrack_FieldNum:7
							[BBL_ItemMarcFields:205]ID_Copia:9:=0
							SAVE RECORD:C53([BBL_ItemMarcFields:205])
							NEXT RECORD:C51([BBL_Items:61])
						End while 
				End case 
			End if 
		End for 
		NEXT RECORD:C51($y_tabla->)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Records in selection:C76($y_tabla->))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	KRL_UnloadReadOnly ($y_tabla)
End for 
CLEAR SET:C117("MARCtodos")

ALL RECORDS:C47([BBL_Items:61])
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;__ ("Creando registros MARC - Etapa 4..."))
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Items:61])
	GOTO RECORD:C242([BBL_Items:61];$al_RecNums{$i_registros})
	AT_Initialize (->$at_materias)
	  // Modificado por: Alexis Bustamante (12-06-2017)
	  //Ticket 179869
	
	
	C_OBJECT:C1216($ob)
	$ob:=OB_Create 
	$ob:=JSON Parse:C1218([BBL_Items:61]Materias_json:53;Is object:K8:27)
	OB_GET ($ob;->$at_materias;"materiasCatalogacion_KW")
	  //$t_refjSon:=JSON Parse text ([BBL_Items]Materias_json)
	  //JSON_ExtraeValorElemento ($t_refjSon;->$at_materias;"materiasCatalogacion_KW")
	  //JSON CLOSE ($t_refjSon)
	For ($i_materias;1;Size of array:C274($at_materias))
		$l_recNum:=Find in field:C653([BBL_Thesaurus:68]Materia:13;$at_materias{$i_materias})
		If ($l_recNum>No current record:K29:2)
			KRL_GotoRecord (->[BBL_Thesaurus:68];$l_recNum;True:C214)
			If ([BBL_Thesaurus:68]Tipo:8=0)
				[BBL_Thesaurus:68]Tipo:8:=650
				SAVE RECORD:C53([BBL_Thesaurus:68])
			End if 
		End if 
		CREATE RECORD:C68([BBL_ItemMarcFields:205])
		[BBL_ItemMarcFields:205]Dato:6:=$at_materias{$i_materias}
		[BBL_ItemMarcFields:205]ID_Item:1:=[BBL_Items:61]Numero:1
		[BBL_ItemMarcFields:205]FieldRef:2:=[BBL_Thesaurus:68]Tipo:8
		[BBL_ItemMarcFields:205]SubFieldRef:3:=String:C10([BBL_Thesaurus:68]Tipo:8;"000")+"a"
		[BBL_ItemMarcFields:205]TableNum:7:=61
		[BBL_ItemMarcFields:205]FieldNum:8:=0
		SAVE RECORD:C53([BBL_ItemMarcFields:205])
	End for 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
	
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[BBL_Items:61])
KRL_UnloadReadOnly (->[BBL_Thesaurus:68])

FLUSH CACHE:C297

<>CreandoMARC:=False:C215
DELAY PROCESS:C323(Current process:C322;15)