<?php
/**
 * Created by JetBrains PhpStorm.
 * User: rinomontiel
 * Date: 6/7/12
 * Time: 3:04 PM
 * To change this template use File | Settings | File Templates.
 */
class UserVo extends \Processus\Abstracts\Vo\AbstractVO
{

    /**
     * @param int $id
     * @return UserVo
     */
    public function setId(\int $id)
    {
        $this->setValueByKey("id", $id);
        return $this;
    }

    /**
     * @return array|mixed
     */

    public function getFacebookId()
    {
        return $this->getValueByKey("fb_id");
    }

    /**
     * @param $facebookId
     * @return UserVo
     */

    public function setFacebookId($facebookId)
    {
        $this->setValueByKey("fb_id", $facebookId);
        return $this;
    }

    /**
     * @return array|mixed
     */

    public function getExperience()
    {
        return $this->getValueByKey("experience");
    }

    /**
     * @param $experience
     */

    public function setExperience($experience)
    {
        $this->setValueByKey("experience", $experience);
    }



}