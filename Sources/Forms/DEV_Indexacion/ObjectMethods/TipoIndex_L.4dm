  // CIM_Indices.TipoIndex_L()
  // Por: Alberto Bachler K.: 05-01-15, 09:54:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Header Click:K2:40)
		LISTBOX SORT COLUMNS:C916(*;"listboxIndexes";7;>;6;>;3;>;2;>)
		
End case 