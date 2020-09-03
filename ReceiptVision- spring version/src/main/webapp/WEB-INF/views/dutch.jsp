<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h2>더치페이<span class="badge badge-warning">항목</span></h2>
<hr>
<table class="table">
    <thead class="thead-light">
    <tr>
      <th>#</th>
      <th>항목</th>
      <th>가격</th>
      <th>수량</th>
      <th>합계</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="item" items="${ items }" varStatus="status">
        <tr>
            <th>${ status.count }</th>
            <td>${ item.title }</td>
            <td>${ item.price }</td>
            <td>${ item.amount }</td>
            <td>${ item.price * item.amount }</td>
        </tr>
    </c:forEach>
  </tbody>
  <tfoot>
    <tr>
        <td colspan="4"></td>
        <td>${ cart.totalPrice }</td>
    </tr>
  </tfoot>
</table>