<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src='<c:url value="/webjars/jquery/3.5.1/jquery.js" />'></script>
	<script>
		$(document).ready(function () {
			if (true) {
				receiptA();
			}
		});

		function receiptA() {
			var result = ${ response };
			var stringResult = JSON.stringify(result);
			var parseResult = JSON.parse(stringResult);

			var totalMoney = getText(parseResult, '합계IY', '결제금액');
			$('#totalMoney').text(totalMoney);
			var today = getText(parseResult, '01]', '주문번호');
			today = today.substring(0, 10) + " " + today.substring(10);
			$('#today').text(today);
		}
		function getText(texts, start, end) {
			var text = '';
			for (var i = 0; i < texts.images[0].fields.length; i++) {

				text += texts.images[0].fields[i].inferText;
			}
			return text.substring(text.indexOf(start) + start.length, text.indexOf(end)).replace(',', '').trim();
		}
	</script>

</head>

<body>
	합계 : <span id="totalMoney"></span><br />
	날짜 : <span id="today"></span><br />
</body>

</html>