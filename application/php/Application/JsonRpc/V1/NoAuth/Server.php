<?php

namespace Application\JsonRpc\V1\NoAuth
{
    class Server extends \Processus\Abstracts\JsonRpc\AbstractJsonRpcServer
    {
        protected $_config = array(
            'namespace'    => __NAMESPACE__,
            'validClasses' => array(
                'Testing',
                'Player',
                'Game'
            )
        );
    }
}

?>