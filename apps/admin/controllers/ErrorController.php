<?php
namespace apps\admin\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

class ErrorController extends \Phalcon\Mvc\Controller
{
    public function err404Action()
    {
        //echo '<br>Sorry! We cann\'t find this page!<br>';
        $this->view->pick( 'index/404' );
    }
    
    /**
     * 错误显示
     */
    public function errorAction( )
    {
        $data = $this->dispatcher->getParams();
        $this->view->data = $data;
    }
}

?>