<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/6/12
 * Time: 11:51 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\JsonRpc\V1\NoAuth\Service;
class Testing extends \Processus\Abstracts\JsonRpc\AbstractJsonRpcService
{
    public function testApi()
    {
        return "Hello World";
    }

    public function testDbUpdateRow(\string $id, array $params)
    {
        $manager = new \Application\Manager\TestDb();
        return $manager->updateRowInDb($id, $params);
    }

    public function testDb(array $params)
    {
        $manager = new \Application\Manager\TestDb();
        return $manager->storeDataInDatabase($params);
    }

    public function getAllData()
    {
        $manager = new \Application\Manager\TestDb();
        return $manager->getStoredData();
    }

    public function getUserData($userId)
    {
        $manager = new \Application\Manager\TestDb();
        return $manager->getDataFromTable("helloworld",
                                            array("value"),
                                            array("id" => $userId));
    }

    public function getCircleConfig(array $params = NULL)
    {
        $manager = new \Application\Manager\TestDb();
        return $manager->getDataFromTable("circles",
                                            array("color", "score"),
                                            $params);
    }

}
