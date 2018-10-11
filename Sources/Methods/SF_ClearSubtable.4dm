//%attributes = {}
  //SF_ClearSubtable

C_POINTER:C301($1)
_O_ALL SUBRECORDS:C109($1->)
While (Not:C34(_O_End subselection:C37($1->)))
	_O_DELETE SUBRECORD:C96($1->)
	_O_ALL SUBRECORDS:C109($1->)
End while 