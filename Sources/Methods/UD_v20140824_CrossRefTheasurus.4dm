//%attributes = {}
  // UD_v20140824_CrossRefTheasurus()
  // Por: Alberto Bachler K.: 24-08-14, 18:00:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_idTermometro)

ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_subkey;0)
ARRAY TEXT:C222($at_refsUnicas;0)

QUERY:C277([BBL_Thesaurus_CrossRefs:246];[BBL_Thesaurus_CrossRefs:246]References:1="[-@")
KRL_DeleteSelection (->[BBL_Thesaurus_CrossRefs:246])

ALL RECORDS:C47([BBL_Thesaurus:68])

LONGINT ARRAY FROM SELECTION:C647([BBL_Thesaurus:68];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Thesaurus:68])
	GOTO RECORD:C242([BBL_Thesaurus:68];$al_RecNums{$i_registros})
	$l_subkey:=Get subrecord key:C1137([BBL_Thesaurus:68]CrossRefs:3)
	QUERY:C277([BBL_Thesaurus_CrossRefs:246];[BBL_Thesaurus_CrossRefs:246]id_added_by_converter:2=$l_subkey)
	CREATE SET:C116([BBL_Thesaurus_CrossRefs:246];"$todas")
	AT_DistinctsFieldValues (->[BBL_Thesaurus_CrossRefs:246]References:1;->$at_refsUnicas)
	If (Records in set:C195("$todas")>Size of array:C274($at_refsUnicas))
		ARRAY LONGINT:C221($al_subkey;Size of array:C274($at_refsUnicas))
		AT_Populate (->$al_subkey;->$l_subkey)
		USE SET:C118("$todas")
		OK:=KRL_DeleteSelection (->[BBL_Thesaurus_CrossRefs:246])
		If (OK=1)
			ARRAY TO SELECTION:C261($at_refsUnicas;[BBL_Thesaurus_CrossRefs:246]References:1;$al_subkey;[BBL_Thesaurus_CrossRefs:246]id_added_by_converter:2)
		End if 
	End if 
	
	SAVE RECORD:C53([BBL_Thesaurus:68])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[BBL_Thesaurus:68])

