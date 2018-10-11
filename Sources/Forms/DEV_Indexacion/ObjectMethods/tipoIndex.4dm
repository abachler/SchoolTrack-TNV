  // CIM_Indices.tipoIndex()
  // Por: Alberto Bachler K.: 05-01-15, 10:50:51
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Header Click:K2:40)
		$y_OrdenColumna:=OBJECT Get pointer:C1124(Object named:K67:5;"varianteIndex")
		Case of 
			: ($y_OrdenColumna->=0)
				LISTBOX SORT COLUMNS:C916(*;"listboxIndexes";7;>;6;>;3;>;2;>)
			: ($y_OrdenColumna->=1)
				LISTBOX SORT COLUMNS:C916(*;"listboxIndexes";7;>;6;>;3;>;2;>)
			: ($y_OrdenColumna->=2)
				LISTBOX SORT COLUMNS:C916(*;"listboxIndexes";7;<;6;<;3;<;2;<)
		End case 
End case 
