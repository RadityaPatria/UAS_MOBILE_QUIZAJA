<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

// Handle preflight request (OPTIONS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);
$username = $data['username'] ?? '';
$password = $data['password'] ?? '';

// Tambahkan log untuk debugging
file_put_contents('debug.log', "Login attempt: " . json_encode($data) . "\n", FILE_APPEND);

if (empty($username) || empty($password)) {
    file_put_contents('debug.log', "Username atau password kosong\n", FILE_APPEND);
    echo json_encode(["status" => "error", "message" => "Username dan password diperlukan"]);
    exit;
}

$sql = "SELECT * FROM users WHERE username = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) {
        file_put_contents('debug.log', "Login success for user: $username\n", FILE_APPEND);
        echo json_encode([
            "status" => "success",
            "message" => "Login berhasil",
            "data" => [
                "user_id" => $user['id'],
                "username" => $user['username'],
            ],
        ]);
    } else {
        file_put_contents('debug.log', "Password salah untuk user: $username\n", FILE_APPEND);
        echo json_encode(["status" => "error", "message" => "Password salah, bro!"]);
    }
} else {
    file_put_contents('debug.log', "User tidak ditemukan: $username\n", FILE_APPEND);
    echo json_encode(["status" => "error", "message" => "Username nggak ketemu!"]);
}

$stmt->close();
$conn->close();
?>