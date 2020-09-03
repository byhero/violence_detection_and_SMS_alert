<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='<c:url value="/webjars/jquery/3.5.1/jquery.js" />'></script>
<script type="text/javascript">
function print_menu() {
	var f ='';
	f += '<input multiple="multiple" type="file" name="file" />';
	f += '<select>';
	f += ' 	<option>식사</option>';
	f += ' 	<option>주류</option>';
	f += ' 	<option>여행</option>';
	f += '</select><br/>';
	return f;
}

$(document).ready(function(){
	$('#item').html(  print_menu()  );
	$('#add_item').click(function(){
		$('#item').append(  print_menu()  );
	});
});
</script>
</head>
<body>
    <form name="fileForm" action="requestupload2" method="post" enctype="multipart/form-data">
        <div id="item"></div>
        <br/>
        <input type="button" id="add_item" value=" + " />
        <input type="button" value="전송" />
    </form>
</body>
</html>

