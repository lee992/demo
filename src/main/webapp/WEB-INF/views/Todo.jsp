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

  <!-- 새 항목 입력 -->
  <input type="text" id="newTodo" placeholder="새 항목">
  <button onclick="addTodo()">추가</button>

  <script>
  // 1) 할 일 목록 불러와서 그리기
  function loadTodos() {
    fetch('/api/todos')
      .then(r => r.json())
      .then(data => {
        const list = document.getElementById('list');
        list.innerHTML = '';            // 기존 목록 초기화

        data.forEach(item => {
          // ───────────────────────────────────
          // ★ 여기서 item.content가 아니라 item.todo ★
          const div = document.createElement('div');
          div.textContent = item.todo;  // ← 수정된 부분

          // 삭제 버튼
          const del = document.createElement('button');
          del.textContent = '삭제';
          del.onclick = () => removeTodo(item.id);

          // 수정 버튼
          const edit = document.createElement('button');
          edit.textContent = '수정';
          edit.onclick = () => {
            const val = prompt('새 값', item.todo);
            if (val !== null && val.trim() !== '') {
              updateTodo(item.id, val);
            }
          };

          div.appendChild(del);
          div.appendChild(edit);
          list.appendChild(div);
        });
      })
      .catch(console.error);
  }

  // 2) 새 할 일 추가
  function addTodo() {
    const text = document.getElementById('newTodo').value;
    if (text.trim() === '') return;

    fetch('/api/todos', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      // ───────────────────────────────────
      // ★ JSON 키도 content가 아니라 todo ★
      body: JSON.stringify({ todo: text })  // ← 수정된 부분
    })
    .then(() => {
      document.getElementById('newTodo').value = '';
      loadTodos();
    })
    .catch(console.error);
  }

  // 3) 삭제 요청
  function removeTodo(id) {
    fetch('/api/todos/' + id, { method: 'DELETE' })
      .then(loadTodos)
      .catch(console.error);
  }

  // 4) 수정 요청
  function updateTodo(id, newText) {
    fetch('/api/todos/' + id, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ todo: newText })  // ← 수정된 부분
    })
    .then(loadTodos)
    .catch(console.error);
  }

  // 페이지 열리면 바로 로드
  loadTodos();
  </script>
</body>
</html>
