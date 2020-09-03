<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src='<c:url value="/webjars/jquery/3.5.1/jquery.js" />'></script>
<script type="text/javascript">
var usr_id_count = -1;
var usr_id = '';
// -1 : 체크하지 않은 경우, 0: 사용할 수 있는 아이디,  1: 사용할 수 없는 아이디



function validate() {
	let f = document.regist;
	
	if (f.usr_id.value.length < 4 || f.usr_id.value.length > 13) {
		alert('아이디는 4글자 이상 12글자 이하로 작성하세요');
		f.usr_id.focus();			
		return;
	}
	
	if (f.usr_name.value.length < 2 || f.usr_name.value.length > 6) {
		alert('이름은 2글자 이상 6글자 이하로 작성하세요');
		f.usr_name.focus();
		return;
	}
	
	if (f.usr_pw.value.length < 4 || f.usr_pw.value.length > 20) {
		alert('비밀번호는 4글자 이상 20글자 이하로 작성하세요');
		f.usr_pw.focus();
		return;
	}
	
	
	if (f.usr_pw.value != f.usr_pw2.value) {
		alert('비밀번호/비밀번호 확인이 일치하지 않습니다.');
		f.usr_pw.focus();
		return;
	}
	
	if (f.usr_birth.value == "") {
		alert('생년월일을 입력하세요');
		f.usr_birth.focus();
		return;
	}
	if (f.usr_phone.value == "") {
		alert('연락처를 입력하세요');
		f.usr_phone.focus();
		return;
	}
	if (f.usr_zipcode.value == "") {
		alert('우편번호를 입력하세요');
		f.btnZipcode.focus();
		return;
	}

	if (f.usr_address.value == "") {
		alert('주소를 입력하세요');
		f.usr_address.focus();
		return;
	}

	if (f.usr_address_detail.value == "") {
		alert('상세주소를 입력하세요');
		f.usr_address_detail.focus();
		return;
	}

	if (usr_id_count != 0) {
		alert('사용할 수 있는 아이디가 아닙니다.');
		return;
	}
	f.method = 'POST';
	f.action = 'regist';
	f.submit();
}

$(document).ready(function(){
	$('#usr_id').on('keyup',function(){
		usr_id_count = -1;
		let f = document.regist;
		usr_id = f.usr_id.value;
		if (usr_id.length < 4 || usr_id.length > 13) {
			$('#check_id_result').html('아이디는 4글자 이상 12글자 이하로 작성하세요');
			return;
		}
		//new ajax.xhr.Request('checkID', 'usr_id='+usr_id, callback, 'POST');
		$.post("checkID",{"usr_id" : usr_id})
		 .done(function( data ) {
			usr_id_count = parseInt(data);
			if (usr_id_count === 1){
				$('#check_id_result').html(usr_id + '는 이미 사용중인 아이디 입니다.');
				return;
			} else if (usr_id_count === 0) {
				$('#check_id_result').html(usr_id + '는 사용 가능한 아이디 입니다.');
				return;
			} else {
				alert('시스템 오류입니다~!!!!');
			}
		});	
		
	});
	
});
</script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('usr_zipcode').value = data.zonecode;
                document.getElementById("usr_address").value = roadAddr;
                //document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
//                 if(roadAddr !== ''){
//                     document.getElementById("sample4_extraAddress").value = extraRoadAddr;
//                 } else {
//                     document.getElementById("sample4_extraAddress").value = '';
//                 }

                //var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
//                 if(data.autoRoadAddress) {
//                     var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
//                     guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
//                     guideTextBox.style.display = 'block';

//                 } else if(data.autoJibunAddress) {
//                     var expJibunAddr = data.autoJibunAddress;
//                     guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
//                     guideTextBox.style.display = 'block';
//                 } else {
//                     guideTextBox.innerHTML = '';
//                     guideTextBox.style.display = 'none';
//                 }
            }
        }).open();
    }
</script>
</head>
<body>
<form name="regist" method="post" enctype="multipart/form-data">
<table border="1">
	<caption>회원 가입</caption>
<tr>
	<th>아이디</th>
	<td><input type="text" name="usr_id" id="usr_id" />
		<div id="check_id_result">영문자+숫자 4~12문자로 작성하세요</div>
	</td>
</tr>
<tr>
	<th>이름</th>
	<td><input type="text" name="usr_name" id="usr_name" /> 2~6문자
	</td>
</tr>
<tr>
	<th>비밀번호</th>
	<td><input type="password" name="usr_pw" id="usr_pw" /> 4~20문자</td> 
</tr>
<tr>
	<th>비밀번호 확인</th>
	<td><input type="password" name="usr_pw2" id="usr_pw2" /></td>
</tr>
<tr>
	<th>생일</th>
	<td><input type="date" name="usr_birth" id="usr_birth" /></td>
</tr>
<tr>
	<th>전화</th>
	<td><input type="text" name="usr_phone" id="usr_phone" /></td>
</tr>
<tr>
	<th>우편번호</th>
	<td>
		<input type="text" name="usr_zipcode" readonly="readonly" id="usr_zipcode"
		onclick="alert('검색버튼을 이용하여 입력하세요');" 
		style="width:55px;"/>
		<input type="button" value="검색" name="btnZipcode"
		onclick="sample4_execDaumPostcode()"
		/>
	</td>
</tr>
<tr>
	<th>주소</th>
	<td>
		<input type="text" name="usr_address" id="usr_address" style="width:250px;"/><br/>
	</td>
</tr>
<tr>
	<th>상세 주소</th>
	<td>
		<input type="text" name="usr_address_detail" /><br/>
	</td>
</tr>
 <tr>
	<th>개인 사진</th>
	<td>
		<input type="file" name="usr_pic"  id="usr_pic" />
	</td>
</tr> 
<tr>
	<td colspan="2" align="center">
		<input type="button" value="완료" onclick="validate()" />
	</td>
</tr>
</table>
</form>
</body>
</html>