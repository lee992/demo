<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- JSTL 사용하기 위한 설정 -->
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Delete</th>
			<th>Crystal</th>
		</tr>
		<c:forEach items="${users}" var="user">
			<tr>
				<td>${user.id}</td>
				<td>${user.test}</td>
				<td><button onclick=DeleteTest(${user.id})>삭제</button></td>
				<td><button onclick="CrystalTest(${user.id}, '${user.test}')">수정</button></td>
			</tr>
		</c:forEach>	
	</table>
	<form action="InsertTest" method="post">
		 <input type="text" name="test" placeholder="새로운 값 입력" />
		 <button type="submit">추가</button>
	</form>
</body>
</html>
<script>
	function DeleteTest(id){
		location.href="/DeleteTest?id="+id //쿼리스트링
	}
</script>
<script>
	function CrystalTest(id, currentValue){
		const newValue = prompt("새 값을 입력하세요", currentValue);
		if (newValue !== null && newValue.trim() !== "") {
	        location.href = 
	          '${pageContext.request.contextPath}/CrystalTest'
	          + '?id='   + id
	          + '&test=' + encodeURIComponent(newValue);
	      }
	}
</script>