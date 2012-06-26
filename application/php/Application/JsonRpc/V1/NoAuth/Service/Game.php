<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 9:27 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\JsonRpc\V1\NoAuth\Service;
class Game extends \Application\Core\Abstracts\AbstractService
{

    public function sendGift(array $params)
    {

        $manager = new \Application\Manager\Game\GameManager();
        return $manager->sendGift($params);
    }

    public function acceptGift(array $params)
    {
        $manager = new \Application\Manager\Game\GameManager();
        return $manager->acceptGift($params);
    }

}
