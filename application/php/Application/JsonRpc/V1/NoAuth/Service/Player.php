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

        $paramsIdList = array_map(array($this, "_getFriendId"), $params["friendsList"]);

        $manager->setLevel($params["currentLevel"]);
        $manager->setScore($params["currentScore"])->saveInMem();

        $return = array();
        $return['user']["high_score"] = $this->
            getApplicationContext()->
            getUserBo()->
            getFacebookUserMvo()->
            getHighScore();

        $return['user']["level"] = $this->
            getApplicationContext()->
            getUserBo()->
            getFacebookUserMvo()->
            getLevel();

        $friends = $this->getApplicationContext()->getUserBo()->getAppFriends();

        foreach ($friends as $friendMvo) {
            $return['appfriends'][] = $friendMvo->getData();
        }

        return $return;
    }

    /**
     * @param array $params
     * @return int
     */
    public function updateUser(array $params)
    {

        $manager = new \Application\Manager\Player\PlayerManager();

        $paramsIdList = array_map(array($this, "_getFriendId"), $params["friendsList"]);

        $manager->setLevel($params["currentLevel"]);
        return $manager->setScore($params["currentScore"])->saveInMem();

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
