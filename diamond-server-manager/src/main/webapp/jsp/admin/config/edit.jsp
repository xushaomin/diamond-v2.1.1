<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>配置详细信息</title>

<link rel="stylesheet" type="text/css" href="/diamond-server/static/css/common.css" />
<link rel="stylesheet" type="text/css" href="/diamond-server/static/css/style.css" />
<script type="text/javascript" src="/diamond-server/static/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/jquery.pager.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/jquery.validate.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/jquery.tools.js"></script>

<script type="text/javascript" src="/diamond-server/static/js/common.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/list.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/input.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/admin.js"></script>

<script type="text/javascript" src="/diamond-server/static/js/prompt.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/artDialog/artDialog.source.js?skin=glsx"></script>
<script type="text/javascript" src="/diamond-server/static/js/artDialog/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="/diamond-server/static/js/pop.js"></script>

<script type="text/javascript">

$().ready(function() {

	<c:if test="${message!=null}">
   		pop_error("操作提示", "${message}", "", true);
	</c:if>
	
	var $inputForm = $("#config-form");
		
	// 表单验证
	$inputForm.validate({
		rules: {
			"dataId": "required",
			"group": "required",
			"content": "required"
		},
		messages: {
			"dataId": {
				required: "必填"
			},
			"group": {
				required: "必填"
			},
			"content": {
				required: "必填"
			}
		},
		submitHandler:function(form){
            form.submit();
        }
	});
	
});
   
   

</script>
</head>

<body>
<!-- start of con_right_main -->
<div class="con_right_main">

	 <c:url var="updateConfigUrl" value="/admin/update.do" />
     <form action="${updateConfigUrl}" method="post" id="config-form">
	
    <!-- start of con_search -->
	<div class="con_search">
	
    	<span class="con_box_BL"></span>
        
        <!-- start of add_list_table -->
        <table class="add_list_table input tabContent">
            <tr>
                <th class="padT20">dataId：</th>
                <td class="padT20"><input class="c_input_text text" type="text" name="dataId" value="${configInfo.dataId}" maxlength="250" readonly /></td>
            </tr>
            <tr>
                <th class="padT20">分组：</th>
                <td class="padT20"><input class="c_input_text text" type="text" name="group" value="${configInfo.group}" maxlength="250" readonly /></td>
            </tr>
            <tr>
                <th class="padT20">内容：</th>
                <td class="padT20">
                	<textarea class="c_textarea" style="width:90%;height:300px;" name="content">${configInfo.content}</textarea>
                </td>
            </tr>
            
        </table>
        <!-- end of add_list_table -->
        
        <span class="con_box_BR"></span>
    </div>
    <!-- end of con_search -->
    
    <!-- start of main_slide_con -->
    <div class="main_slide_con">
    	<input type="submit" class="btnC" value="确定" />
        <a class="btnD" href="javascript:void(0);" onclick="window.history.go(-1)">取消</a>
        
    </div>
    <!-- end of main_slide_con -->
    
    </form>
</div>
<!-- end of con_right_main -->
</body>
</html>