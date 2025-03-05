<?php
header('Content-Type: application/json');

// Load key data
$keyDataFile = 'keyData.json';
$keyData = file_exists($keyDataFile) ? json_decode(file_get_contents($keyDataFile), true) : [];

// Nhận dữ liệu từ LuaU gửi lên (POST request)
$key = $_POST['key'] ?? '';
$hwid = $_POST['hwid'] ?? '';
$username = $_POST['username'] ?? ''; // tên user Roblox

// Kiểm tra có đủ thông tin không
if (empty($key) || empty($hwid) || empty($username)) {
    die(json_encode(['status' => 'error', 'message' => 'Thiếu dữ liệu (key, hwid, username)']));
}

// Kiểm tra key có tồn tại không
if (!isset($keyData[$key])) {
    die(json_encode(['status' => 'error', 'message' => 'Key không tồn tại']));
}

// Lấy thông tin key
$keyInfo = &$keyData[$key];

// Nếu key chưa ai xài, lưu người xài đầu tiên vào
if (empty($keyInfo['owner'])) {
    $keyInfo['owner'] = $username;
    $keyInfo['hwid'] = $hwid;
    saveKeyData($keyDataFile, $keyData);
    logRequest($username, $key, $hwid, "Key mới được liên kết với người dùng");
    die(json_encode(['status' => 'success', 'message' => 'Key hợp lệ - liên kết thành công']));
}

// Nếu key đã có chủ, kiểm tra tên và HWID
if ($keyInfo['owner'] !== $username) {
    die(json_encode(['status' => 'error', 'message' => 'Tên người dùng không trùng khớp']));
}

if (!empty($keyInfo['hwid']) && $keyInfo['hwid'] !== $hwid) {
    die(json_encode(['status' => 'error', 'message' => 'HWID không hợp lệ - Key đã bị khóa với máy khác']));
}

// Key hợp lệ, trả về success
logRequest($username, $key, $hwid, "Xác minh thành công");
echo json_encode(['status' => 'success', 'message' => 'Key hợp lệ']);
exit;

// Hàm lưu keyData
function saveKeyData($file, $data) {
    file_put_contents($file, json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
}

// Hàm ghi log (tùy chọn, có thể bỏ nếu không cần)
function logRequest($username, $key, $hwid, $action) {
    $logFile = 'key_log.txt';
    $log = date('[Y-m-d H:i:s]') . " $username | Key: $key | HWID: $hwid | Action: $action\n";
    file_put_contents($logFile, $log, FILE_APPEND);
}
