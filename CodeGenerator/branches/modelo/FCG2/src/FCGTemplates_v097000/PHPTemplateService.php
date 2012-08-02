<?php
*IMPORTS*

class *SERVICENAME* {
	
*PROPDECLAR*	
		
	public function *SERVICENAME*()
	{
		require_once "header.php";
		
		// credentials must be defined in the header.php file
		mysql_connect($host, $user, $password);
		mysql_select_db($db) ;	

*PROPINIT*	
		
		
	}
	
*METHODS*	
}?>