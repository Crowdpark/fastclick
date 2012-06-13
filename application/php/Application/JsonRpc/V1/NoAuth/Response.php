<?php

namespace Application\JsonRpc\V1\NoAuth
{
    class Response extends \Processus\Abstracts\JsonRpc\AbstractJsonRpcResponse
    {

        protected function _isDeveloper()
        {
            return false;
        }
    }
}

?>