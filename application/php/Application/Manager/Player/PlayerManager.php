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
     * @param $level
     * @return \Application\Mvo\PlayerDataMvo
     */
    public function setScore($score, $level)
    {
        $scoresMvo = $this->getApplicationContext()->getPlayerDataMvo();
        $scoresMvo->addScore($score, $level);
        $this->_setHighScore($score, $level);

        return $scoresMvo;
    }

    /**
     * @param $level
     * @return \Application\Mvo\PlayerDataMvo
     */
    public function setLevel($level)
    {
        $scoresMvo = $this->getApplicationContext()->getPlayerDataMvo();

        if ($scoresMvo->getLevel() < $level)
            $scoresMvo->setHighScore(0, $level);

        $scoresMvo->setLevel($level);

        return $scoresMvo;
    }

    /**
     * @param array $friendsRawList
     * @return array
     */
    public function getAppFriends(array $friendsRawList)
    {
        $return = array();
        $highscore = $this->getApplicationContext()->getPlayerDataMvo()->getHighScore();

        if (!is_array($highscore))
            $highscore = get_object_vars($highscore);

        $return['user']["high_score"] = $highscore["score"];
        $return['user']["level"] = $this->getApplicationContext()->getPlayerDataMvo()->getLevel();
        $appFriendData = $this->getApplicationContext()->getUserBo()->getAppFriends($friendsRawList);
        $return["friends"] = $this->_filterAppFriends($friendsRawList, $appFriendData["userMvos"], $appFriendData["playerDataMvos"]);

        return $return;
    }

    /**
     * @param array $ids
     * @return array
     */
    public function getHighscores(array $ids)
    {
        $connector = $this->getApplicationContext()->getDefaultCache();

        $withPrefixes = $this->_array_prefixing("PlayerData_", $ids["app_friends"]);

        $data = $connector->getMultipleByKey($withPrefixes);

        $return = array();

        foreach ($data as $id => $playerData) {
            $elements = get_object_vars(json_decode($playerData));
            $return[str_replace("PlayerData_", "", $id)] = $elements["high_score"];
        }

        return $return;
    }

    /**
     * @param array $friendsRawList
     * @param array $mvoRawData
     * @param array $playerData
     * @return array
     */
    private function _filterAppFriends(array $friendsRawList, array $mvoRawData, array $playerData)
    {
        $appFriends = array();

        foreach ($mvoRawData as $friendMvo) {

            $friendObject = json_decode($friendMvo);
            $id = $friendObject->id;

            foreach ($friendsRawList as $friend) {
                if ($id === $friend["id"]) {
                    $data = get_object_vars(json_decode($playerData["PlayerData_" . $id]));

                    $friend["type"] = "appfriend";
                    $friend["high_score"] = $data["high_score"]->score;
                    $friend["level"] = $data["level"];

                    $appFriends[] = $friend;
                    break;
                }
            }
        }

        return $appFriends;
    }
    /**
     * @param string $prefix
     * @param array $idList
     * @return array
     */
    private function _array_prefixing(string $prefix, array $idList)
    {
        $prefixList = array();

        foreach ($idList as $idItem) {
            $prefixList[] = $prefix . $idItem;
        }

        return $prefixList;
    }
    /**
     * Evaluates and sets the high score if it's the highest.
     * @param int $score
     */
    private function _setHighScore(\int $score, \int $level)
    {
        $mvo = $this->getApplicationContext()->getPlayerDataMvo();
        $highscore = $mvo->getHighScore();

        if (is_null($mvo) || $level > $highscore->level || (($score > $highscore->score) && ($level == $highscore->level)))
            $mvo->setHighScore($score, $level)->saveInMem();
    }

}