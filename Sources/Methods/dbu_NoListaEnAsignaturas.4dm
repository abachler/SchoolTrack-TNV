//%attributes = {}
  //dbu_NoListaEnAsignaturas

vsBWR_CurrentModule:="SchoolTrack"
GET PICTURE FROM LIBRARY:C565("Module 1";vpXS_IconModule)
  //$msg:="¿Desea Ud. reasignar el Nº de orden ordenando sólo por nombres o "+"por curso y nombres?"
iOK:=CD_Dlog (0;__ ("¿Desea Ud. reasignar el Nº de orden ordenando sólo por nombres o por curso y nombres?");__ ("");__ ("Por curso");__ ("Sólo nombres");__ ("Cancelar"))
If (iOK#3)
	If (Application type:C494=4D Remote mode:K5:5)
		$pID:=Execute on server:C373("PCSrun_AS_AsignaNumerosDeLista";Pila_256K;"Asignación de numeros de lista en asignaturas";iOK)
		If ($pID#0)
			CD_Dlog (0;__ ("El proceso de reasignación de numeros de lista ya se está ejecutando en el servidor."))
		Else 
			
		End if 
	Else 
		$pID:=New process:C317("PCSrun_AS_AsignaNumerosDeLista";Pila_256K;"Asignación de numeros de lista en asignaturas";iOK)
	End if 
End if 