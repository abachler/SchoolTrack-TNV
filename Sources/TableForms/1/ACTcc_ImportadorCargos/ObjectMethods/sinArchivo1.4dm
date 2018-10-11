If (Size of array:C274(aPareo)>0)
	$r:=CD_Dlog (0;__ ("Va a perder los datos pre importados. ¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		AL_UpdateArrays (xALP_PreImport;0)
		ACTimp_ArrayDeclarations 
		AL_UpdateArrays (xALP_PreImport;-2)
		ACTimp_UpdateInterface 
		vi_PageNumber:=3
		FORM GOTO PAGE:C247(vi_PageNumber)
		POST KEY:C465(Character code:C91("+");256)
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
		Else 
			r1:=0
			r2:=1
		End if 
		cb_TieneEncabezado:=0
		If (Application type:C494=4D Remote mode:K5:5)
			bc_ExecuteOnServer:=1
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;True:C214)
		Else 
			bc_ExecuteOnServer:=0
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;False:C215)
		End if 
		vt_g1:=""
		vt_g1Temp:=""
	End if 
Else 
	AL_UpdateArrays (xALP_PreImport;0)
	ACTimp_ArrayDeclarations 
	AL_UpdateArrays (xALP_PreImport;-2)
	ACTimp_UpdateInterface 
	vi_PageNumber:=3
	FORM GOTO PAGE:C247(vi_PageNumber)
	POST KEY:C465(Character code:C91("+");256)
	If (SYS_IsMacintosh )
		r1:=1
		r2:=0
	Else 
		r1:=0
		r2:=1
	End if 
	cb_TieneEncabezado:=0
	If (Application type:C494=4D Remote mode:K5:5)
		bc_ExecuteOnServer:=1
		OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;True:C214)
	Else 
		bc_ExecuteOnServer:=0
		OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;False:C215)
	End if 
	vt_g1:=""
	vt_g1Temp:=""
End if 