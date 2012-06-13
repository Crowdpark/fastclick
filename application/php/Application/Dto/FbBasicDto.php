<?php

namespace Application\Dto
{
    
    use Processus\Abstracts\Vo\AbstractDTO;

    class FbBasicDto extends AbstractDTO
    {
        /**
         * @see Processus\Abstracts\Vo.AbstractDTO::getMapping()
         */
        /**
         */
        protected function _getMapping()
        {
            // TODO: Implement _getMapping() method.
        }

        /**
         * @return string
         */
        protected function _getDtoCachingId()
        {
            // TODO: Implement _getDtoCachingId() method.
        }

        protected function getMapping ()
        {
            return array(
                
                "id" => "userId", 
                "name" => "fullName", 
                "locale" => "language"
            );
        }
    }
}

?>