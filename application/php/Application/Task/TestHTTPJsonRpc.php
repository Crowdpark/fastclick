<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/6/12
 * Time: 11:58 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Task;
class TestHTTPJsonRpc extends \Processus\Abstracts\AbstractTask
{

    public function run()
    {
        //$this->_dumpRequestData("NoAuth.Testing.getAllData");
        //$this->_dumpRequestData("NoAuth.Testing.testDb", array(array("value" => "[" . time() . "]" . "Rockstar!")));
        //$this->_dumpRequestData("NoAuth.Testing.getCircleConfig");
        //$this->_dumpRequestData("NoAuth.Player.updateExperience", array(array("experience" => "12122")));
        //$this->_dumpRequestData("NoAuth.Game.getCircleConfig");
        //$this->_dumpRequestData("NoAuth.Player.saveGame", array(array("user_id" => 7777777,"score" => 20000)));
//        $this->_dumpRequestData("NoAuth.Player.getExperience");
        $this->_dumpRequestData("NoAuth.Game.getGame");

    }

    /**
     * @param string $serviceNamespace
     * @param array $params
     */

    private function _dumpRequestData(\string $serviceNamespace, array $params = array())
    {
        $client = new \Processus\Lib\JsonRpc\Client();
        $client->setGateway("http://local.fastclick/api/v1/notauth/");
        $request = new \Processus\Lib\JsonRpc\JsonRpcDataVo();
        $request->setParams($params)
            ->setMethod($serviceNamespace);
        var_dump($client->sendRpc($request));
    }

    /**
     * @return string
     */
    protected function _getLogTable()
    {
        // TODO: Implement _getLogTable() method.
    }

    /**
     * @param $rawObject
     * @return array
     */
    protected function _getSqlLogParams($rawObject)
    {
        // TODO: Implement _getSqlLogParams() method.
    }
}
