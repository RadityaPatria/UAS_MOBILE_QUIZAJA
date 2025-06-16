<?php
require 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';
    $avatar_url = isset($_POST['avatar_url']) ? trim($_POST['avatar_url']) : '';

    if (empty($username) || empty($avatar_url)) {
        echo json_encode(['error' => 'Username and avatar_url are required']);
        exit();
    }

    try {
        // Update avatar_url berdasarkan username
        $stmt = $pdo->prepare("UPDATE users SET avatar_url = ? WHERE username = ?");
        $stmt->execute([$avatar_url, $username]);

        if ($stmt->rowCount() > 0) {
            echo json_encode(['message' => 'Avatar updated successfully']);
        } else {
            // Jika username tidak ditemukan, insert user baru
            $stmt = $pdo->prepare("INSERT INTO users (username, avatar_url) VALUES (?, ?)");
            $stmt->execute([$username, $avatar_url]);
            echo json_encode(['message' => 'User created and avatar set successfully']);
        }
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Failed to update avatar: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['error' => 'Invalid request method']);
}
?>