<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/6/12
 * Time: 11:53 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Task;
class TestJsonRpc extends \Processus\Abstracts\AbstractTask
{

    public function run()
    {
        $service = new \Application\JsonRpc\V1\NoAuth\Service\Testing();
        var_dump($service->testApi());
        var_dump($service->getApi());
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
