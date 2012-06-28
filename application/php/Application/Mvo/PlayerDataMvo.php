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
     * @param int $level
     * @return PlayerDataMvo|\Processus\Abstracts\Vo\AbstractVO
     */

    public function addScore(\int $score, \int $level)
    {

        $allScores = get_object_vars($this->getScores());
        $scores = get_object_vars($allScores[$level]);

        if ($score === 0)
            return $this;

        $lowestScore = min($scores);

        if ((sizeof($scores)) > 9) {

            if ($lowestScore >= $score)
                return $this;

            $minimumKeys = array_keys($scores, $lowestScore);
            unset($scores[$minimumKeys[0]]);
        }

        $scoreArray = array(time() => $score);
        (is_null($scores)) ? $scores = $scoreArray : $scores[] = $score;
        $allScores[$level] = $scores;

        return $this->setScores($allScores);
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
    public function setHighScore(\int $score, \int $level)
    {
        return $this->setValueByKey("high_score", array("score" => $score, "level" => $level));
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
