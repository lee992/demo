<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Todo List</title>
</head>
<body>
<h1>Todo List</h1>
<div id="list"></div>
<input type="text" id="newTodo" placeholder="새 항목">
<button onclick="addTodo()">추가</button>
<script>
function loadTodos(){
    fetch('/api/todos')
        .then(r => r.json())
        .then(data => {
            const list = document.getElementById('list');
            list.innerHTML = '';
            data.forEach(item => {
                const div = document.createElement('div');
                div.textContent = item.content;
                const del = document.createElement('button');
                del.textContent = '삭제';
                del.onclick = () => removeTodo(item.id);
                const edit = document.createElement('button');
                edit.textContent = '수정';
                edit.onclick = () => {
                    const val = prompt('새 값', item.content);
                    if(val !== null) updateTodo(item.id, val);
                };
                div.appendChild(del);
                div.appendChild(edit);
                list.appendChild(div);
            });
        });
}
function addTodo(){
    const content = document.getElementById('newTodo').value;
    if(content.trim() === '') return;
    fetch('/api/todos', {
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body:JSON.stringify({content})
    }).then(() => { document.getElementById('newTodo').value=''; loadTodos(); });
}
function removeTodo(id){
    fetch('/api/todos/' + id, {method:'DELETE'}).then(loadTodos);
}
function updateTodo(id, content){
    fetch('/api/todos/' + id, {
        method:'PUT',
        headers:{'Content-Type':'application/json'},
        body:JSON.stringify({content})
    }).then(loadTodos);
}
loadTodos();
</script>
</body>
</html>
