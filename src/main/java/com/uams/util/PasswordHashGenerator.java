package com.uams.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHashGenerator {
    public static void main(String[] args) {
        String password = "admin123";
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        System.out.println("Password: " + password);
        System.out.println("Hashed Password: " + hashedPassword);
        
        // Verify the hash
        boolean matches = BCrypt.checkpw(password, hashedPassword);
        System.out.println("Password Matches: " + matches);
        
        // Verify against stored hash
        String storedHash = "$2a$10$8K1p/a7yx2xw.r4gL8YtQ.VNB8vDntkdZa5c3c5QscMBYE3mmrwwi";
        boolean matchesStored = BCrypt.checkpw(password, storedHash);
        System.out.println("Matches Stored Hash: " + matchesStored);
    }
}
