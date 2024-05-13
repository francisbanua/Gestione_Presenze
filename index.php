<?php

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Util\Authenticator;

$template = new Engine('templates','tpl');

$user = Authenticator::getUser();

if ($user == null){
    echo $template->render('login');
    exit(0);
}

if (isset($_GET['action'])){
    if (($_GET['action']) == 'logout'){
        Authenticator::logout();
        echo $template->render('login');
        exit(0);
    }
    if (($_GET['action']) == 'entrata'){
        Model\EntrataUscitaRepository::entrata($user['id']);
    }
    if (($_GET['action']) == 'uscita'){
        Model\EntrataUscitaRepository::uscita($user['id'], (int)($_POST['motivo']));
    }
}

$displayed_name = $user['nome'] . ' ' . $user['cognome'];

$motivi = \Model\EntrataUscitaRepository::getMotivi();

$entrata = (int)(\Model\EntrataUscitaRepository::getEntrata($user['id']));

if ($entrata == null){
    $entrata = 0;
}

$ore = \Model\EntrataUscitaRepository::getLastFive($user['id']);

echo $template->render('mypage', [
    'displayed_name' => $displayed_name,
    'motivi' => $motivi,
    'entrata' => $entrata,
    'ore' => $ore
]);

