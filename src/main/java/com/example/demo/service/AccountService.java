package com.example.demo.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.demo.mapper.AccountMapper;
import com.example.demo.model.Account;

@Service
public class AccountService {
    @Autowired
    private AccountMapper mapper;

    public List<Account> getAll() {
        return mapper.getAll();
    }

    @Transactional
    public int createAccount(Account account) {
        int initialBalance = account.getBalance();
        account.setBalance(0);
        mapper.insert(account);
        if (initialBalance > 0) {
            mapper.deposit(account.getId(), initialBalance);
        }
        return account.getId();
    }

    @Transactional
    public int deposit(int id, int amount) {
        return mapper.deposit(id, amount);
    }

    @Transactional
    public int withdraw(int id, int amount) {
        return mapper.withdraw(id, amount);
    }
}