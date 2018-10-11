//%attributes = {}
  //AL_CertConcent
C_LONGINT:C283(iYear1;iYear2;iYear3;iYear4)

If (Form event:C388=On Printing Detail:K2:18)
	vErrors:=""
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	
	ARRAY TEXT:C222(aText1;0)
	
	GOTO SELECTED RECORD:C245([Alumnos:2];vl_CurrentSelectedRecord)
	
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
	
	
	vs_AbrNoReligion:=ST_GetCleanString (vs_AbrNoReligion)
	If (vs_AbrNoReligion#"")
		vRel1:=vs_AbrNoReligion
		vRel2:=vs_AbrNoReligion
		vRel3:=vs_AbrNoReligion
		vRel4:=vs_AbrNoReligion
	Else 
		vRel1:="N/O"
		vRel2:="N/O"
		vRel3:="N/O"
		vRel4:="N/O"
	End if 
	
	vt_NombreOptativa:="Religión"
	CUT NAMED SELECTION:C334([Alumnos:2];"$seleccion")  //ASM 20170608 Ticket 183203
	AL_initConcent 
	AL_PlantillaConcentracion 
	
	  //1ro medio
	AL_Concent1 
	
	  //2do medio
	AL_Concent2 
	
	  //3ro medio
	AL_Concent3 
	
	  //4to medio
	AL_Concent4 
	
	  // Modificado por: Alexis Bustamante (05/08/2017)
	  //ticket 185668
	  //Cambio el Use named Selection despues de Al_concent# ya que deja en seleccion a alumnos que no son los seleccionados
	USE NAMED SELECTION:C332("$seleccion")
	
	
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	vConcentDate:=<>gComuna+", "+DT_Date2SpanishString (Current date:C33)
	sStudent:=[Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
	
	
	If (vt_Especialidad="")
		OBJECT SET VISIBLE:C603(*;"especialidad@";False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*;"especialidad@";True:C214)
	End if 
	
	If (vErrors#"")
		vErrors:="¡¡¡ ATENCION !!!"+"\r"+"El modelo de certificado no tiene posición definida para "+Substring:C12(vErrors;1;Length:C16(vErrors)-2)
	End if 
	
	
	GOTO SELECTED RECORD:C245([Alumnos:2];vl_CurrentSelectedRecord)
	vl_CurrentSelectedRecord:=vl_CurrentSelectedRecord+1
	
End if 

