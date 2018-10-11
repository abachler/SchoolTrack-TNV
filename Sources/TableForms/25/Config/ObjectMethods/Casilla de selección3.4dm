
USE SET:C118\
(\
"Histórico")\

If (\
bActas=0)\

	QUERY SELECTION:C341(\
		[Asignaturas_Historico:84];[Asignaturas_Historico:84]Incluida_En_Actas:7=False:C215)\
		
End if 
If (\
bPromediables=0)\

	QUERY SELECTION:C341(\
		[Asignaturas_Historico:84];[Asignaturas_Historico:84]Promediable:6=False:C215)\
		
End if 
Case of 
	: (\
		(\
		bPC=1)\
		 & (\
		bPE=0)\
		)\
		
		QUERY SELECTION:C341(\
			[Asignaturas_Historico:84];[Asignaturas_Historico:84]Electiva:10=False:C215)\
			
	: (\
		(\
		bPC=0)\
		 & (\
		bPE=1)\
		)\
		
		QUERY SELECTION:C341(\
			[Asignaturas_Historico:84];[Asignaturas_Historico:84]Electiva:10=True:C214)\
			
End case 
AL_UpdateFields (\
xALP_HSubjects;2)\
