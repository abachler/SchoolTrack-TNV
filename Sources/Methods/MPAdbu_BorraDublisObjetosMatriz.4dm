//%attributes = {}
  //MPAdbu_BorraDublisObjetosMatriz

ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
ARRAY LONGINT:C221(aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];aRecNums;"")
For (i;1;Size of array:C274(aRecNums))
	READ WRITE:C146([MPA_AsignaturasMatrices:189])
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];aRecNums{i})
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
	CREATE EMPTY SET:C140([MPA_ObjetosMatriz:204];"Duplicados")
	ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5;>)
	vl_LastID:=0
	While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
		If ([MPA_ObjetosMatriz:204]ID_Competencia:5=vl_lastID)
			ADD TO SET:C119([MPA_ObjetosMatriz:204];"Duplicados")
		End if 
		vl_lastID:=[MPA_ObjetosMatriz:204]ID_Competencia:5
		NEXT RECORD:C51([MPA_ObjetosMatriz:204])
	End while 
	If (Records in set:C195("Duplicados")>0)
		SET_UseSet ("Duplicados")
		KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
	End if 
End for 



ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
ARRAY LONGINT:C221(aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];aRecNums;"")
For (i;1;Size of array:C274(aRecNums))
	READ WRITE:C146([MPA_AsignaturasMatrices:189])
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];aRecNums{i})
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
	CREATE EMPTY SET:C140([MPA_ObjetosMatriz:204];"Duplicados")
	ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4;>)
	vl_LastID:=0
	While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
		If ([MPA_ObjetosMatriz:204]ID_Dimension:4=vl_lastID)
			ADD TO SET:C119([MPA_ObjetosMatriz:204];"Duplicados")
		End if 
		vl_lastID:=[MPA_ObjetosMatriz:204]ID_Dimension:4
		NEXT RECORD:C51([MPA_ObjetosMatriz:204])
	End while 
	If (Records in set:C195("Duplicados")>0)
		SET_UseSet ("Duplicados")
		KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
	End if 
End for 



ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
ARRAY LONGINT:C221(aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];aRecNums;"")
For (i;1;Size of array:C274(aRecNums))
	READ WRITE:C146([MPA_AsignaturasMatrices:189])
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];aRecNums{i})
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
	CREATE EMPTY SET:C140([MPA_ObjetosMatriz:204];"Duplicados")
	ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3;>)
	vl_LastID:=0
	While (Not:C34(End selection:C36([MPA_ObjetosMatriz:204])))
		If ([MPA_ObjetosMatriz:204]ID_Eje:3=vl_lastID)
			ADD TO SET:C119([MPA_ObjetosMatriz:204];"Duplicados")
		End if 
		vl_lastID:=[MPA_ObjetosMatriz:204]ID_Eje:3
		NEXT RECORD:C51([MPA_ObjetosMatriz:204])
	End while 
	If (Records in set:C195("Duplicados")>0)
		SET_UseSet ("Duplicados")
		KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
	End if 
End for 
