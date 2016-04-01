<?php

/**
 * @comment Admin基类
 * @author fzq
 * @date 2015-1-20
 * @comment 基类不采用统一注释格式
 */
namespace apps\admin\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use apps\admin\models\PriUsers;
use enums\SystemEnums;
use Phalcon\Mvc\Controller;

class AdminBaseController extends Controller
{
    use \apps\admin\libraries\AdminAcl;
    protected $userId = 0;
    protected $shopId = 0;
    
    protected function initialize()
	{
		 // 判断是否登录 - session
        $userInfo = $this->session->get( 'userInfo' );
        if( empty( $userInfo ) )
        {
            if( ! $this->request->isAjax() )
            {
                exit( '<script>parent.window.location="/admin/login/index";</script>' );
            }
            else
           {
                $this->error( '超时登录，请重新登录' );
            }
        }
        else
       {
            $this->userId = intval( $userInfo[ 'id' ] );
            $this->shopId = intval( $userInfo[ 'shopid' ] );
            
            //判断数据库是否存在user，不存在则返回登录页面
            $where = array(
                'id=?0',
                'bind' => [ $this->userId ],
            );
            $loginInfo = PriUsers::findFirst( $where );
            if( !$loginInfo )
            {
                $this->response->redirect( "admin/login/index" );
            }
            
            if( $userInfo[ 'groupid' ] == SystemEnums::SUPER_ADMIN_ID ) //超级管理员不参加角色
            {
                return true;
            }
            
            $aclList = 'aclList' . $userInfo[ 'groupid' ];
            $acl =  $this->safeCache->get( $aclList );   
            if( !$acl ) //没有的话从文件里读取
            {
                $acl = unserialize( $this->fCache->get( $aclList ) );
                $this->safeCache->save( $aclList, $acl );
            }
            if( $acl )
            {
                $controller = $this->router->getControllerName();
                $action = strtolower( $this->router->getActionName() );
                if(  $acl->isAllowed( 'group' . $userInfo[ 'groupid' ], $controller, $action ) )
                {
                   return true;
                }
            }
            $this->output( '您没有权限访问' );
        }
	}
    
   
    
    /**
     * csrf 检验
     * return bool
     */
    protected function csrfCheck()
    {
        
        $key = $this->request->getPost( 'key' );
        $token = $this->request->getPost( 'token' );
        
        if( ( $key && $token && $this->security->checkToken( $key, $token ) ) || $this->security->checkToken() )
        {
            return true;
        }
        else
        {
            $this->error( 'csrf校验不正确' );
            exit;
        }
        
    }
    
    /**
     * 验证一下是否是自己
     */
    protected function checkSelf( $userId =0 )
    {
        if( $this->userId != $userId && $this->userId != SystemEnums::SUPER_ADMIN_ID ) //只能编辑自己
        {
            $this->ouput( '你没有权限使用其他用户的账号' );
        }
    }
    
    /**
    * 验证一下是否是自己的商铺
    */
    protected function checkShop( $shopId = 0 )
    {
        if( $this->shopId != $shopId && $this->userId != SystemEnums::SUPER_ADMIN_ID ) //只能编辑自己
        {
           $this->ouput( '你没有权限访问该商铺' );
        }
    }
    
    /**
     * 消息输出
     * param string $msg
     */
    protected function output( $msg )
    {
        if( $this->request->isAjax() )
        {
            $this->error( $msg );
        }
        else
        {
            $this->dispatcher->forward( [  'controller' => 'error', 'action' => 'error', 'params' => [ 'msg' => $msg ] ]);
        }
    }
    /**
     * 消息的输出
     * param int $status 状态 0：代表成功，1：代表失败，2:代表其
     * param string $msg 消息内容
     * param array $data 其他自定义数据
     */
    protected function message( $status = 0, $msg = '', $data = array() )
    {
        if( $this->request->isPost() ) //post请求才进行csrf
        {
            $ret[ 'key' ] = $this->security->getTokenKey();
            $ret[ 'token' ] = $this->security->getToken();
        }
    
        $ret[ 'status' ] = $status;
        $ret[ 'msg' ] = $msg;
        $ret = array_merge( $ret, $data );
        echo json_encode( $ret );
        exit;
    }
    
    /**
     *成功消息返回 
     * param string $msg
     * param array $data 其他自定义数据
     */
    protected function success( $msg = '', $data = array() )
    {
        $this->message( 0, $msg, $data );
    }
    
     /**
     * 错误消息返回 
     * param string $msg
     * param array $data 其他自定义数据
     */
    public function error( $msg = '', $data = array() )
    {
        $this->message( 1, $msg, $data );
    }
    
      
    /**
     * 显示404错误页面
     */
    public function show404( $msg = '' )
    {
        $referer = '';
        if( ! empty( $_SERVER[ 'HTTP_REFERER']))
        {
            $referer = str_replace( '/', '$', $_SERVER[ 'HTTP_REFERER' ] );
        }
        
        $this->response->redirect( '/admin/index/show404/msg/' . $msg . '/referer/'. $referer );
    }
}

?>