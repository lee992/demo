<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%-- Account Manager JSP with Simple Design (EL-safe JS) --%>
<%
    String ctx = request.getContextPath(); // e.g. "/demo" or ""
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Account Manager</title>
    <style>
        /* Base Reset */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem;
        }
        h1 {
            margin-bottom: 1rem;
            font-size: 2rem;
        }
        /* Container */
        .container {
            width: 100%;
            max-width: 600px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        /* Account Row */
        .account-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid #eee;
        }
        .account-row:last-child { border-bottom: none; }
        .account-info {
            font-size: 1rem;
        }
        .actions button {
            margin-left: 0.5rem;
            padding: 0.4rem 0.8rem;
            border: none;
            border-radius: 4px;
            font-size: 0.9rem;
            cursor: pointer;
            background-color: #1890ff;
            color: #fff;
            transition: background 0.2s;
        }
        .actions button:hover {
            background-color: #40a9ff;
        }
        /* Form */
        .form-container {
            display: flex;
            gap: 0.5rem;
        }
        .form-container input {
            flex: 1;
            padding: 0.5rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }
        .form-container button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            background-color: #52c41a;
            color: #fff;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.2s;
        }
        .form-container button:hover {
            background-color: #73d13d;
        }
    </style>
</head>
<body>
    <h1>Account Manager</h1>
    <div class="container" id="accounts">
        <!-- 계좌 목록 렌더링 -->
    </div>
    <div class="container form-container">
        <input type="text" id="newName" placeholder="이름">
        <input type="number" id="newBalance" placeholder="초기 금액">
        <button onclick="createAccount()">계좌 생성</button>
    </div>
    <script>
        // EL-safe context path
        window.ctx = '<%= ctx %>';

        /** 계좌 목록 불러오기 및 렌더링 **/
        function loadAccounts() {
            var url = window.ctx + '/api/accounts';
            fetch(url)
                .then(function(res) { return res.json(); })
                .then(function(list) {
                    var container = document.getElementById('accounts');
                    container.innerHTML = '';
                    if (!Array.isArray(list) || list.length === 0) {
                        container.textContent = '등록된 계좌가 없습니다.';
                        return;
                    }
                    list.forEach(function(acc) {
                        var row = document.createElement('div');
                        row.className = 'account-row';

                        var info = document.createElement('div');
                        info.className = 'account-info';
                        info.textContent = acc.id + ' / ' + acc.name + ' / ' + acc.balance + '원';

                        var actions = document.createElement('div');
                        actions.className = 'actions';
                        var btnDep = document.createElement('button');
                        btnDep.textContent = '입금';
                        btnDep.onclick = function() { deposit(acc.id); };
                        var btnWit = document.createElement('button');
                        btnWit.textContent = '출금';
                        btnWit.onclick = function() { withdraw(acc.id); };
                        actions.appendChild(btnDep);
                        actions.appendChild(btnWit);

                        row.appendChild(info);
                        row.appendChild(actions);
                        container.appendChild(row);
                    });
                })
                .catch(function(err) {
                    console.error('loadAccounts error:', err);
                });
        }

        /** 새 계좌 생성 **/
        function createAccount() {
            var name = document.getElementById('newName').value;
            var balance = parseInt(document.getElementById('newBalance').value) || 0;
            var url = window.ctx + '/api/accounts';
            fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name: name, balance: balance })
            }).then(loadAccounts);
        }

        /** 입금 처리 **/
        function deposit(id) {
            var amount = parseInt(prompt('입금 금액', '0'));
            if (!amount || amount <= 0) return;
            var url = window.ctx + '/api/accounts/' + id + '/deposit?amount=' + amount;
            fetch(url, { method: 'POST' }).then(loadAccounts);
        }

        /** 출금 처리 **/
        function withdraw(id) {
            var amount = parseInt(prompt('출금 금액', '0'));
            if (!amount || amount <= 0) return;
            var url = window.ctx + '/api/accounts/' + id + '/withdraw?amount=' + amount;
            fetch(url, { method: 'POST' }).then(loadAccounts);
        }

        // 페이지 로드 후 최초 호출
        window.onload = loadAccounts;
    </script>
</body>
</html>
