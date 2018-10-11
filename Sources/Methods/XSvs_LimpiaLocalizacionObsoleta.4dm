//%attributes = {}
  // XSvs_LimpiaLocalizacionObsoleta()
  // Por: Alberto Bachler: 14/03/13, 08:36:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i)

ARRAY INTEGER:C220($ai_numeroTablas;0)

  // eliminación de alias a tablas no vinculados con ninguna tabla válida actual
ALL RECORDS:C47([xShell_Tables:51])
SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$ai_numeroTablas)
ARRAY TEXT:C222($at_refTablas;Size of array:C274($ai_numeroTablas))
For ($i;1;Size of array:C274($ai_numeroTablas))
	$at_refTablas{$i}:=String:C10($ai_numeroTablas)+"."
End for 
QUERY WITH ARRAY:C644([xShell_TableAlias:199]TableRef:1;$at_refTablas)
ALL RECORDS:C47([xShell_Tables:51])
SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$ai_numeroTablas)
ARRAY TEXT:C222($at_refTablas;Size of array:C274($ai_numeroTablas))
For ($i;1;Size of array:C274($ai_numeroTablas))
	$at_refTablas{$i}:=String:C10($ai_numeroTablas{$i})+".@"
End for 
QUERY WITH ARRAY:C644([xShell_TableAlias:199]TableRef:1;$at_refTablas)
CREATE SET:C116([xShell_TableAlias:199];"AliasVinculados")
ALL RECORDS:C47([xShell_TableAlias:199])
CREATE SET:C116([xShell_TableAlias:199];"Todos")
DIFFERENCE:C122("Todos";"AliasVinculados";"AliasHuerfanos")
USE SET:C118("AliasHuerfanos")

If (Records in selection:C76([xShell_TableAlias:199])>0)
	KRL_RelateSelection (->[xShell_FieldAlias:198]TableRef:2;->[xShell_TableAlias:199]TableRef:1)
	KRL_DeleteSelection (->[xShell_FieldAlias:198])
	KRL_DeleteSelection (->[xShell_TableAlias:199])
End if 

QUERY:C277([xShell_Tables:51];[xShell_Tables:51]EsTablaOcultaEnEditores:35=True:C214)
SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$ai_numeroTablas)
ARRAY TEXT:C222($at_refTablas;Size of array:C274($ai_numeroTablas))
For ($i;1;Size of array:C274($ai_numeroTablas))
	$at_refTablas{$i}:=String:C10($ai_numeroTablas{$i})+".@"
End for 
QUERY WITH ARRAY:C644([xShell_TableAlias:199]TableRef:1;$at_refTablas)
KRL_RelateSelection (->[xShell_FieldAlias:198]Referencia_tablaCampo:1;->[xShell_Fields:52]ReferenciaTablaCampo:7)
KRL_DeleteSelection (->[xShell_FieldAlias:198])
KRL_DeleteSelection (->[xShell_TableAlias:199])

  // eliminación de alias a campos no vinculados con ningún campo válido actual
ALL RECORDS:C47([xShell_Fields:52])
KRL_RelateSelection (->[xShell_FieldAlias:198]Referencia_tablaCampo:1;->[xShell_Fields:52]ReferenciaTablaCampo:7)
CREATE SET:C116([xShell_FieldAlias:198];"AliasVinculados")
ALL RECORDS:C47([xShell_FieldAlias:198])
CREATE SET:C116([xShell_FieldAlias:198];"Todos")
DIFFERENCE:C122("Todos";"AliasVinculados";"AliasHuerfanos")
USE SET:C118("AliasHuerfanos")
KRL_DeleteSelection (->[xShell_FieldAlias:198])
SET_ClearSets ("Todos";"AliasVinculados";"AliasHuerfanos")

