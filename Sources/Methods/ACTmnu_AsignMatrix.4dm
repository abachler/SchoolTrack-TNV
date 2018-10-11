//%attributes = {}
  //ACTmnu_AsignMatrix

If (USR_GetMethodAcces (Current method name:C684))
	  //C_LONGINT($0;$1)
	  // /15102015 se elimina parametro $0, no estaba siendo recibido y daba mensajes de error en compilado
	  //ticket asociado 151026 JVP
	C_LONGINT:C283($1)
	C_LONGINT:C283($l_idMatriz)
	If (Count parameters:C259=1)
		$choice:=$1
	Else 
		$choice:=-2
	End if 
	If (vb_RecordInInputForm)
		If (Not:C34(Locked:C147([ACT_CuentasCorrientes:175])))
			$recNumCta:=Record number:C243([ACT_CuentasCorrientes:175])
			If ($choice=-2)
				  //If (([ACT_CuentasCorrientes]Estado=False) | (([Alumnos]Nivel_Número=Nivel_AdmisionDirecta) & (viACT_AsignarMatAdmision=0)))
				If (([ACT_CuentasCorrientes:175]Estado:4=False:C215) | (([Alumnos:2]nivel_numero:29<=Nivel_AdmisionDirecta) & (viACT_AsignarMatAdmision=0)))  //20170801 RCH
					$Matrices:="Ninguna"
				Else 
					$Matrices:=AT_array2text (-><>atACT_MatrixName)
					$Matrices:="Ninguna;(-;"+$Matrices
				End if 
				If (Size of array:C274(<>atACT_MatrixName)<=50)
					$choice:=Pop up menu:C542($Matrices)
					Case of 
						: ($choice=1)
							$choice:=0
						: ($choice>2)
							vsACT_AsignedMatrix:=<>atACT_MatrixName{$choice-2}
							$choice:=Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix)
						Else 
							$choice:=-1
					End case 
				Else 
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;1)
					<>aChoicePtrs{1}:=->atACTcc_MatrixName
					TBL_ShowChoiceList (1;"Seleccione la Matriz";1;->vsACT_AsignedMatrix)
					If (ok=1)
						vsACT_AsignedMatrix:=atACTcc_MatrixName{choiceIdx}
						If (vsACT_AsignedMatrix="Ninguna")
							$choice:=0
						Else 
							$choice:=Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix)
						End if 
					Else 
						$choice:=-1
					End if 
				End if 
			End if 
			
			If ($choice>=0)
				$l_idMatriz:=ACTmatrices_AsignaNuevasMatrice (Choose:C955(($choice>0);<>alACT_MatrixID{$choice};0);True:C214;True:C214)
				If ($l_idMatriz>0)
					vsACT_AsignedMatrix:=KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->$l_idMatriz;->[ACT_Matrices:177]Nombre_matriz:2)
				Else 
					vsACT_AsignedMatrix:="Seleccionar..."
				End if 
				KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$recNumCta;True:C214)
				
			End if 
		Else 
			CD_Dlog (0;__ ("Esta cuenta está siendo utilizada por otro proceso. Intente cambiar la matriz más tarde"))
		End if 
	Else 
		If (Test semaphore:C652("ConfigACT"))
			CD_Dlog (0;__ ("No es posible realizar la asignación de matrices en este momento.\rOtro usuario está realizando modificaciones a la configuración de AccountTrack que podrían afectar este proceso.\r\rPor favor intente la asignación más tarde."))
		Else 
			$sem:=Semaphore:C143("ProcesoACT")
			ACTinit_LoadMatrixIntoArrays 
			$Locked:=False:C215
			If (Size of array:C274(<>atACT_MatrixName)=0)
				CD_Dlog (0;__ ("No existen definiciones de matrices de cargo.\rDefina primero las matrices en el menu Configuración...");__ ("");__ ("Aceptar"))
			Else 
				WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_Asignacion_de_Matriz";0;4;__ ("Asignación de matriz"))
				DIALOG:C40([xxSTR_Constants:1];"ACTcc_Asignacion_de_Matriz")
				CLOSE WINDOW:C154
				If (ok=1)
					  // busqueda de las cuentas corrientes  
					READ WRITE:C146([ACT_CuentasCorrientes:175])
					
					Case of 
						: (f1=1)
							$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
							USE SET:C118($set)
							BWR_SearchRecords 
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
							ACTcc_QuitarAdmision 
							CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
							viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
						: (f2=1)
							$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
							USE SET:C118($set)
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
							ACTcc_QuitarAdmision 
							CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
							viACT_cuentas2:=Records in selection:C76([ACT_CuentasCorrientes:175])
						: (f3=1)
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
							ACTcc_QuitarAdmision 
							CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
							viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
					End case 
					  // busqueda en la selección según las opciones de reemplazo
					SET_UseSet ("Selection")
					Case of 
						: (r1=1)
							QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
							viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
						: (r2=1)
							If ((vsACT_AsignedMatrix2#"") & (vsACT_AsignedMatrix2#"Ninguna"))
								$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
								QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
							Else 
								QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
							End if 
							viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
						: (r3=1)
							viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
					End case 
					If (vsACT_AsignedMatrix="Ninguna")
						$matrixID:=0
					Else 
						$matrix2Asign:=Find in array:C230(<>atACT_MAtrixName;vsACT_AsignedMatrix)
						$matrixID:=<>alACT_MatrixID{$matrix2Asign}
					End if 
					ACTmatrices_AsignaNuevasMatrice ($matrixID;True:C214)
					
					POST KEY:C465(-96)
				End if 
			End if 
			CLEAR SEMAPHORE:C144("ProcesoACT")
		End if 
	End if 
End if 