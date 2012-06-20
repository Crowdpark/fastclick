<?php

namespace Application\JsonRpc\V1\NoAuth
{
    class Auth extends \Processus\Lib\Auth\FacebookAuth
    {
        private $_isAuth = true;
        public function setAuthData($authData)
        {

                return $this->_isAuth = $this->getApplicationContext()
                ->getUserBo()
                ->isAuthorized();

            return true;
        }

    }
}

?>