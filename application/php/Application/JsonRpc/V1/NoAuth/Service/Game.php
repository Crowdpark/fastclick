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

    public function getCircleConfig()
    {
        $manager = new \Application\Manager\Game\GameManager();
        return $manager->getCircleConfig();
    }

    public function getGameDuration()
    {
        $manager = new \Application\Manager\Game\GameManager();
        return $manager->getGameDuration();
    }

}
