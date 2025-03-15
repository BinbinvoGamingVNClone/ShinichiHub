<?php
$keyFile = 'keyData.json';

if (!file_exists($keyFile)) {
    file_put_contents($keyFile, json_encode([]));
}
$keyData = json_decode(file_get_contents($keyFile), true);


$input = json_decode(file_get_contents('php://input'), true);

if (!isset($input['userid'])) {
    echo json_encode([
        'status' => 'error',
        'message' => 'UserID Not Found'
    ]);
    exit;
}

$userId = $input['userid'];


$keyFound = null;
foreach ($keyData as $key => $info) {
    if (isset($info['userId']) && $info['userId'] === $userId) {
        $keyFound = $key;
        break;
    }
}


if ($keyFound === null) {
    echo json_encode([
        'status' => 'error',
        'message' => 'User Not Have Key'
    ]);
    exit;
}


$keyData[$keyFound]['userId'] = null;
$keyData[$keyFound]['robloxId'] = null;


file_put_contents($keyFile, json_encode($keyData, JSON_PRETTY_PRINT));


echo json_encode([
    'status' => 'success',
    'message' => 'Reset key Valid!'
]);
