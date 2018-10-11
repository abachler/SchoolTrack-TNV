$evt:=Form event:C388

Case of 
	: ($evt=On Data Change:K2:15)
		
		  //si se puede cambiar la cantidad máxima de postulantes
		If (VMaximoPostulantesEnterable=1)
			
			  //desactivo la opción de aspirantes por sección, ya que se calcula sola, de acuerdo a los grupos y candidatos por grupo
			OBJECT SET ENTERABLE:C238(iPST_MaxPerSection;False:C215)
			  //iPST_Groups:=0
			  //iPST_Sections:=0
			  //calculo los aspirantes por seccion
			iPST_MaxPerSection:=Int:C8(iPST_MaxCandidates/(iPST_Groups*iPST_Sections))
		Else 
			  //sino, quiere decir que no es ingresable, por lo que se calculará sola de acuerdo al ingreso de los datos de abajo
			  //activo la opción de maximo de candidatos por sección
			OBJECT SET ENTERABLE:C238(iPST_MaxPerSection;True:C214)
			  //calculo la candidad máxima de candidatos por sección
			iPST_MaxCandidates:=iPST_Groups*iPST_Sections*iPST_MaxPerSection
		End if 
		
End case 
