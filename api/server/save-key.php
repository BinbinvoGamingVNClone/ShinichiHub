<?php
header('Content-Type: application/json');

$keyDataFile = 'keyData.json';

// Đọc dữ liệu hiện tại
$keyData = file_exists($keyDataFile) ? json_decode(file_get_contents($keyDataFile), true) : [];

// Nhận dữ liệu từ bot gửi lên
$userID = $_POST['userid'] ?? null;
$key = $_POST['key'] ?? null;

if (!$userID || !$key) {
    echo json_encode(["status" => "error", "message" => "Thiếu UserID hoặc Key"]);
    exit;
}

// Lưu key vào file
$keyData[$userID] = [
    'key' => $key,
    'used' => false,  // Chưa dùng
    'created_at' => date('Y-m-d H:i:s')
];

file_put_contents($keyDataFile, json_encode($keyData, JSON_PRETTY_PRINT));

echo json_encode(["status" => "success", "message" => "Key đã được lưu"]);
