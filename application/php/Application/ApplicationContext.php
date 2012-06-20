<?php
/**
 * Created by JetBrains PhpStorm.
 * User: francis
 * Date: 11/16/11
 * Time: 1:35 AM
 * To change this template use File | Settings | File Templates.
 */
namespace Application
{
    class ApplicationContext extends \Processus\ProcessusContext
    {

        /**
         * @var \Application\ApplicationContext
         */
        private static $_instance;

        /**
         * @var \Application\Vo\SendGrid\SendGridConfig
         */
        private $_sendGridConfig;

        /**
         * @var \Application\Mvo\AppUserMvo
         */
        private $_userAppMvo;
        /**
         * @var
         */
        private $_userBo;

        /**
         * @static
         * @return ApplicationContext
         */
        public static function getInstance()
        {
            if (!self::$_instance) {
                self::$_instance = new ApplicationContext();
            }

            return self::$_instance;
        }

        /**
         * @return Vo\SendGrid\SendGridConfig
         */
        public function getSendgridConfig()
        {
            if (!$this->_sendGridConfig) {
                $this->_sendGridConfig = new \Application\Vo\SendGrid\SendGridConfig();
                $this->_sendGridConfig->setData($this->getRegistry()->getConfig('SendGrid'));
            }
            return $this->_sendGridConfig;
        }



        /**
         * @return \Application\Bo\UserBo
         */
        public function getUserBo()
        {
            if (!$this->_userBo) {
                $this->setUserBo(new \Application\Bo\UserBo());
            }
            return $this->_userBo;
        }

        /**
         * @param UserBo $userBo
         * @return \Processus\ProcessusContext|void
         */

        public function setUserBo($userBo)
        {
            $this->_userBo = $userBo;
        }

        private $_facebookClient;

        public function getFacebookClient()
        {
            if (!$this->_facebookClient) {
                $this->_facebookClient = new \Application\Lib\Facebook\FacebookClient();
            }
            return $this->_facebookClient;
        }
        /**
         * @var \Application\Mvo\UserScoreMvo
         */
        private $_playerDataMvo;

        /**
         * @return Mvo\PlayerDataMvo
         */
        public function getPlayerDataMvo()
        {
            if (!$this->_playerDataMvo) {
                $this->_playerDataMvo = new \Application\Mvo\PlayerDataMvo();
                $this->_playerDataMvo->setMemId('PlayerData_' . $this->getUserBo()->getFacebookUserId());
                $this->_playerDataMvo->getFromMem();
            }

            return $this->_playerDataMvo;
        }

    }
}