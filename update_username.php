<?php
require 'db_connect.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = isset($_POST['username']) ? trim($_POST['username']) : '';

    if (empty($username)) {
        echo json_encode(['error' => 'Username is required']);
        exit();
    }

    try {
        // Cek apakah username sudah ada
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM users WHERE username = ?");
        $stmt->execute([$username]);
        $count = $stmt->fetchColumn();

        if ($count > 0) {
            // Jika username sudah ada, update leaderboard juga
            $stmt = $pdo->prepare("UPDATE leaderboard SET username = ? WHERE username = ?");
            $stmt->execute([$username, $username]);
            echo json_encode(['message' => 'Username already exists, leaderboard updated']);
        } else {
            // Jika username baru, insert ke database
            $stmt = $pdo->prepare("INSERT INTO users (username) VALUES (?) ON DUPLICATE KEY UPDATE username = ?");
            $stmt->execute([$username, $username]);
            echo json_encode(['message' => 'Username updated successfully']);
        }
    } catch (PDOException $e) {
        echo json_encode(['error' => 'Failed to update username: ' . $e->getMessage()]);
    }
} else {
    echo json_encode(['error' => 'Invalid request method']);
}
?>