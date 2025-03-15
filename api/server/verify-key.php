<?php
header('Content-Type: application/json');

$keyFile = 'keyData.json';
$logFile = 'verify_log.json';

if (!file_exists($keyFile)) {
    echo json_encode(["status" => "error", "message" => "Không tìm thấy dữ liệu key."]);
    exit;
}

$keyData = json_decode(file_get_contents($keyFile), true);
$inputKey = isset($_POST['key']) ? trim($_POST['key']) : '';

if (!$inputKey) {
    echo json_encode(["status" => "error", "message" => "Vui lòng nhập key để xác minh."]);
    exit;
}

$userId = array_search($inputKey, array_column($keyData, 'key'));

if ($userId === false) {
    echo json_encode(["status" => "error", "message" => "Key không hợp lệ hoặc chưa được cấp."]);
    exit;
}

$logEntry = [
    "user_id" => $userId,
    "key" => $inputKey,
    "timestamp" => date('Y-m-d H:i:s'),
    "ip" => $_SERVER['REMOTE_ADDR']
];

$logData = file_exists($logFile) ? json_decode(file_get_contents($logFile), true) : [];
$logData[] = $logEntry;

file_put_contents($logFile, json_encode($logData, JSON_PRETTY_PRINT));

echo json_encode(["status" => "success", "message" => "Key hợp lệ!"]);
?>
