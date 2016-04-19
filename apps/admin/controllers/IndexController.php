<?php

/**
 * 系统主框架以及公共显示区域
 * @author Bruce
 * time 2014-10-30
 */
namespace apps\admin\controllers;

use enums\SystemEnums;
use apps\admin\models\SysIndeCfg;
use apps\admin\models\PriUsers;
use libraries\TimeUtils;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

class IndexController extends AdminBaseController
{
    public function initialize()
    {
        parent::initialize();
	}

    /**
     * 框架主体（首页）
     */
    public function indexAction( )
    {
        $userInfo = $this->session->get( 'userInfo' );
        $leftMenu = $this->safeCache->get( 'admin_left_menu_' . $userInfo[ 'groupid' ] . '_' . $userInfo[ 'shopid' ] );
        
        $this->view->leftMenu = $leftMenu;
        $this->view->loginName = $userInfo[ 'loginname' ];
        $this->view->nickName = $userInfo[ 'nickname' ];
        $this->view->avatar = $userInfo[ 'avatar' ];
        $this->view->uid = $userInfo[ 'id' ];
        $this->view->shopId = $userInfo[ 'shopid' ];
    }
    
    /**
     * 点击后台首页，进行的是这个操作
     */
    public function showAction()
    {
    	$userInfo = $this->session->get( 'userInfo' );
    	$groupid = $userInfo[ 'groupid' ];
    	$where = array(
    		'column'	 => 'id,delsign,sort,display,name,line,sort,icon,color,size,groupid',
    		'conditions' => 'delsign=:del: and groupid=:gid: and display=:display: ORDER BY sort DESC',
    		'bind'		 => array( 'del' => SystemEnums::DELSIGN_NO, 'gid' => $groupid, 'display' => 0 ),
    	);
    	$res = SysIndeCfg::find( $where );
    	if( false == $res || count( $res ) <= 0 )
    	{
    		$this->view->pick( 'index/cms' );
    	}
    	else
    	{
    		$this->view->shopId = $userInfo[ 'shopid' ];
    	}
    }
    
    /**
     * 获取模块信息
     */
    public function getmodalsAction()
    {
    	$objRet = new \stdClass();
    	$userInfo = $this->session->get( 'userInfo' );
    	$groupid = $userInfo[ 'groupid' ];
    	$where = array(
    			'column'	=> 'id,delsign,sort,display,name,line,sort,icon,color,size,groupid',
    			'conditions'=> 'delsign=:del: and groupid=:gid: and display=:display: ORDER BY sort DESC',
    			'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO , 'gid' => $groupid, 'display' => 0 ),
    	);
    	$res = SysIndeCfg::find( $where );
    	if( false != $res && count( $res ) > 0 )
    	{
    		$result = $res->toArray();
    		$i=0;
    		$curObj = $this;
    		foreach ( $result as $row )
    		{
    			$newCont = preg_replace_callback( '/%([a-z A-Z]+)-([a-z A-Z]+)%/', function( $matches ) use( $curObj ) {
    				return $curObj->$matches[1]->{"get". "$matches[2]"}();
    			}, $row[ 'descr' ]);
    			
    			$result[$i][ 'info' ] = $newCont;
    			$i++;
    		}
    		$objRet->state = 0;
    		$objRet->data = $result;
    	}
    	else
    	{
    		$objRet->state = 1;
    	}
    	
    	
    	echo json_encode( $objRet );
    }
    

    
    /**
    * 错误显示
    */
    public function show404Action( )
    {
        $data = $this->dispatcher->getParams();
        if(  ! empty( $data )  )
        {
            if( !empty( $data['referer'] ) )
            {
                $data['referer'] = str_replace( '$', '/', $data['referer'] );
            }
            $this->view->data = $data;
        }
        
        $this->view->pick( '/index/404' );
    }
        
    /**
     * 框架首页内容（示例）
     */
    public function fcmsHomeAction()
    {
        
    }
    
    /**
     ************** 示例页面 ***************** 
     * 示例列表
     */
    public function demoAction()
    {
        $this->view->pick( '/index/demo/list' );
    }
    
    /**
     * 显示添加示例页面
     */
    public function showAddDemoAction()
    {
        $this->view->pick( '/index/demo/add' );
    }
    
    
    /**
     * 个人资料页面
     */
    public function userInfoAction()
    {
        $userInfo = $this->session->get( 'userInfo' );
        $this->view->userInfo = $userInfo;
    }
    
