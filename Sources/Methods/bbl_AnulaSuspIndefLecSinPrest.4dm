//%attributes = {}
  //bbl_AnulaSuspIndefLecSinPrest
  //Anula las suspensiones indefinidas 99-99-99 para los lectores que no tienen préstamos vigentes y que no pueden definir suspensión, esto pasó por un defecto anterior.

READ ONLY:C145([BBL_Lectores:72])
ALL RECORDS:C47([BBL_Lectores:72])
ARRAY LONGINT:C221(aQR_longint1;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];aQR_longint1;"")
C_LONGINT:C283($i)
ARRAY TEXT:C222(aQR_text1;0)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Anulando suspensiones.."))

For ($i;1;Size of array:C274(aQR_longint1))
	READ WRITE:C146([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];aQR_longint1{$i})
	
	If ([BBL_Lectores:72]Fecha_Suspención:45=!1900-01-01!)
		
		QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1;*)
		QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
		
		If (Records in selection:C76([BBL_Prestamos:60])=0)
			[BBL_Lectores:72]Fecha_Suspención:45:=!00-00-00!
			SAVE RECORD:C53([BBL_Lectores:72])
			APPEND TO ARRAY:C911(aQR_text1;[BBL_Lectores:72]NombreCompleto:3+" ID("+String:C10([BBL_Lectores:72]ID:1)+")")
		End if 
		
	End if 
	KRL_UnloadReadOnly (->[BBL_Lectores:72])
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_longint1))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Size of array:C274(aQR_text1)>0)
	vQR_text1:=AT_array2text (->aQR_text1;"\r")
	CD_Dlog (0;__ ("Las suspensiones indefinidas fueron anuladas para los Lectores que no tenían préstamos actualmente vigentes. En el registro de actividades puede ver el listado de Lectores afectados por este proceso\rSuspenciones Anuladas para: \r")+vQR_text1)
	LOG_RegisterEvt ("Suspenciones Anuladas para: "+"\r"+vQR_text1)
	
Else 
	CD_Dlog (0;__ ("No hubo Lectores afectados por este proceso."))
End if 