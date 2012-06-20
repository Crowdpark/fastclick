<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/13/12
 * Time: 4:32 PM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Mvo;
class FacebookUserMvo extends \Processus\Lib\Mvo\FacebookUserMvo
{

    /**
     * @param $score
     *
     * @return \Processus\Lib\Mvo\FacebookUserMvo
     */

    public function setHighScore($score)
    {
        $this->setValueByKey("high_score", $score);
        return $this;
    }

    /**
     * @return array|mixed
     */

    public function getHighScore()
    {
        return $this->getValueByKey('high_score');
    }

    /**
    * @param $level
    *
    * @return \Processus\Lib\Mvo\FacebookUserMvo
    */

    public function setLevel($level)
    {
        $this->setValueByKey("level", $level);
        return $this;
    }

    /**
     * @return array|mixed
     */

    public function getLevel()
    {
        return $this->getValueByKey('level');
    }

    /**
     * @param array $scores
     * @return FacebookUserMvo
     */
    public function setScores(array $scores)
    {
        $this->setValueByKey("scores", $scores);
        return $this;
    }

    /**
     * @return array|mixed
     */
    public function getScores()
    {
        return $this->getValueByKey('scores');
    }

    /**
     * @return array|bool|mixed
     */
    public function isFirstTime()
    {
        if (is_null(parent::isFirstTime()))
            return TRUE;
        else
            return FALSE;
    }
}