<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 9:22 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\JsonRpc\V1\NoAuth\Service;
class Player extends \Application\Core\Abstracts\AbstractService
{

    /**
     * @param array $params
     * @return array
     */
    public function getAppFriends(array $params)
    {
        $manager = new \Application\Manager\Player\PlayerManager();
//        $paramsIdList = array_map(array($this, "_getFriendId"), $params["friendsList"]);

        return $manager->getAppFriends($params["friendsList"]);

    }

    /**
     * @param array $params
     * @return int
     */
    public function updateUser(array $params)
    {

        $manager = new \Application\Manager\Player\PlayerManager();

//        $paramsIdList = array_map(array($this, "_getFriendId"), $params["friendsList"]);

        $manager->setLevel($params["currentLevel"]);
        $mvo = $manager->setScore($params["currentScore"]);
        $mvo->saveInMem();
        return $mvo->getHighScore();
    }

    /**
     * @param $element
     * @return mixed
     */
    private function _getFriendId($element)
    {
        return $element["id"];
    }

}
