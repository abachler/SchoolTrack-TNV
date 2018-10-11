Case of 
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
	: (Form event:C388=On Load:K2:1)
		_O_DISABLE BUTTON:C193(bPrev)
		vd_currentDate:=Current date:C33(*)
		vi_PageNumber:=1
		vi_step:=1
		
		  // defectos pagina 2 (seleccion de la matriz a asignar)
		SORT ARRAY:C229(<>atACT_MAtrixName;<>alACT_MatrixID;>)
		COPY ARRAY:C226(<>atACT_MAtrixName;atACT_MAtrixNameCopy)
		COPY ARRAY:C226(<>atACT_MatrixName;atACT_MatrixNameCopy2)
		atACT_MatrixNameCopy:=1
		vsACT_AsignedMatrix:=atACT_MatrixNameCopy{1}
		vsACT_AsignedMatrix2:=atACT_MatrixNameCopy2{1}
		vt_Matrices:="Ninguna;(-;"+AT_array2text (->atACT_MAtrixNameCopy)
		
		ARRAY TEXT:C222(atACTcc_MatrixName;0)
		COPY ARRAY:C226(<>atACT_MatrixName;atACTcc_MatrixName)
		AT_Insert (1;1;->atACTcc_MatrixName)
		atACTcc_MatrixName{1}:="Ninguna"
		
		  //vsACT_FrecFact:=""
		
		  // defectos página 3 (seleccion del universo)
		
		ACTcc_AsignacionUniverso 
		OBJECT SET VISIBLE:C603(*;"Alumnos@";True:C214)
		OBJECT SET VISIBLE:C603(*;"Apdos@";False:C215)
		Case of 
			: (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_CuentasCorrientes:175]))
				If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
					OBJECT SET TITLE:C194(f1;__ ("Solo para los apoderados seleccionados en la lista"))
					OBJECT SET TITLE:C194(f2;__ ("Para todos los apoderados de la lista"))
					OBJECT SET TITLE:C194(f3;__ ("Para todos los alumnos activos"))
					OBJECT SET VISIBLE:C603(*;"Alumnos@";False:C215)
					OBJECT SET VISIBLE:C603(*;"Apdos@";True:C214)
					$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					If (Records in set:C195($set)>0)
						USE SET:C118($set)
						$encontrados:=BWR_SearchRecords 
						If ($encontrados#-1)
							KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
							ACTcc_QuitarAdmision 
							CREATE SET:C116([ACT_CuentasCorrientes:175];"¨Selection")
							viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
						Else 
							f1:=0
							f2:=1
							f3:=0
						End if 
					End if 
				Else 
					f1:=0
					f2:=0
					f3:=1
					_O_DISABLE BUTTON:C193(f1)
					_O_DISABLE BUTTON:C193(f2)
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					ACTcc_QuitarAdmision 
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
			: (Size of array:C274(aBrSelect)>0)
				f1:=1
				f2:=0
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				BWR_SearchRecords 
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
			: (Records in set:C195("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))>0)
				f1:=0
				f2:=1
				f3:=0
				$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
				USE SET:C118($set)
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
			Else 
				f1:=0
				f2:=0
				f3:=1
				_O_DISABLE BUTTON:C193(f1)
				_O_DISABLE BUTTON:C193(f2)
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End case 
		Case of 
			: (f1=1)
				viACT_cuentas:=viACT_cuentas1
			: (f2=1)
				viACT_cuentas:=viACT_cuentas2
			: (f3=1)
				viACT_cuentas:=viACT_cuentas3
		End case 
		
		  // defectos página 4 (opciones de remplazo)
		
		r1:=1
		r2:=0
		r3:=0
		_O_DISABLE BUTTON:C193(bMatrizaReemplazar)
		OBJECT SET COLOR:C271(*;"Reemplazo@";-61966)
		
		XS_SetInterface 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: ((vi_PageNumber=4) & (r1=1))
		Case of 
			: (f1=1)
				If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
					$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					If (Records in set:C195($set)>0)
						USE SET:C118($set)
						$encontrados:=BWR_SearchRecords 
						If ($encontrados#-1)
							KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
							ACTcc_QuitarAdmision 
							CREATE SET:C116([ACT_CuentasCorrientes:175];"¨Selection")
							viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
						End if 
					End if 
					
				Else 
					$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					USE SET:C118($set)
					BWR_SearchRecords 
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					ACTcc_QuitarAdmision 
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
			: (f2=1)
				If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
					$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					If (Records in set:C195($set)>0)
						USE SET:C118($set)
						KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
						QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
						ACTcc_QuitarAdmision 
						CREATE SET:C116([ACT_CuentasCorrientes:175];"¨Selection")
						viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
					End if 
				Else 
					$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
					USE SET:C118($set)
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
					ACTcc_QuitarAdmision 
					CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
					viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
				End if 
			: (f3=1)
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				ACTcc_QuitarAdmision 
				CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
				viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End case 
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
		viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
		If (viACT_cuentas=0)
			_O_DISABLE BUTTON:C193(bNext)
		Else 
			_O_ENABLE BUTTON:C192(bNext)
		End if 
End case 