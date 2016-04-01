<?php
namespace apps\cms\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

class ErrorController extends \Phalcon\Mvc\Controller
{
    public function err404Action()
    {
        echo '<br>Sorry! We cann\'t find this page!<br>';
    }
    public function errorAction()
    {
        $data = $this->dispatcher->getParams();
        $this->view->data = $data;
    }
}

?>