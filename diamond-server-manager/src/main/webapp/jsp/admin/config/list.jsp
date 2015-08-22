<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>配置信息管理</title>

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
   function confirmForDelete(){
       return window.confirm("你确认要删除该配置信息吗??");  
   }
   function queryConfigInfo(method){
       document.all.listForm.method.value=method;
       document.all.listForm.submit();       
   }
  
  function gotoAuth(url){
	art.dialog.open(url, {
		id: 'gotoAuth',
		title: '配置授权',
		close: function () {
			
		}
	}, false);
  }
  
  function gotoView(url){
	art.dialog.open(url, {
		id: 'gotoAuth',
		title: '查看配置',
		close: function () {
			
		}
	}, false);
  }
  
  function saveToDisk(url){
       
       $.ajax({
				type: "get",
				url: url,
				dataType: "html",
				beforeSend: function(XMLHttpRequest){
					//ShowLoading();
				},
				success: function(data, textStatus){
					if(data.indexOf("OK") > -1) {
						pop_succeed("操作提示", "操作成功", "", true);
					}
					else {
						pop_error("操作提示", "操作失败", "", true);
					}
				},
				complete: function(XMLHttpRequest, textStatus){
					//HideLoading();
				},
				error: function(){
					//请求出错处理
				}
		}); 
   }
</script>
</head>
<c:url var="adminUrl" value="/admin/list.do" />

