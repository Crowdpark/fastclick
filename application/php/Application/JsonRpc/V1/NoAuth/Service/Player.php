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
     * @return mixed
     */
    public function getAppFriends(array $params)
    {
        $manager = new \Application\Manager\Player\PlayerManager();
        $manager->setFriendsList($this->getProcessusContext()->getFacebookClient()->getFriendsIdList());
        $mvo = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo();
        if (!is_null($params["currentLevel"])) {
            $mvo->setLevel($params["currentLevel"]);
            if ($mvo->getHighScore() < $params["currentScore"] OR is_null($mvo->getHighScore())) {
                $mvo->setHighScore($params["currentScore"]);
            }
            $mvo->saveInMem();
        }
        $friendArray = array();
        $friends = $this->getApplicationContext()->getUserBo()->getAppFriends();

        foreach ($friends as $friendMvo) {
            $friendArray[] = $friendMvo->getData();
        }
        return $friendArray;
    }

    public function setFriendsList(array $params)
    {


    }

    /**
     * @param array $params
     * @return string
     */
    public function saveGame(array $params)
    {
        $manager = new \Application\Manager\Player\PlayerManager();
        var_dump($this->getApplicationContext()->getUserBo()->getFacebookHighScore());
//        var_dump($params["currentScore"]);
        $manager->setFriendsList($this->getProcessusContext()->getFacebookClient()->getFriendsIdList());


        return true;
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