    /**
     * 个人资料修改处理
     */
    public function changeUserInfoAction()
    {
        //获取ajax传递过来的值
        if( $this->request->getPost() )
        {
            $name = $this->request->getPost( 'name', 'string' );
            $nickName = $this->request->getPost( 'nickname', 'string' );
            $email = $this->request->getPost( 'email', 'email' );
        }
        else
       {
            //用户信息发送失败，请重试
            $res[ 'state' ] = 4;
        }
    	
        
        if( $this->session->get( 'userInfo' ) )
        {
            $userInfoArr = $this->session->get( 'userInfo' );
            $where = array(
                'id = ?0',
                'bind' => [ $userInfoArr[ 'id' ] ]
            );
            //判空
            if( $userInfo = PriUsers::findFirst( $where ) )
            {
                //更新数据库数据
                $userInfo->name = $name;
                $userInfo->nickname = $nickName;
                $userInfo->email = $email;
                //0:数据更新成功;1:数据更新失败
                $res[ 'state' ] = $userInfo->save()?0:1;
                
                //更新session中的信息数据
                $userInfoArr[ 'name' ] = $name;
                $userInfoArr[ 'nickname' ] = $nickName;
                $userInfoArr[ 'email' ] = $email;
                $this->session->set( 'userInfo', $userInfoArr );
            }
            else
           {
               //数据库中用户信息不存在
               $res[ 'state' ] = 2;
            }
        }
        else
       {
           //登录用户信息不存在，请退出后重新登录'
           $res[ 'state' ] = 3;
        }
        echo json_encode( $res );
    	
    }
    
    /**
     * 修改密码
     */
    public function changePswAction()
    {
    	$this->csrfCheck();
    	
    	if( $userId = $this->request->getPost( 'userId' ) )
    	{
    	    $this->checkSelf( $userId );
    	}
    	
        if( $this->request->getPost() )
        {
            $oldPassword = $this->request->getPost( 'oldPassword' );
            $newPassword = $this->request->getPost( 'newPassword' );
            $rePassword = $this->request->getPost( 'rePassword' );
            
            if( $this->session->get( 'userInfo' ) )
            {
                $userInfoArr = $this->session->get( 'userInfo' );
                $where = array(
                                'id = ?0',
                                'bind' => [ $userInfoArr[ 'id' ] ]
                );
                //判空
                if( $userInfo = PriUsers::findFirst( $where ) )
                {
                    //检查原始密码是否正确
                    if( $oldPassword != $userInfo->pwd )
                    {
                        $res[ 'state' ] = 4;
                        $res[ 'key' ] = $this->security->getTokenKey();
                        $res[ 'token' ] = $this->security->getToken();
                        echo json_encode( $res );
                        return;
                    }
                    //更新数据库数据
                    $userInfo->pwd = $newPassword;
                    //0成功1失败
                    $res[ 'state' ] = $userInfo->save()?0:1;
                }
                else
                {
                    $res[ 'state' ] = 2;//用户信息不存在
                }
            }
            else
            {
                $res[ 'state' ] = 3;//登录用户信息不存在，请退出后重新登录;
            }
        }
        else
       {
        	$ret[ 'state' ] = 5;//信息传递失败，请重试
        }
        
        $res[ 'key' ] = $this->security->getTokenKey();
        $res[ 'token' ] = $this->security->getToken();
        echo json_encode( $res );
    }
    
    /**
     * @author( author='Carey' )
     * @date( date = '2016-03-18' )
     * @comment( comment = '用户修改头像' )
     * @method( method = 'avatarAction' )
     * @op( op = 'r' )
     */
    public function avatarAction()
    {
    	$objRet = new \stdClass();
    	
    	$this->csrfCheck();
    	
    	$src = $this->request->getPost( 'src' );
    	$where	= array(
    		'conditions'=> 'delsign=:del: and id=:optid:',
    		'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'optid' => $this->userId ),
    	);
    	$result = PriUsers::findFirst( $where );
    	if( $result && count( $result ) > 0 )
    	{
    		$result->uptime = TimeUtils::getFullTime();
    		$result->avatar = $src;
    		if( $result->save() )
    		{
    			$userInfo = $this->session->get( 'userInfo' );
    			$userInfo[ 'avatar' ] = $result->avatar;
    			$this->session->set( 'userInfo', $userInfo );
    			
    			$objRet->state = 0;
    			$objRet->msg = '用户头像已修改成功...';
    		}
    		else 
    		{
    			$objRet->state = 1;
    			$objRet->msg = '对不起,修改失败请稍后再试..';
    		}
    	}
    	else
    	{
    		$objRet->state = 1;
    		$objRet->msg = '对不起,该用户未找到,修改失败..';
    	}
    	
    	$objRet->key = $this->security->getTokenKey();
    	$objRet->token = $this->security->getToken();
    	
    	echo json_encode( $objRet );
    }
}







