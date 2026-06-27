package com.blog.auth;

import com.blog.auth.dto.AuthResponse;
import com.blog.auth.dto.LoginRequest;
import com.blog.auth.dto.RegisterRequest;
import com.blog.config.JwtService;
import com.blog.user.User;
import com.blog.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional
public class AuthService {

    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;

    public AuthResponse register(RegisterRequest request) {

        // 1. Check email not already taken
        if (userRepository.existsByEmail(request.email())) {
            throw new RuntimeException("Email already registered");
        }

        // 2. Check username not already taken
        if (userRepository.existsByUsername(request.username())) {
            throw new RuntimeException("Username already taken");
        }

        // 3. Build the user — hash the password, never store plain text
        User user = User.builder()
                .email(request.email())
                .username(request.username())
                .passwordHash(passwordEncoder.encode(request.password()))
                .build();

        // 4. Save to database
        userRepository.save(user);

        // 5. Generate JWT token
        String token = jwtService.generateToken(user.getEmail());

        // 6. Return response
        return new AuthResponse(token, user.getEmail(),
                user.getUsername(), user.getRole().name());
    }

    public AuthResponse login(LoginRequest request) {

        // 1. Find user by email
        User user = userRepository.findByEmail(request.email())
                .orElseThrow(() -> new RuntimeException("Invalid email or password"));

        // 2. Verify password against stored hash
        if (!passwordEncoder.matches(request.password(), user.getPasswordHash())) {
            throw new RuntimeException("Invalid email or password");
        }

        // 3. Generate JWT token
        String token = jwtService.generateToken(user.getEmail());

        // 4. Return response
        return new AuthResponse(token, user.getEmail(),
                user.getUsername(), user.getRole().name());
    }
}