<?php
header('Content-Type: application/json');

$keysFile = 'keys.json';  // Đường dẫn tới file keys.json lưu trên server
$input = json_decode(file_get_contents('php://input'), true);

if (!isset($input['userId']) || !isset($input['key'])) {
    echo json_encode(['success' => false, 'message' => 'Thiếu thông tin']);
    exit;
}

$userId = $input['userId'];
$key = $input['key'];

// Đọc danh sách key hiện có
if (!file_exists($keysFile)) {
    echo json_encode(['success' => false, 'message' => 'Không tìm thấy dữ liệu key']);
    exit;
}

$keys = json_decode(file_get_contents($keysFile), true);

$found = false;

foreach ($keys as &$k) {
    if ($k['key'] === $key) {
        $found = true;

        if ($k['used']) {
            echo json_encode(['success' => false, 'message' => 'Key đã sử dụng']);
            exit;
        }

        // Đánh dấu key đã dùng
        $k['used'] = true;
        $k['usedBy'] = $userId;

        file_put_contents($keysFile, json_encode($keys, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));

        echo json_encode(['success' => true, 'message' => 'Key hợp lệ']);
        exit;
    }
}

if (!$found) {
    echo json_encode(['success' => false, 'message' => 'Key không tồn tại']);
    exit;
}
