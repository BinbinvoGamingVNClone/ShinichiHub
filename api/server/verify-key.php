<?php
header('Content-Type: application/json');

$keyDataFile = 'keyData.json';

// Đọc dữ liệu key
$keyData = file_exists($keyDataFile) ? json_decode(file_get_contents($keyDataFile), true) : [];

$userID = $_GET['userid'] ?? null;
$key = $_GET['key'] ?? null;

if (!$userID || !$key) {
    echo json_encode(["status" => "error", "message" => "Thiếu UserID hoặc Key"]);
    exit;
}

// Kiểm tra Key có hợp lệ không
if (!isset($keyData[$userID]) || $keyData[$userID]['key'] !== $key) {
    echo json_encode(["status" => "error", "message" => "Key không hợp lệ hoặc không khớp UserID"]);
    exit;
}

// Key hợp lệ, có thể thêm logic check "đã dùng hay chưa"
echo json_encode(["status" => "success", "message" => "Key hợp lệ"]);
