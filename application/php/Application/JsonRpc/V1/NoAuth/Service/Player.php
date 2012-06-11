<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 9:22 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\JsonRpc\V1\NoAuth\Service;
class Player extends \Processus\Abstracts\JsonRpc\AbstractJsonRpcService
{

    public function saveGame(array $params)
    {
        $manager = new \Application\Manager\Player\PlayerManager();
        return $manager->saveGame($params);
    }

    public function updateExperience(array $experience)
    {
        $manager = new \Application\Manager\Player\PlayerManager();
        return $manager->updateExperience($experience);

    }

    public function getExperience()
    {
        $manager = new \Application\Manager\Player\PlayerManager();
        return $manager->getExperience();
    }

}
