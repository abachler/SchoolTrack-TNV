//%attributes = {}
  //KRL_SetClientIPVariables

  //  ` 
  //Case of 
  //: (Application type=4D Server )
  //GET REGISTERED CLIENTS($aClients;$methods)
  //For ($i;1;Size of array($aClients))
  //For ($iParameters;1;Count parameters)
  //EXECUTE ON CLIENT($aClients;"KRL_UpdateIPVariable";${$iParameters};${$iParameters+1})
  //End for 
  //End for 
  //
  //: (Application type=4D Client )
