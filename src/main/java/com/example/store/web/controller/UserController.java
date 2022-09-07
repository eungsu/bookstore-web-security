package com.example.store.web.controller;

import lombok.RequiredArgsConstructor;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.store.dto.OrderDetailDto;
import com.example.store.paging.Pagable;
import com.example.store.service.OrderService;
import com.example.store.vo.Order;
import com.example.store.vo.User;

import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

    private final OrderService orderService;

    @GetMapping("/order/list")
    public String orderList(Authentication authentication, Pagable pagable, Model model) {
    	User loginUser = (User) authentication.getPrincipal();
        List<Order> orders = orderService.getMyOrders(pagable, loginUser.getId());
        model.addAttribute("orders", orders);

        return "user/order/list";
    }

    @GetMapping("/order/detail")
    public String orderDetail(@RequestParam("id") int orderId, Model model) {
        OrderDetailDto orderDetailDto = orderService.getOrderDetail(orderId);
        model.addAttribute("dto", orderDetailDto);

        return "user/order/detail";
    }
}
