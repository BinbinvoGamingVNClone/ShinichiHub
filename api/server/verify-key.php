<?php
header('Content-Type: application/json');

$keyDataFile = 'keyData.json';
$keyData = file_exists($keyDataFile) ? json_decode(file_get_contents($keyDataFile), true) : [];

// Nhận dữ liệu từ Roblox
$key = $_POST['key'] ?? '';
$hwid = $_POST['hwid'] ?? '';
$username = $_POST['username'] ?? '';

if (!$key || !$hwid || !$username) {
    die(json_encode(['status' => 'error', 'message' => 'Thiếu thông tin']));
}

if (!isset($keyData[$key])) {
    die(json_encode(['status' => 'error', 'message' => 'Key không tồn tại']));
}

$keyInfo = &$keyData[$key]

-- Nếu key chưa có chủ (reset rồi hoặc mới), lưu chủ mới
if (empty($keyInfo['owner'])) {
    $keyInfo['owner'] = $username
    $keyInfo['hwid'] = $hwid
    saveData($keyDataFile, $keyData)
    die(json_encode(['status' => 'success', 'message' => 'Key hợp lệ và đã liên kết']))
end

-- Nếu key có chủ, kiểm tra chủ và HWID
if ($keyInfo['owner'] ~= $username) {
    die(json_encode(['status' => 'error', 'message' => 'Key đã liên kết với người khác']))
end

if ($keyInfo['hwid'] ~= $hwid) {
    die(json_encode(['status' => 'error', 'message' => 'Key đã khóa với máy khác']))
end

echo json_encode(['status' => 'success', 'message' => 'Key hợp lệ'])

function saveData(file, data)
    file_put_contents(file, json_encode(data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE))
end
