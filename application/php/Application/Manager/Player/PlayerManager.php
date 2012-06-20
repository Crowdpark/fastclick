<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/8/12
 * Time: 9:31 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Manager\Player;

class PlayerManager extends \Processus\Abstracts\Manager\AbstractManager
{
    /**
     * @param $score
     * @return \Application\Mvo\PlayerDataMvo
     */
    public function setScore($score)
    {

        $scoresMvo = $this->getApplicationContext()->getPlayerDataMvo();
        $scoresMvo->addScore($score);
        $scoresMvo->saveInMem();

        return $scoresMvo;
    }

    /**
     * @param $level
     * @return \Application\Mvo\PlayerDataMvo
     */
    public function setLevel($level)
    {
        $scoresMvo = $this->getApplicationContext()->getPlayerDataMvo();
        $scoresMvo->setLevel($level)->saveInMem();

        return $scoresMvo;
    }

    /**
     * @param array $friendsRawList
     * @return array
     */
    public function getAppFriends(array $friendsRawList)
    {
        $return = array();
        $return['user']["high_score"] = $this->getApplicationContext()->getPlayerDataMvo()->getHighScore();
        $return['user']["level"] = $this->getApplicationContext()->getPlayerDataMvo()->getLevel();

        $appFriendData = $this->getApplicationContext()->getUserBo()->getAppFriends($friendsRawList);

        $friends = $appFriendData["userMvos"];
        $playerData = $appFriendData["playerDataMvos"];

        $appFriends = array();

        foreach ($friends as $friendMvo) {

            $friendObject = json_decode($friendMvo);
            $id = $friendObject->id;

            foreach ($friendsRawList as $friend) {
                if ($id === $friend["id"]) {
                    $data = get_object_vars(json_decode($playerData["PlayerData_" . $id]));

                    $friend["type"] = "appfriend";
                    $friend["high_score"] = $data["high_score"];
                    $friend["level"] = $data["level"];

                    $appFriends[] = $friend;
                }
            }
        }
        $return["friends"] = $appFriends;

        return $return;
    }

}