<body>
<!-- start of con_right_main -->
<div class="con_right_main">

	<form id="listForm" name="listForm" action="${adminUrl}">
	<input type='hidden' name="pageNo" value='1'/>
  	<input type='hidden' name="pageSize" value='15'/>
    
    <!-- start of con_search -->
	<div class="con_search">
    	<span class="con_box_BL"></span>
        
        <!-- start of con_search_top -->
        <div class="con_search_top clearfix">
        	<div class="con_search_top_L left">
                <p>
                    <span class="group j-input-box"><label>关键字:</label>
                		<input style="width:200px;" class="c_input_text j-search-input auto_hint" id="keyword" name="keyword" type="text" value="${keyword}" />
                    </span>
                    <span class="group"><a onclick="queryConfigInfo('listConfigLike');" class="btn_search" id="jz_search">搜索</a></span>
                </p>
            </div>
            <!--
            <div class="con_search_btn right">
                <a class="btnA" href="admin.do?method=gotoNew">添加配置</a>
            </div>
            -->
        </div>
        <!-- end of con_search_top -->
        
        <span class="con_box_BR"></span>
    </div>
    <!-- end of con_search -->
    
    <!-- start of table_list -->
    <c:if test="${page!=null}">
    <table id="listTable" class="table_list list">
        <tr>
        	<th width="6%" >序号</th>
			<th width="20%" orderField="dataId">dataId</th>
			<th width="10%" orderField="group">组名</th>
			<th width="20%">操作</th>
        </tr>
        
        <c:forEach items="${page.pageItems}" var="configInfo">
        <tr class="even">
        	  <td name="tagID">
                  <c:out value="${configInfo.id}"/>
              </td>
              <td name="tagDataID" style="text-align:left;">
                  <c:out value="${configInfo.dataId}"/>
              </td>
              <td name="tagGroup">
                  <c:out value="${configInfo.group}" escapeXml="false"/>
              </td>

			  <c:if test="${fn:contains(CAS_USER.roles, configRoleId) == true || CAS_USER.isadmin == 1}">
              <c:url var="getConfigInfoUrl" value="/admin/edit.do" >
                  <c:param name="group" value="${configInfo.group}" />
                  <c:param name="dataId" value="${configInfo.dataId}" />
              </c:url>
               <c:url var="deleteConfigInfoUrl" value="/admin/delete.do" >
                  <c:param name="method" value="deleteConfig" />
                  <c:param name="id" value="${configInfo.id}" />
                  <c:param name="keyword" value="${keyword}" />
              </c:url>
          	  <c:url var="saveToDiskUrl" value="/notify.do" >
                  <c:param name="method" value="notifyConfigInfo" />
                   <c:param name="group" value="${configInfo.group}" />
                  <c:param name="dataId" value="${configInfo.dataId}" />
              </c:url>
              <c:url var="authUrl" value="/admin/authlist.do" >
                  <c:param name="id" value="${configInfo.id}" />
              </c:url>
              </c:if>
              
              
              <c:url var="previewUrl" value="/admin/view.do" >
                  <c:param name="group" value="${configInfo.group}" />
                  <c:param name="dataId" value="${configInfo.dataId}" />
              </c:url>
              <td>
              	<c:if test="${fn:contains(CAS_USER.roles, configRoleId) == true || CAS_USER.isadmin == 1}">
              	<a class="btn_icon btn_edit"    href="${getConfigInfoUrl}" title="编辑">编辑</a>
                <a class="btn_icon btn_delete"  href="${deleteConfigInfoUrl}" onclick="return confirmForDelete();" title="删除">删除</a>
                <a class="btn_icon btn_effect"  href="javascript:void(0);" onclick="saveToDisk('${saveToDiskUrl}');" title="保存磁盘">保存磁盘</a>
                <a class="btn_icon btn_examine" href="javascript:void(0);" onclick="gotoAuth('${authUrl}');" title="授权">授权</a>
              	</c:if>
                <a class="btn_icon btn_view"    href="javascript:void(0);" onclick="gotoView('${previewUrl}');" title="预览">预览</a>
              </td>
      	</tr>
        </c:forEach>
    </table>
    
    <!-- end of table_list -->
    
    
    
    	<!-- start of table_bottom -->
	    <div class="table_bottom clearfix">
	    	<div class="table_bottom_checkbox left">
	    		<!--<input id="selectAll" name="" type="checkbox" value=""><a class="btn" href="#">删除选中</a>-->
	    	</div>
	        
	   		<!-- start of 分页 -->
	        <div class="page right">
	        	<c:url var="nextPage" value="/admin/list.do" >
		             <c:param name="env" value="${env}" />
		             <c:param name="keyword" value="${keyword}" />
		             <c:param name="pageNo" value="${page.pageNumber+1}" />
		             <c:param name="pageSize" value="10" />
		         </c:url>
		         <c:url var="prevPage" value="/admin/list.do" >
		             <c:param name="env" value="${env}" />
		             <c:param name="keyword" value="${keyword}" />
		             <c:param name="pageNo" value="${page.pageNumber-1}" />
		             <c:param name="pageSize" value="10" />
		         </c:url>
		         <c:url var="firstPage" value="/admin/list.do" >
		             <c:param name="env" value="${env}" />
		             <c:param name="keyword" value="${keyword}" />
		             <c:param name="pageNo" value="1" />
		             <c:param name="pageSize" value="10" />
		         </c:url>
		         <c:url var="lastPage" value="/admin/list.do" >
		             <c:param name="env" value="${env}" />
		             <c:param name="keyword" value="${keyword}" />
		             <c:param name="pageNo" value="${page.pagesAvailable}" />
		             <c:param name="pageSize" value="10" />
		         </c:url>
	            <span></span>
	            <a href="${firstPage}">首页</a>
	            <c:choose>
		             <c:when  test="${page.pageNumber==1 && page.pagesAvailable>1}">
		               <a href="${nextPage}">下一页</a>
		             </c:when>
		             <c:when  test="${page.pageNumber>1 && page.pagesAvailable==page.pageNumber}">
		               <a href="${prevPage}">上一页</a>
		             </c:when>
		             <c:when  test="${page.pageNumber==1 && page.pagesAvailable==1}">
		             </c:when>
		             <c:otherwise>
		                <a href="${prevPage}">上一页</a>
		                <a href="${nextPage}">下一页</a>  
		             </c:otherwise>
		       	</c:choose>
	            <a href="${lastPage}">末页</a>
	            <span>共<c:out value="${page.pageNumber}" />/<c:out value="${page.pagesAvailable}"/>页</span>
	        </div>
	        <!-- end of 分页 -->
	    </div>
	    <!-- end of table_bottom -->
			
		</c:if>
			
    </form>
</div>
<!-- end of con_right_main -->
</body>
</html>