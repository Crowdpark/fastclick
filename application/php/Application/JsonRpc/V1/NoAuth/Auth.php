<?php

namespace Application\JsonRpc\V1\NoAuth
{
    class Auth extends \Processus\Lib\Auth\FacebookAuth
    {
        private $_isAuth = TRUE;
        public function setAuthData($authData)
        {

            //var_dump($this->getProcessusContext()->getUserBo()->getFacebookUserId());
//            return TRUE;
//            return parent::setAuthData($authData);
            return $this->_isAuth = $this->getApplicationContext()
                ->getUserBo()
                ->isAuthorized();
        }

    }
}

?>