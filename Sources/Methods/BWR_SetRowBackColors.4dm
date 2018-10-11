//%attributes = {}
  //BWR_SetRowBackColors

  //For ($i;1;Size of array(alBWR_recordNumber))
  //If (Dec($i/2)=0)
  //AL_SetRowColor (x_alBrowser;$i;"";0;"";15*16+2)
  //Else 
  //AL_SetRowColor (x_alBrowser;$i;"";0;"";1)
  //End if 
  //End for 

ALP_SetAlternateLigneColor (xALP_Browser)