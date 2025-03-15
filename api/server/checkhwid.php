<?php
header('Content-Type: application/json');

$databaseFile = 'hwid_data.json';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);
if (!isset($data['hwid'])) {
    echo json_encode(["status" => "error", "message" => "Missing HWID"]);
    exit;
}

$userHWID = $data['hwid'];

if (!file_exists($databaseFile)) {
    file_put_contents($databaseFile, json_encode([]));
}

$db = json_decode(file_get_contents($databaseFile), true);

// Kiểm tra HWID có tồn tại hay không
if (isset($db[$userHWID]) && $db[$userHWID] !== "") {
    echo json_encode(["status" => "success", "message" => "HWID hợp lệ"]);
    exit;
}

echo json_encode(["status" => "error", "message" => "HWID không hợp lệ"]);
exit;
?>
