<?php

namespace Application\JsonRpc\V1\NoAuth
{
    class Auth extends \Processus\Lib\Auth\FacebookAuth
    {
        private $_isAuth = true;
        public function setAuthData($authData)
        {
            $params = $authData->getParams();

            if (!is_null($params[0]["id"]))
                $this->getApplicationContext()->getUserBo()->setFacebookUserId($params[0]["id"]);

                return $this->_isAuth = $this->getApplicationContext()
                ->getUserBo()
                ->isAuthorized();

            return true;
        }

    }
}

?>