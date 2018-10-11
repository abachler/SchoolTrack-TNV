//%attributes = {}
  //SRal_FichaMedica

READ ONLY:C145([Alumnos_ControlesMedicos:99])
QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=[Alumnos:2]numero:1)

QUERY:C277([Alumnos_FichaMedica_Hospitaliza:222];[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5=[Alumnos:2]numero:1)
ARRAY DATE:C224(ad_Date1;0)
ARRAY TEXT:C222(at_Text1;0)
SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Hospitaliza:222]Fecha:1;ad_Date1;[Alumnos_FichaMedica_Hospitaliza:222]Diagnóstico:2;at_text1)
SORT ARRAY:C229(ad_Date1;at_text1;<)
vt_Hospitalizaciones:=""
For ($i;1;Size of array:C274(ad_Date1))
	vt_Hospitalizaciones:=vt_Hospitalizaciones+DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7;ad_Date1{$i})+", "+at_text1{$i}+"\r"
End for 
vt_Hospitalizaciones:=ST_ClearExtraCR (vt_Hospitalizaciones)



ARRAY TEXT:C222(at_Text2;0)
ARRAY TEXT:C222(at_Text3;0)
ARRAY LONGINT:C221(ai_Int1;0)
QUERY:C277([Alumnos_FichaMedica_Aparatos_pr:226];[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6=[Alumnos:2]numero:1)
SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Aparatos_pr:226]Curso:3;at_Text2;[Alumnos_FichaMedica_Aparatos_pr:226]Aparato:2;at_text3;[Alumnos_FichaMedica_Aparatos_pr:226]NoNivel:4;ai_Int1)
SORT ARRAY:C229(ai_Int1;at_text3;at_Text2;<)

ARRAY TEXT:C222(at_Protesis_Class;0)
ARRAY TEXT:C222(at_Protesis_Ortodoncia;0)
ARRAY TEXT:C222(at_Protesis_Plantillas;0)
ARRAY TEXT:C222(at_Protesis_Lentes;0)
ARRAY TEXT:C222(at_Protesis_Corsé;0)
ARRAY TEXT:C222(at_Protesis_Audifonos;0)
ARRAY LONGINT:C221(ai_Protesis_nonivel;0)

$s:=Size of array:C274(<>al_NumeroNivelesOficiales)
COPY ARRAY:C226(<>at_NombreNivelesOficiales;at_Protesis_Class)
COPY ARRAY:C226(<>al_NumeroNivelesOficiales;ai_Protesis_nonivel)
ARRAY TEXT:C222(at_Protesis_Ortodoncia;$s)
ARRAY TEXT:C222(at_Protesis_Plantillas;$s)
ARRAY TEXT:C222(at_Protesis_Lentes;$s)
ARRAY TEXT:C222(at_Protesis_Corsé;$s)
ARRAY TEXT:C222(at_Protesis_Audifonos;$s)
vt_Protesis_observaciones:=""

For ($i;1;Size of array:C274(ai_Int1))
	
	$pos:=Find in array:C230(ai_Protesis_nonivel;ai_Int1{$i})
	If ($pos>0)
		Case of 
			: (at_Text3{$i}="Ortodoncia")
				at_Protesis_Ortodoncia{$pos}:="X"
			: (at_Text3{$i}="Plantillas")
				at_Protesis_Plantillas{$pos}:="X"
			: (at_Text3{$i}="Lentes")
				at_Protesis_Lentes{$pos}:="X"
			: (at_Text3{$i}="Corsé")
				at_Protesis_Corsé{$pos}:="X"
			: (at_Text3{$i}="Audifonos")
				at_Protesis_Audifonos{$pos}:="X"
			Else 
				vt_Protesis_observaciones:=vt_Protesis_observaciones+at_text3{$i}
		End case 
	End if 
End for 

