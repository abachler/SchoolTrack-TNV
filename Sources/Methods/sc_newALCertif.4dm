//%attributes = {}
  //sc_newALCertif

If (Form event:C388=On Printing Detail:K2:18)
	
	Case of 
			
		: (((<>icrtfYear=0) | (<>icrtfYear=<>gYear)) & (([Alumnos:2]nivel_numero:29=1000) | ([Alumnos:2]nivel_numero:29=1001)))
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6<1000)
			ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<)
			If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
				<>icrtfYear:=[Alumnos_SintesisAnual:210]Año:2
				AL_CertificadoAñoAnterior 
			Else 
				ACTAS_Initialize 
				CD_Dlog (0;__ ("No existe información que permita imprimir un certificado de estudios para ")+[Alumnos:2]apellidos_y_nombres:40)
			End if 
			
			
		: ((<>icrtfYear=<>gYear) & ([Alumnos:2]nivel_numero:29>=1) & ([Alumnos:2]nivel_numero:29<=12))
			AL_CertificadoAñoActual 
			If (vCert2="")
				vCert2:=<>gCustom
			End if 
			
			
		: ((<>icrtfYear<<>gYear) & ([Alumnos:2]nivel_numero:29>=1) & ([Alumnos:2]nivel_numero:29<=12))
			AL_CertificadoAñoAnterior 
			
		: ((<>icrtfYear<<>gYear) & (([Alumnos:2]nivel_numero:29=1000) | ([Alumnos:2]nivel_numero:29=1001)))
			AL_CertificadoAñoAnterior 
	End case 
End if 