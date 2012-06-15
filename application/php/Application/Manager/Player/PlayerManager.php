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
     * @return \Application\Mvo\FacebookUserMvo|\Processus\Lib\Mvo\FacebookUserMvo
     */
    public function setScore($score)
    {
        $mvo = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo();

        if (is_null($score))
            $score = $mvo->getHighScore();

        $scores = $mvo->getScores();

        $timestamp = time();
        $scores->$timestamp = $score;
        $mvo->setScores($scores);

        if ($mvo->getHighScore() < $score || is_null($mvo->getHighScore())) {
            $mvo->setHighScore($score);
        }

        return $mvo;
    }

    /**
     * @param $level
     * @return \Application\Mvo\FacebookUserMvo|\Processus\Lib\Mvo\FacebookUserMvo
     */
    public function setLevel($level)
    {
        $mvo = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo();

        if (is_null($level))
            $level = $mvo->getLevel();

        $mvo->setLevel($level);
        return $mvo;
    }

    /**
     * @param array $friendsRawList
     * @return array
     */
    public function getAppFriends(array $friendsRawList)
    {
        $return = array();
        $return['user']["high_score"] = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo()->getHighScore();
        $return['user']["level"] = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo()->getLevel();

        $friends = $this->getApplicationContext()->getUserBo()->getAppFriends();

        $friendsListSize = sizeof($friendsRawList);

        foreach($friends as $friendMvo) {
            $friendObject = json_decode($friendMvo->getData());
            $key = $friendObject->id;

            for($i = 0; $i < $friendsListSize; $i++) {
                if ($key == $friendsRawList[$i]["id"]){
                    $friendsRawList[$i]["type"] = "appfriend";
                    $friendsRawList[$i]["high_score"] = $friendObject->high_score;
                    $friendsRawList[$i]["level"] = $friendObject->level;
                }
                else
                    $friendsRawList[$i]["type"] = "friend";
            }
        }

        $return["friends"] = $friendsRawList;
        return $return;
    }

}