<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1">
	<caption>회원 가입 성공</caption>
<tr>
	<th>아이디</th>
	<td>${usrDTO.usr_id}</td>
</tr>
<tr>
	<th>이름</th>
	<td>${usrDTO.usr_name}</td>
</tr>
<tr>
	<th>우편번호</th>
	<td>${usrDTO.usr_zipcode}</td>
</tr>
<tr>
	<th>주소</th>
	<td>${usrDTO.usr_address}</td>
</tr>
<tr>
	<th>상세 주소</th>
	<td>${usrDTO.usr_address_detail}</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="button" value="로그인 이동" 
		onclick="location.href='/home/usr/'" />
	</td>
</tr>
</table>
</body>
</html>