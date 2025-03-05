<?php
header('Content-Type: application/json');

$keyDataFile = 'keyData.json';
$premiumRoleId = '123456789012345678';  // Thay role premium thật vào
$cooldownFile = 'reset_cooldown.json';

// Tải dữ liệu key
$keyData = file_exists($keyDataFile) ? json_decode(file_get_contents($keyDataFile), true) : [];
$cooldowns = file_exists($cooldownFile) ? json_decode(file_get_contents($cooldownFile), true) : [];

// Nhận data từ request (POST từ bot)
$key = $_POST['key'] ?? '';
$userId = $_POST['userId'] ?? '';
$userRoles = isset($_POST['roles']) ? json_decode($_POST['roles'], true) : [];

if (!$key || !$userId || !$userRoles) {
    die(json_encode(['status' => 'error', 'message' => 'Thiếu thông tin']));
}

// Check có role premium không
$isPremium = in_array($premiumRoleId, $userRoles);

if (!$isPremium) {
    die(json_encode(['status' => 'error', 'message' => 'Bạn không có quyền sử dụng lệnh này']));
}

// Check cooldown
if (isset($cooldowns[$userId])) {
    $lastReset = $cooldowns[$userId];
    if (time() - $lastReset < 3600) {  // Cooldown 1 tiếng
        die(json_encode(['status' => 'error', 'message' => 'Vui lòng chờ 1 tiếng trước khi reset tiếp']));
    }
}

// Kiểm tra key có tồn tại
if (!isset($keyData[$key])) {
    die(json_encode(['status' => 'error', 'message' => 'Key không tồn tại']));
}

// Xóa owner và hwid (reset player)
$keyData[$key]['owner'] = '';
$keyData[$key]['hwid'] = '';
$cooldowns[$userId] = time();

// Lưu lại dữ liệu
file_put_contents($keyDataFile, json_encode($keyData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
file_put_contents($cooldownFile, json_encode($cooldowns, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));

echo json_encode(['status' => 'success', 'message' => 'Reset thành công']);
