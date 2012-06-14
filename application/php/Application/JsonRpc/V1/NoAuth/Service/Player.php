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

    private function getFriendId($element)
    {
        return $element["id"];
    }

    /**
     * @return mixed
     */
    public function getAppFriends(array $params)
    {


        $manager = new \Application\Manager\Player\PlayerManager();

        $paramsIdList = array_map(array($this, "getFriendId"), $params["friendsList"]);
        $mvo = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo();

        if (is_null($params["currentLevel"])) {
            $level = $mvo->getLevel();
            $score = $mvo->getHighScore();
        } else {
            $level = $params["currentLevel"];
            $score = $params["currentScore"];
        }
        $mvo->setLevel($level);

        if ($mvo->getHighScore() < $score OR is_null($mvo->getHighScore())) {
            $mvo->setHighScore($score);
        }
        $mvo->saveInMem();
        $friendArray = array();
        $friends = $this->getApplicationContext()->getUserBo()->getAppFriends();

        $friendArray['user']["high_score"] = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo()->getHighScore();
        $friendArray['user']["level"] = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo()->getLevel();

        foreach ($friends as $friendMvo) {
            $friendArray['appfriends'][] = $friendMvo->getData();
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
