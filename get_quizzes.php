<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");
header("Content-Type: application/json");

include 'config.php';

$category = isset($_GET['category']) ? $_GET['category'] : '';
$limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 10;

if ($category) {
    $sql = "SELECT * FROM quizzes WHERE category = ? ORDER BY RAND() LIMIT ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $category, $limit);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $sql = "SELECT * FROM quizzes ORDER BY RAND() LIMIT ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $limit);
    $stmt->execute();
    $result = $stmt->get_result();
}

$quizzes = [];
while ($row = $result->fetch_assoc()) {
    $quizzes[] = $row;
}
echo json_encode($quizzes);

if (isset($stmt)) $stmt->close();
$conn->close();
?>