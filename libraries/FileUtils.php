<?php

namespace libraries;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

class FileUtils
{

	function __construct( )
	{
	
	}

	public static function getFileExt( $strFileName )
	{
		$info = pathinfo( $strFileName );
		
		return $info['extension'];
	}
	
	/**
	 * 创建文件夹
	 * @param unknown $fname
	 * @return boolean
	 */
	public static function mkdir( $path, $fname )
	{
		if( false == $path || false == $fname )
			return false;
		
		if( is_dir( $path ) )
			mkdir( $path . $fname, 0777 );
	}
	
	
	/**
	 * @author( author='New' )
	 * @date( date = '2016-4-15' )
	 * @comment( comment = '循环删除文件夹或文件' )	
	 * @method( method = 'delDirAndFile' )
	 * @op( op = '' )		
	*/
	public static function delDirAndFile( $dirName )
	{
	    if( $handle = opendir( "$dirName" ) )
	    {
	        while( false !== ( $item = readdir( $handle ) ) )
	        {
	            if( $item != "." && $item != ".." )
	            {
	                if ( is_dir( "$dirName/$item" ) )
	                {
	                    FileUtils::delDirAndFile( "$dirName/$item" );
	                }
	                else
	               {
                        @unlink( "$dirName/$item" );//成功删除文件
        			}
        	    }
	        }
	        closedir( $handle );
	        
	        @rmdir( $dirName );//成功删除目录
	    }
	}
	
	
    public static function moveDir( $dir, $aimDir )
    {
        //取出文件或者文件夹
        $list = scandir( $dir );
        //判断目标文件夹是否存在，不存在就创建
        if( !is_dir( $aimDir ) )
        {
        	mkdir( $aimDir, 0777 );
        }
        foreach( $list as $file )
        {
            $nextDir = $dir . '/' . $file;
            
            //判断如果是文件，则直直接复制过去
            if( is_file( $nextDir ) )
            {
                $tmp = explode( '/', $nextDir );
            	copy( $nextDir, $aimDir . '/' . end( $tmp ) );
            }
            //判断如果是文件夹，则在目标路径创建该文件夹，之后再调用自身函数再去进行处理
            elseif( is_dir( $nextDir ) && '.' != $file && '..' != $file )
            {
                $nextAimDir = $aimDir . '/' . $file;
                FileUtils::moveDir( $nextDir, $nextAimDir );
            }
        }
    }
    
	
	
}

?>