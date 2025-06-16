<?php
header("Content-Type: application/json");
// Tambahkan header CORS
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include 'config.php';

$data = json_decode(file_get_contents("php://input"), true);
$username = $data['username'] ?? '';
$email = $data['email'] ?? '';
$password = password_hash($data['password'] ?? '', PASSWORD_DEFAULT);

// Tambahkan log untuk debugging
file_put_contents('debug.log', "Data diterima: " . json_encode($data) . "\n", FILE_APPEND);

// Validasi data
if (empty($username) || empty($email) || empty($data['password'])) {
    file_put_contents('debug.log', "Error: Data tidak lengkap\n", FILE_APPEND);
    echo json_encode(["status" => "error", "message" => "Isi semua kolom, bro!"]);
    exit;
}

// Cek apakah username atau email sudah ada
$checkSql = "SELECT * FROM users WHERE username = ? OR email = ?";
$checkStmt = $conn->prepare($checkSql);
$checkStmt->bind_param("ss", $username, $email);
$checkStmt->execute();
$checkResult = $checkStmt->get_result();

if ($checkResult->num_rows > 0) {
    $row = $checkResult->fetch_assoc();
    if ($row['username'] === $username) {
        file_put_contents('debug.log', "Error: Username $username sudah ada\n", FILE_APPEND);
        echo json_encode(["status" => "error", "message" => "Username $username sudah dipakai, bro!"]);
    } else {
        file_put_contents('debug.log', "Error: Email $email sudah ada\n", FILE_APPEND);
        echo json_encode(["status" => "error", "message" => "Email $email sudah dipakai, bro!"]);
    }
    $checkStmt->close();
    $conn->close();
    exit;
}
$checkStmt->close();

$sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $username, $email, $password);

if ($stmt->execute()) {
    file_put_contents('debug.log', "Registrasi sukses untuk user: $username\n", FILE_APPEND);
    echo json_encode(["status" => "success", "message" => "Akun jadi, bro!"]);
} else {
    $error = $conn->error;
    file_put_contents('debug.log', "Error: " . $error . "\n", FILE_APPEND);
    echo json_encode(["status" => "error", "message" => "Gagal bikin akun, coba lagi! Error: $error"]);
}
$stmt->close();
$conn->close();
?>