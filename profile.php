<?php
// Tambah header CORS
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // Izinkan semua origin (ganti '*' dengan domain spesifik jika di production)
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // Izinkan metode HTTP
header('Access-Control-Allow-Headers: Content-Type, Authorization'); // Izinkan header

// Handle preflight request (OPTIONS)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$host = 'localhost';
$db = 'quizaja_db'; // Sesuaikan
$user = 'root';     // Sesuaikan
$pass = ''; // Sesuaikan

try {
    $conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $action = $_GET['action'] ?? '';

    if ($action === 'get') {
        $userId = $_GET['user_id'] ?? null;
        if (!$userId) {
            echo json_encode(['status' => 'error', 'message' => 'user_id diperlukan']);
            exit;
        }

        $stmt = $conn->prepare("SELECT username, email FROM users WHERE id = ?");
        $stmt->execute([$userId]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user) {
            echo json_encode(['status' => 'success', 'data' => $user]);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Pengguna tidak ditemukan']);
        }
    } elseif ($action === 'update') {
        $data = json_decode(file_get_contents('php://input'), true);
        $userId = $data['user_id'];
        $username = $data['username'];
        $email = $data['email'];
        $password = $data['password'] ? password_hash($data['password'], PASSWORD_BCRYPT) : null;

        $conn->beginTransaction();

        $query = "UPDATE users SET username = ?, email = ?" . ($password ? ", password = ?" : "") . " WHERE id = ?";
        $params = $password ? [$username, $email, $password, $userId] : [$username, $email, $userId];
        $stmt = $conn->prepare($query);
        $stmt->execute($params);

        $conn->commit();
        echo json_encode(['status' => 'success', 'message' => 'Profil berhasil diperbarui']);
    } elseif ($action === 'delete') {
        $data = json_decode(file_get_contents('php://input'), true);
        $userId = $data['user_id'];

        $conn->beginTransaction();

        $stmt1 = $conn->prepare("DELETE FROM scores WHERE user_id = ?");
        $stmt1->execute([$userId]);

        $stmt2 = $conn->prepare("DELETE FROM users WHERE id = ?");
        $stmt2->execute([$userId]);

        $conn->commit();
        echo json_encode(['status' => 'success', 'message' => 'Akun berhasil dihapus']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Aksi tidak valid']);
    }
} catch (PDOException $e) {
    if (isset($conn)) {
        $conn->rollBack();
    }
    echo json_encode(['status' => 'error', 'message' => 'Gagal: ' . $e->getMessage()]);
}
?>