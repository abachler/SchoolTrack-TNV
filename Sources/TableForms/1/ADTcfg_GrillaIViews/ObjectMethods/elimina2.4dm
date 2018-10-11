$r:=CD_Dlog (0;__ ("Eliminar los registros de entrevistas implica definir nuevamente la disponiblidad de los entrevistadores y asignar nuevamente las entrevistas a los postulantes. ¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
If ($r=2)
	KRL_ClearTable (->[ADT_Entrevistas:121])
	If (Records in table:C83([ADT_Entrevistas:121])>0)
		OBJECT SET VISIBLE:C603(*;"elimina@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"config@";False:C215)
	Else 
		OBJECT SET VISIBLE:C603(*;"elimina@";False:C215)
		OBJECT SET ENTERABLE:C238(*;"config@";True:C214)
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		SET WINDOW RECT:C444($left;$top;$right;$bottom-70)
	End if 
End if 