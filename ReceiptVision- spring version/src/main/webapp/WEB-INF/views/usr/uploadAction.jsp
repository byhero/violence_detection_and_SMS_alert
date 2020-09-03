<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR" rel="stylesheet">

<link rel="icon" type="image/png" sizes="16x16" href="/webdev/kitty.png">
<title>Insert title here</title>
</head>
<body>
upload : <a href="download?fileName=${fileName}&folder=${folder}">${fileName}</a>(${fileSize})
<c:if test="${ext != null}">
	<hr/>
	<img src="download?fileName=${fileName}&folder=${folder}" />
	<hr/>
	<img src="download?fileName=thumb_${fileName}&folder=${folder}" />
</c:if>
</body>
</html>
