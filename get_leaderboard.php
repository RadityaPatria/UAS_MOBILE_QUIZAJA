<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

// Koneksi ke database
$host = 'localhost';
$dbname = 'quizaja_db'; // Ganti dengan nama database kamu
$username = 'root'; // Ganti dengan username database kamu
$password = ''; // Ganti dengan password database kamu

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    echo json_encode(['status' => 'error', 'message' => 'Koneksi gagal: ' . $e->getMessage()]);
    exit();
}

// Ambil data leaderboard dari database
try {
    $stmt = $pdo->prepare("SELECT username, category, score FROM scores ORDER BY category ASC, score DESC");
    $stmt->execute();
    $leaderboard = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(['status' => 'success', 'data' => $leaderboard]);
} catch (PDOException $e) {
    echo json_encode(['status' => 'error', 'message' => 'Gagal mengambil leaderboard: ' . $e->getMessage()]);
}
?>