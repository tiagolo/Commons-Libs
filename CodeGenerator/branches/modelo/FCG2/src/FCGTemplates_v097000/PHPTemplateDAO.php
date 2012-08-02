<?php

class *CLASS*DAO {
	
	private $table = "*SQLTABLE*";
	
	public function *CLASS*DAO()
	{
		//require_once "header.php";
		
		// credentials must be defined in the header.php file
		//mysql_connect($host, $user, $password);
		//mysql_select_db($db) ;	
		
		
	}
	
	private function mapRecordSet($recordset){
	
		$list=array();
		
		while($data=mysql_fetch_array($recordset)){
			$vo = new *CLASS*VO();
			$vo->mapObject($data);
			array_push($list, $vo);
		}
		
		return $list ;
	
	}	

	public function getAll()
	{
		$rs = mysql_query("SELECT * FROM ".$this->table);	
		return $this->mapRecordSet($rs);		
	}


	public function getOne($id)
	{
		$rs = mysql_query("SELECT * FROM ".$this->table." WHERE *PRIMARYKEYFIELD* = ".$id);
		$list = $this->mapRecordSet($rs);
		return $list[0];		
	}



	public function create($obj)
	{
	
		$requete = "INSERT INTO ".$this->table."
		
		( 
*FIELDSINSERT*
		)
		
		VALUES
		
		(
*VALUESINSERT*		
		)";

		if(!mysql_query($requete)) {
			trigger_error("Unable to create *CLASS*", E_USER_ERROR);
			return;
		}
				
		return $this->getOne( mysql_insert_id() );
				
	}

	public function update($obj)
	{
		
		$id = *ACCESSPRIMARYKEYFIELD*;

		$requete = "UPDATE ".$this->table." SET 
*FIELDSUPDATES*
		WHERE *PRIMARYKEYFIELD* =". $id;
	
		if(!mysql_query($requete)){
			trigger_error("Unable to update *CLASS*", E_USER_ERROR);
			return ;		
		}
				
		return $this->getOne($id);
		
	}

	public function delete($id)
	{
		$resultat = mysql_query("DELETE FROM ".$this->table." WHERE *PRIMARYKEYFIELD* = ".$id);
		
		if(!$resultat){
			trigger_error("Unable to delete *CLASS*", E_USER_ERROR);
			return;
		}
		else return true ;						
		
	}

*ADD_METHODS*}?>