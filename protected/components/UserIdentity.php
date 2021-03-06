<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{
	/**
	 * Authenticates a user.
	 * The example implementation makes sure if the username and password
	 * are both 'demo'.
	 * In practical applications, this should be changed to authenticate
	 * against some persistent user identity storage (e.g. database).
	 * @return boolean whether authentication succeeds.
	 */
	private $_id;
		

		
	public function authenticate()
	{
		//Busco en la tabla Usuario un solo registro..
		$nick = strtolower($this->username);
		$user=Usuarios::model()->find('LOWER(nick)=?',array($nick));

		if($user===null)
			$this->errorCode=self::ERROR_USERNAME_INVALID;
		#elseif($this->password!==$user->pass)
		#elseif(sha1($this->password)!==$user->pass)
		elseif(sha1($this->password)!==$user->pass)
		#elseif(md5($this->password)!==$user->pass)
		#elseif(!$this->validatePassword($user->pass))
		#elseif(!$user->validatePassword($this->password))
			$this->errorCode=self::ERROR_PASSWORD_INVALID;
		else
		{
			$this->_id=$user->id;
			//$this->_id_rol=$user->id_rol;
			//$this->setState('email',$user->email);
			$this->setState('id',$user->id);
            $this->setState('foto',$user->foto);
			//$this->setState('rol',$user->id_rol);

			$this->errorCode=self::ERROR_NONE;

		}
		return !$this->errorCode;

	}

	
	public function getId()
	{
		return $this->_id;
	}

	public function imp($dato,$id){
		echo "<script>console.log( '". $id . $dato . "' );</script>";
	}
}