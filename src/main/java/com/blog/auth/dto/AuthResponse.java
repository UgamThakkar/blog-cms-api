package com.blog.auth.dto;

public record AuthResponse(
        String token,
        String email,
        String username,
        String role
) {}