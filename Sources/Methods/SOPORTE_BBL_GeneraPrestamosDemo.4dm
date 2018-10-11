//%attributes = {}
  //SOPORTE_BBL_GeneraPrestamosDemo

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : zGeneraLoans
	  //Autor: Alberto Bachler
	  //Creada el 13/8/96 a 5:57 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

OK:=CD_Dlog (0;__ ("¿Eliminar todos los prestamos existentes y generar aleatoriamente?");__ ("");__ ("Si");__ ("No"))

If (OK=1)
	
	READ WRITE:C146([BBL_Prestamos:60])
	ALL RECORDS:C47([BBL_Prestamos:60])
	DELETE SELECTION:C66([BBL_Prestamos:60])
	
	ALL RECORDS:C47([BBL_Lectores:72])
	SELECTION TO ARRAY:C260([BBL_Lectores:72]ID:1;$aID)
	$s1:=Size of array:C274($aID)
	ALL RECORDS:C47([BBL_Registros:66])
	SELECTION TO ARRAY:C260([BBL_Registros:66]ID:3;$copy)
	$s2:=Size of array:C274($copy)
	$d1:=Current date:C33(*)-(365*2)
	$dias:=Current date:C33(*)-$d1
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando prestamos..."))
	For ($i;1;10000)
		$registro:=$copy{MATH_RandomLongint (1;$s2)}
		$recNum:=Find in field:C653([BBL_Registros:66]ID:3;$registro)
		If ($recnum<0)
			TRACE:C157
		Else 
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=$registro)
			If ((Records in selection:C76([BBL_Prestamos:60])=0) | ([BBL_Prestamos:60]Fecha_de_devolución:5>!00-00-00!))
				CREATE RECORD:C68([BBL_Prestamos:60])
				[BBL_Prestamos:60]Número_de_Transacción:8:=SQ_SeqNumber (->[BBL_Prestamos:60]Número_de_Transacción:8)
				[BBL_Prestamos:60]Número_de_registro:1:=$registro
				RELATE ONE:C42([BBL_Prestamos:60]Número_de_registro:1)
				[BBL_Prestamos:60]Número_de_Item:11:=[BBL_Registros:66]Número_de_item:1
				If ([BBL_Prestamos:60]Número_de_Item:11=0)
					TRACE:C157
				End if 
				[BBL_Prestamos:60]Número_de_lector:2:=$aID{MATH_RandomLongint (1;$s1)}
				[BBL_Prestamos:60]Desde:3:=$d1+MATH_RandomLongint (1;$dias)
				[BBL_Prestamos:60]Hasta:4:=[BBL_Prestamos:60]Desde:3+15
				Case of 
					: (Day number:C114([BBL_Prestamos:60]Hasta:4)=1)
						[BBL_Prestamos:60]Hasta:4:=[BBL_Prestamos:60]Hasta:4+1
					: (Day number:C114([BBL_Prestamos:60]Hasta:4)=7)
						[BBL_Prestamos:60]Hasta:4:=[BBL_Prestamos:60]Hasta:4+2
				End case 
				If (([BBL_Prestamos:60]Desde:3>(Current date:C33(*)-180)) | (Dec:C9([BBL_Prestamos:60]Número_de_Transacción:8/7)=0))
					[BBL_Prestamos:60]Fecha_de_devolución:5:=!00-00-00!
				Else 
					[BBL_Prestamos:60]Duración:6:=MATH_RandomLongint (1;15)
					[BBL_Prestamos:60]Fecha_de_devolución:5:=[BBL_Prestamos:60]Desde:3+[BBL_Prestamos:60]Duración:6
				End if 
			End if 
			SAVE RECORD:C53([BBL_Prestamos:60])
		End if 
		If (Dec:C9($i/200)=0)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/10000;__ ("Generando prestamos..."))
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	BBLdbu_RebuildStatistics 
	
End if 
