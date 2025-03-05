<?php
// Đường dẫn file lưu data key (giả sử data lưu trong JSON file, có thể đổi sang database nếu cần)
$keyFile = 'keyData.json';

// Load data key
if (!file_exists($keyFile)) {
    file_put_contents($keyFile, json_encode([]));
}
$keyData = json_decode(file_get_contents($keyFile), true);

// Lấy dữ liệu từ request
$input = json_decode(file_get_contents('php://input'), true);

if (!isset($input['userid'])) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Thiếu thông tin UserID'
    ]);
    exit;
}

$userId = $input['userid'];

// Tìm key đang gắn với user này
$keyFound = null;
foreach ($keyData as $key => $info) {
    if (isset($info['userId']) && $info['userId'] === $userId) {
        $keyFound = $key;
        break;
    }
}

// Nếu không tìm thấy key nào gắn với user này
if ($keyFound === null) {
    echo json_encode([
        'status' => 'error',
        'message' => 'Không tìm thấy key nào gắn với user này'
    ]);
    exit;
}

// Xóa liên kết UserID (reset người dùng)
$keyData[$keyFound]['userId'] = null;  // Cho phép user mới gắn
$keyData[$keyFound]['robloxId'] = null; // Nếu có lưu roblox id thì xóa luôn

// Lưu lại file
file_put_contents($keyFile, json_encode($keyData, JSON_PRETTY_PRINT));

// Trả kết quả
echo json_encode([
    'status' => 'success',
    'message' => 'Reset key thành công! Key có thể dùng lại với user mới.'
]);
