<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="/bootstrap/toastr/toastr.min.css">
        <link rel="stylesheet" href="/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.css">
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#userList">用户</a></li>
            <li role="presentation"><a href="/admin/users/add">添加用户</a></li>
        </ul>
        <div class="tab-content" style="padding:20px 0px;">
            <div role="tabpannel" class="tab-pane active" id="userList">
                {% if page.items is defined and page.items is not empty %}
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>用户名</th>
                            <th>昵称</th>
                            <th>姓名</th>
                            <th>用户组</th>
                            <th>邮箱</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% for item in page.items %}
                        <tr>
                            <td>{{ item.loginname | e }}</td>
                            <td>{{ item.nickname | e }}</td>
                            <td>{{ item.name | e }}</td>
                            <td>{% if item.group_name %} {{ item.group_name | e }} {% endif %}</td>
                            <td>{{ item.email | e }}</td>
                            <td>{% if item.status == 0  %}正常{% elseif item.status == 1 %}冻结 {% elseif item.status == 2 %}删除{% elseif item.status == 3 %}忘记密码{% endif %}</td>
                            <td>
                                <a href="{{ url( 'admin/users/edit?id=' ) }}{{ item.id | e }}"><i class="glyphicon glyphicon-pencil operate userEdit" title="修改"></i></a>
                            {% if item.id != forbidId[ 'adminId' ] and item.id != forbidId[ 'loginId' ] %}
                                <i class="glyphicon glyphicon-trash operate userDelete" data-id="{{ item.id | e }}" style="margin-right: 10px;" title="删除"></i>
                            {% endif %}
                            </td>
                        </tr>
                        {% endfor %}
                    </tbody>
                </table>
                {% else %}
                	无管理员
                {% endif %}
                {% if page.total_pages > 1 %}
                <nav class="text-right" >
                    <ul class="pagination pagination-sm" style="margin-top:0"> 
                        <li class="{% if page.current == 1 %}disabled{% endif %}"><a href="{{ url( 'admin/users/index?page=' ) }}{{page.before}}" >&laquo;</a></li>
                        {% if  1 != page.current and 1 != page.before %}
                        <li><a href="{{ url( 'admin/users/index') }}">1</a></li>
                        {% endif %}

                        {% if page.before != page.current  %}
                        <li><a href="{{ url( 'admin/users/index?page=') }}{{ page.before }}"><span >{{ page.before }}</span></a></li>
                        {% endif %}
                        <li class="active"><a href="{{ url( 'admin/users/index?page=') }}{{ page.current }}"><span >{{ page.current }}</span></a></li>
                        {% if page.next != page.current %}
                        <li><a href="{{ url( 'admin/users/index?page=') }}{{ page.next }}">{{ page.next }}</a></li>
                        {% endif %}
                        {% if page.next  < page.last - 1 %}
                        <li><a>...</a></li>
                        {% endif %}
                        {% if page.last != page.next %}
                        <li><a href="{{ url( 'admin/users/index?page=') }}{{ page.last }}">{{ page.last }}</a></li>
                        {% endif %}
                        <li class="{% if page.current == page.last %}disabled{% endif %}"><a href="{{ url( 'admin/users/index?page=' ) }}{{page.next}}" >&raquo;</a></li>

                    </ul>
                </nav>
                {% endif %}
            </div>
        </div>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/toastr/toastr.js"></script>
        <script src="/public/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.js"></script>
        <script>
		$( function(){
			/*----------------删除-----------------*/
            var csrf = { key: '{{ security.getTokenKey() }}', token: '{{ security.getToken()}}'};
			$( 'table' ).on( 'click', '.userDelete', function(){
                var id = $( this ).attr( 'data-id' );
                var data = { id: id, key: csrf.key, token: csrf.token };
                var _this = this;

                $.confirm( { title: '是否删除该用户?', confirm: function(){
                    $.post( '/admin/users/delete', data, function( ret ){
                        if( !ret.status ){
                            $( _this ).parents( 'tr' ).remove();
                        }else{
                            toastr.error( ret.msg );
                        }
                        csrf = { key: ret.key, token: ret.token };
                    }, 'json' ).error( function(){ //网络不通
                        toastr.error( '网络不通' );
                    });
                }});
			} );
        } );
        </script>
    </body>
</html>