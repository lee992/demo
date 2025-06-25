<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    // JSP에서 컨텍스트 경로를 가져옵니다 (예: "/demo")
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Account Manager</title>
  <style>
    /* ── 기본 레이아웃 리셋 ── */
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      background: #f0f2f5;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #333;
      display: flex; flex-direction: column; align-items: center;
      padding: 2rem;
    }
    h1 { font-size: 2rem; margin-bottom: 1.5rem; }

    /* ── 테이블 컨테이너 ── */
    .container {
      width: 100%; max-width: 640px;
      background: #fff; border-radius: 8px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.06);
      overflow: hidden; margin-bottom: 1.5rem;
    }

    /* ── 계좌 테이블 ── */
    .account-table {
      width: 100%;
      border-collapse: collapse;
      table-layout: fixed; /* 열 너비 고정 */
    }
    .account-table colgroup col:nth-child(1) { width: 40%; }
    .account-table colgroup col:nth-child(2) { width: 30%; }
    .account-table colgroup col:nth-child(3) { width: 30%; }

    /* 헤더 */
    .account-table thead { background: #fafafa; }
    .account-table th {
      padding: 1rem 0.5rem;
      font-weight: 600;
      border-bottom: 2px solid #e8e8e8;
    }
    .account-table th.name    { text-align: left; }
    .account-table th.balance { text-align: center; }
    .account-table th.actions { text-align: right; }

    /* 본문 */
    .account-table td {
      padding: 0.75rem 0.5rem;
      border-bottom: 1px solid #f0f0f0;
      vertical-align: middle;
      word-wrap: break-word;
    }
    .account-table td.name    { text-align: left; }
    .account-table td.balance { text-align: center; }
    .account-table td.actions { text-align: right; }

    .account-table tbody tr:hover { background: #fcfcfc; }

    /* 버튼 */
    .actions button {
      margin-left: 0.4rem; padding: 0.45rem 0.9rem;
      font-size: 0.9rem; border: none; border-radius: 4px;
      color: #fff; cursor: pointer; transition: background 0.2s;
    }
    .actions button:first-child { margin-left: 0; }
    .actions button.deposit { background: #36cfc9; }
    .actions button.deposit:hover { background: #5cdbd3; }
    .actions button.withdraw { background: #1890ff; }
    .actions button.withdraw:hover { background: #40a9ff; }

    /* 새 계좌 폼 */
    .form-container {
      width: 100%; max-width: 640px;
      display: flex; gap: 0.5rem;
      margin-bottom: 2rem;
    }
    .form-container input {
      flex: 1; padding: 0.6rem;
      border: 1px solid #d9d9d9; border-radius: 4px;
      font-size: 1rem;
    }
    .form-container button {
      padding: 0.6rem 1.2rem;
      background: #52c41a; color: #fff;
      border: none; border-radius: 4px;
      font-size: 1rem; cursor: pointer;
      transition: background 0.2s;
    }
    .form-container button:hover { background: #73d13d; }
  </style>
</head>
<body>
  <h1>Account Manager</h1>

  <div class="container">
    <table class="account-table">
      <colgroup>
        <col>
        <col>
        <col>
      </colgroup>
      <thead>
        <tr>
          <th class="name">이름</th>
          <th class="balance">잔액</th>
          <th class="actions">관리</th>
        </tr>
      </thead>
      <tbody id="accountBody"></tbody>
    </table>
  </div>

  <div class="form-container">
    <input type="text" id="newName" placeholder="이름">
    <input type="number" id="newBalance" placeholder="초기 금액">
    <button onclick="createAccount()">계좌 생성</button>
  </div>

  <script>
    window.ctx = '<%= ctx %>';

    async function loadAccounts() {
      try {
        const res = await fetch(window.ctx + '/api/accounts');
        const list = await res.json();
        const body = document.getElementById('accountBody');
        body.innerHTML = '';

        if (!Array.isArray(list) || list.length === 0) {
          const tr = document.createElement('tr');
          const td = document.createElement('td');
          td.colSpan = 3;
          td.style.textAlign = 'center';
          td.textContent = '등록된 계좌가 없습니다.';
          tr.appendChild(td);
          body.appendChild(tr);
          return;
        }

        list.forEach(acc => {
          const tr = document.createElement('tr');
          const tdName = document.createElement('td');
          tdName.className = 'name';
          tdName.textContent = acc.name;
          const tdBal = document.createElement('td');
          tdBal.className = 'balance';
          tdBal.textContent = acc.balance + '원';
          const tdAct = document.createElement('td');
          tdAct.className = 'actions';
          const btnDep = document.createElement('button');
          btnDep.className = 'deposit';
          btnDep.textContent = '입금';
          btnDep.addEventListener('click', () => handleDeposit(acc.id));
          const btnWit = document.createElement('button');
          btnWit.className = 'withdraw';
          btnWit.textContent = '출금';
          btnWit.addEventListener('click', () => handleWithdraw(acc.id));
          tdAct.append(btnDep, btnWit);
          tr.append(tdName, tdBal, tdAct);
          body.appendChild(tr);
        });
      } catch (err) {
        console.error('계좌 로딩 오류:', err);
      }
    }

    async function createAccount() {
      const name = document.getElementById('newName').value.trim();
      const balance = parseInt(document.getElementById('newBalance').value) || 0;
      try {
        await fetch(window.ctx + '/api/accounts', {
          method: 'POST',
          headers: {'Content-Type':'application/json'},
          body: JSON.stringify({ name, balance })
        });
        document.getElementById('newName').value = '';
        document.getElementById('newBalance').value = '';
        loadAccounts();
      } catch (err) {
        console.error('계좌 생성 오류:', err);
      }
    }

    async function handleDeposit(id) {
      const input = prompt('입금할 금액을 입력하세요', '0');
      const amount = parseInt(input, 10);
      if (isNaN(amount) || amount <= 0) {
        alert('올바른 금액을 입력해 주세요.');
        return;
      }
      const url = window.ctx + '/api/accounts/' + id + '/deposit?amount=' + encodeURIComponent(amount);
      try {
        const response = await fetch(url, { method: 'POST' });
        if (!response.ok) throw new Error('입금 실패: ' + response.status);
        loadAccounts();
      } catch (err) {
        console.error('입금 오류:', err);
        alert('입금 중 오류가 발생했습니다. 콘솔을 확인하세요.');
      }
    }

    async function handleWithdraw(id) {
      const input = prompt('출금할 금액을 입력하세요', '0');
      const amount = parseInt(input, 10);
      if (isNaN(amount) || amount <= 0) {
        alert('올바른 금액을 입력해 주세요.');
        return;
      }
      const url = window.ctx + '/api/accounts/' + id + '/withdraw?amount=' + encodeURIComponent(amount);
      try {
        const response = await fetch(url, { method: 'POST' });
        if (!response.ok) throw new Error('출금 실패: ' + response.status);
        loadAccounts();
      } catch (err) {
        console.error('출금 오류:', err);
        alert('출금 중 오류가 발생했습니다. 콘솔을 확인하세요.');
      }
    }

    // 최초 로드
    window.onload = loadAccounts;
  </script>
</body>
</html>
