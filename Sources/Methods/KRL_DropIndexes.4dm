//%attributes = {}
  // KRL_DropIndexes()
  // Por: Alberto Bachler K.: 03-01-15, 10:04:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_index)
C_TEXT:C284($t_nombreIndex)

ARRAY LONGINT:C221($al_campo;0)
ARRAY LONGINT:C221($al_indexType;0)
ARRAY LONGINT:C221($al_tabla;0)
ARRAY TEXT:C222($at_nombreIndex;0)

Begin SQL
	SELECT UIC.TABLE_ID, UIC.COLUMN_ID, UI.INDEX_NAME, UI.INDEX_TYPE
	FROM _USER_INDEXES AS UI, _USER_IND_COLUMNS AS UIC
	WHERE UI.INDEX_ID = UIC.INDEX_ID
	ORDER BY UIC.TABLE_ID, UIC.COLUMN_ID
	INTO :$al_tabla, :$al_campo, :$at_nombreIndex, :$al_indexType;
End SQL

For ($i_index;1;Size of array:C274($al_tabla))
	OK:=0
	If ($at_nombreIndex{$i_index}#"")
		$t_nombreIndex:=$at_nombreIndex{$i_index}
		DELETE INDEX:C967($t_nombreIndex)
	Else 
		  //DELETE INDEX(Field($al_tabla{$i_index};$al_campo{$i_index}))
	End if 
	If (OK=0)
		TRACE:C157
	End if 
End for 

