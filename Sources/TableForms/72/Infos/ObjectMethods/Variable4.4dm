QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1;*)
QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([BBL_Prestamos:60]Hasta:4;aDate1;[BBL_Prestamos:60]Fecha_de_devolución:5;aDate2;[BBL_Items:61]Clasificacion:2;aText1;[BBL_Items:61]Primer_título:4;aText2;[BBL_Items:61]Primer_autor:6;aText3;[BBL_Prestamos:60]Número_de_registro:1;aLong1;[BBL_Prestamos:60];aLong2;[BBL_Registros:66]Status:10;aText4)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
SORT ARRAY:C229(aDate1;aLong1;aDate2;aText1;aText2;aText3;aLong2;aText4;<)


$currentdate:=Current date:C33(*)
AL_UpdateArrays (xALP_Loans;Size of array:C274(aLong2))
For ($i;1;Size of array:C274(aDate1))
	Case of 
		: (aText4{$i}><>aCpyStatus{2})
			AL_SetRowColor (xALP_Loans;$i;"Grey";0)
			AL_SetRowStyle (xALP_Loans;$i;2)
		: ((aDate1{$i}<$currentDate) & (aDate2{$i}=!00-00-00!))
			AL_SetRowColor (xALP_Loans;$i;"Red";0)
		: ((aDate2{$i}=!00-00-00!) & (aText4{$i}=<>aCpyStatus{2}))
			AL_SetRowColor (xALP_Loans;$i;"Blue";0)
		: (aDate2{$i}>!00-00-00!)
			AL_SetRowColor (xALP_Loans;$i;"Black";0)
	End case 
End for 
AL_SetLine (xALP_Loans;0)

OBJECT SET VISIBLE:C603(bCurrent;False:C215)
OBJECT SET VISIBLE:C603(bHistoric;True:C214)