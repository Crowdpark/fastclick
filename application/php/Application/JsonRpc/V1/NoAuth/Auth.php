<?php

namespace Application\JsonRpc\V1\NoAuth
{
    class Auth extends \Processus\Lib\Auth\FacebookAuth
    {
        private $_isAuth = true;
        public function setAuthData($authData)
        {
            $params = $authData->getParams();
            $id = $params[0]["id"];
            if ("null" != ($id) && !is_null($id))
                $this->getApplicationContext()->getUserBo()->setFacebookUserId($id);

                return $this->_isAuth = $this->getApplicationContext()
                ->getUserBo()
                ->isAuthorized();

            return true;
        }

    }
}

?>