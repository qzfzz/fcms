<?php

namespace apps\cms\controllers;

!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Model\Validator\Regex as RegexValidator;

/**
 * 检索查询
 * @author Carey
 * @date 2015/10/27
 */
class SearchController extends Controller
{

    /**
     * @author( author='Carey' )
     * @date( date = '2015.10.27' )
     * @comment( comment = '检索查询首页' )
     * @method( method = 'indexAction' )
     * @op( op = 'r' )
     */
    public function indexAction()
    {
        //检查全文搜索的配置
        $status = false;
        $msg = '请为title, description, content 字段<br>&#12288; 统一建全文索引，且索引名为 search';
        $index = $this->db->describeIndexes( 'fcms_articles' );
        if( isset( $index[ 'search' ] ) )
        {
            $columns = $index[ 'search' ]->getColumns();
            if( !empty( $columns ) )
            {
                $fields = array_diff( [ 'title', 'description', 'content' ], $columns );
                if( !empty( $fields ) )
                {
                    $msg .= ',<br>&#12288; 其中缺少' . implode( ' ', $fields );
                }
                else
                {
                    $status = true;
                }
            }
        }

        if( !$status )
        {
            $this->dispatcher->forward( [ 'controller' => 'error', 'action' => 'error', 'params' => [ 'msg' => $msg ] ] );
        }
        else //全文搜索配置正常
        {
            $sKey = $this->dispatcher->getParam( 'key', 'string' );
            preg_match( '/[-;=*]/', $sKey, $match ); //过滤特殊字符
            if( false == $sKey || $match)
            {
                $this->response->redirect( '/' );
                return false;
            }
            $pageNum = $this->dispatcher->getParam( 'page', 'int' );
            $currentPage = $pageNum ? $pageNum : 1;

            $this->view->setVar( 'curPage', $currentPage );
            $this->view->setVar( 'key', $sKey );
            $this->view->pick( 'default/search' );
        }
    }

}

?>