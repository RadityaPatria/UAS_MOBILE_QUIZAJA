<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
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

// Ambil data dari request
$data = json_decode(file_get_contents('php://input'), true);
$user_id = $data['user_id'] ?? null;
$username = $data['username'] ?? null; // Ambil username
$score = $data['score'] ?? null;
$category = $data['category'] ?? null;

if (!$user_id || !$username || !$score || !$category) {
    echo json_encode(['status' => 'error', 'message' => 'Data tidak lengkap']);
    exit();
}

// Simpan ke database
try {
    $stmt = $pdo->prepare("INSERT INTO scores (user_id, username, score, category) VALUES (?, ?, ?, ?)");
    $stmt->execute([$user_id, $username, $score, $category]);
    echo json_encode(['status' => 'success', 'message' => 'Skor berhasil disimpan']);
} catch (PDOException $e) {
    echo json_encode(['status' => 'error', 'message' => 'Gagal menyimpan skor: ' . $e->getMessage()]);
}
?>