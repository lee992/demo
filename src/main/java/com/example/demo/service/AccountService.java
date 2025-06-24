package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.AccountMapper;
import com.example.demo.model.Account;

@Service
public class AccountService {
    @Autowired
    private AccountMapper mapper;

    public List<Account> getAll() {
        return mapper.getAll();
    }

    public int createAccount(Account account) {
        return mapper.insert(account);
    }

    public int deposit(int id, int amount) {
        return mapper.deposit(id, amount);
    }

    public int withdraw(int id, int amount) {
        return mapper.withdraw(id, amount);
    }
}
