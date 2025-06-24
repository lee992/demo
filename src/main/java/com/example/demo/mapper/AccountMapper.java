package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.model.Account;

@Mapper
public interface AccountMapper {
    List<Account> getAll();
    int insert(Account account);
    int deposit(@Param("id") int id, @Param("amount") int amount);
    int withdraw(@Param("id") int id, @Param("amount") int amount);
}
