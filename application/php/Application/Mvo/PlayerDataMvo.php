<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/19/12
 * Time: 4:02 PM
 * To change this template use File | Settings | File Templates.
 */
namespace Application\Mvo;

class PlayerDataMvo extends \Processus\Abstracts\Vo\AbstractMVO
{

    /**
     * @param int $score
     */
    public function addScore(\int $score)
    {
        $scoreArray = array(time() => $score);
        $scores = get_object_vars($this->getScores());

        (is_null($scores)) ? $scores = $scoreArray : $scores[] = $score;

        $this->setScores($scores);

    }

    /**
     * @return array|mixed
     */
    public function getScores()
    {
        return $this->getValueByKey("scores");
    }

    /**
     * @param array $scores
     * @return \Processus\Abstracts\Vo\AbstractVO
     */

    public function setScores(array $scores)
    {
        return $this->setValueByKey("scores", $scores);
    }

    /**
     * @param int $score
     * @return \Processus\Abstracts\Vo\AbstractVO
     */
    public function setHighScore(\int $score)
    {
        return $this->setValueByKey("high_score", $score);
    }

    /**
     * @return array|mixed
     */
    public function getHighScore()
    {
        return $this->getValueByKey("high_score");
    }

    /**
     * @param int $level
     * @return \Processus\Abstracts\Vo\AbstractVO
     */
    public function setLevel(\int $level)
    {
        return $this->setValueByKey("level", $level);
    }

    /**
     * @return array|mixed
     */
    public function getLevel()
    {
        return $this->getValueByKey("level");
    }

    /**
     * @param int $experience
     * @return \Processus\Abstracts\Vo\AbstractVO
     */
    public function setExperience(\int $experience)
    {
        return $this->setValueByKey("experience", $experience);
    }

    /**
     * @return array|mixed
     */
    public function getExperience()
    {
        return $this->getValueByKey("experience");
    }
}
