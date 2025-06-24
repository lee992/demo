package com.example.demo;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.demo.model.Account;
import com.example.demo.service.AccountService;

@RestController
@RequestMapping("/api/accounts")
public class AccountController {

    @Autowired
    private AccountService service;

    @GetMapping
    public List<Account> all() {
        return service.getAll();
    }

    @PostMapping
    public void create(@RequestBody Account account) {
        service.createAccount(account);
    }

    @PostMapping("/{id}/deposit")
    public void deposit(@PathVariable int id,
                        @RequestParam int amount) {
        service.deposit(id, amount);
    }

    @PostMapping("/{id}/withdraw")
    public void withdraw(@PathVariable int id,
                         @RequestParam int amount) {
        service.withdraw(id, amount);
    }
}