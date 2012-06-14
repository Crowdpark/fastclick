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

    public function __call($method, $args)
    {
        if (method_exists($this, $method)) {
            return $this->$method($args);
        } else {
            throw new \Exception("PlayerManager doesn't have a function called $method");
        }
    }

    /**
     * @param $score
     * @return \Application\Mvo\FacebookUserMvo|\Processus\Lib\Mvo\FacebookUserMvo
     */
    public function setScore($score)
    {
        $mvo = $this->getApplicationContext()->getUserBo()->getFacebookUserMvo();

        if (is_null($score))
            $score = $mvo->getHighScore();

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
     * @return array
     */
    public function getAppFriends()
    {
        $friends = $this->getApplicationContext()->getUserBo()->getAppFriends();
        return $friends;
    }

}
