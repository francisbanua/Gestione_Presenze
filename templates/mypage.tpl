<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Presenza</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff;
            color: #000;
            position: relative;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(34, 34, 59, 0.4);
        }

        .modal-content {
            background-color: #F2E9E4;
            border: 1px solid #22223B;
            border-radius: 5px;
            margin: 5% auto;
            padding: 20px;
            width: 80%;
            max-width: 500px;
            text-align: center;
        }

        .modal-content a {
            display: inline-block;
            margin: 5px;
        }

        .modal-content a:not(:last-child) {
            margin-right: 10px;
        }

        a.disabled {
            pointer-events: none;
            opacity: 0.5;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        a, input[type="submit"] {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            background-color: #9A8C98;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        a:hover, input[type="submit"]:hover {
            background-color: #4A4E69;
        }

        .table-container {
            margin: 0 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #C9ADA7;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #F2E9E4;
        }

        /* Toast styles */
        .toast {
            visibility: hidden;
            min-width: 250px;
            margin: auto;
            background-color: #9A8C98;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            transform: translateX(-50%);
        }

        .toast.show {
            visibility: visible;
            animation: fadeOut 1.5s ease forwards;
        }

        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
        }

        #clock {
            position: absolute;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 48px;
            font-weight: bold;
        }

        #closeButton {
            position: absolute;
            top: 0px;
            right: 20px;
            font-size: 24px;
            cursor: pointer;
            text-decoration: none;
            color: #fff;
        }

        h1 {
            margin-left: 20px;
        }

        @media screen and (max-width: 600px) {
            .modal-content {
                width: 90%;
            }
        }

    </style>
</head>
<body>

<h1>Benvenuto, <?=$displayed_name?></h1>

<a id="closeButton" href="index.php?action=logout">x</a>

<div id="clock"></div>

<br>
<br>

<div class="button-container">
    <a id="entraButton" onclick="openModal('entrata')" <?php if ($entrata) echo 'class="disabled"'; ?>>Entra</a>
    <a id="esciButton" onclick="openModal('uscita')" <?php if (!$entrata) echo 'class="disabled"'; ?>>Esci</a>
</div>

<div id="entrataModal" class="modal">
    <div class="modal-content">
        <p id="entrataMessage"></p>
        <a onclick="confirmAction('entrata')">Conferma</a>
        <a onclick="closeModal('entrata')">Annulla</a>
    </div>
</div>

<form action="index.php?action=uscita" method="post" id="uscitaForm">
    <div id="uscitaModal" class="modal">
        <div class="modal-content">
            <p id="uscitaMessage"></p>
            <select id="reason" name="motivo">
                <?php foreach($motivi as $m):?>
                <option value="<?=$m['id']?>"><?=$m['motivo']?></option>
                <?php endforeach;?>
            </select>
            <a onclick="confirmAction('uscita')">Conferma</a>
            <a onclick="closeModal('uscita')">Annulla</a>
        </div>
    </div>
</form>

<div id="toastMessage" class="toast"></div>

<div class="table-container">
    <table>
        <tr>
            <th>Entrata</th>
            <th>Uscita</th>
            <th>Lavorato</th>
        </tr>
        <?php foreach($ore as $o):?>
        <tr>
            <td><?=$o['inizio_turno']?></td>
            <td><?=$o['orario_uscita']?> (<?=$o['motivo']?>)</td>
            <td><?=$o['ore_lavorate']?></td>
        </tr>
        <?php endforeach;?>
    </table>
</div>

<script>
    function openModal(action) {
        var modal = document.getElementById(action + "Modal");
        modal.style.display = "block";

        var currentDate = new Date().toLocaleDateString();
        var currentTime = new Date().toLocaleTimeString();

        if (action === 'entrata') {
            document.getElementById("entrataMessage").innerHTML = "Sei sicuro di voler registrare un'entrata sul tuo libretto digitale per il giorno " + currentDate + " alle ore " + currentTime + "?";
        } else if (action === 'uscita') {
            document.getElementById("uscitaMessage").innerHTML = "Sei sicuro di voler registrare un'uscita sul tuo libretto digitale per il giorno " + currentDate + " alle ore " + currentTime + "?";
        }
    }

    function closeModal(action) {
        var modal = document.getElementById(action + "Modal");
        modal.style.display = "none";
    }

    function confirmAction(action) {
        var currentDate = new Date().toLocaleDateString();
        var currentTime = new Date().toLocaleTimeString();

        closeModal(action);

        var toastMessage = "Congratulazioni! Hai registrato la tua ";
        if (action === 'entrata') {
            toastMessage += "entrata";
        } else if (action === 'uscita') {
            toastMessage += "uscita";
        }
        toastMessage += " dalla sede per il giorno " + currentDate + " alle ore " + currentTime + ". Buona giornata!";
        var toast = document.getElementById('toastMessage');
        toast.innerHTML = toastMessage;
        toast.classList.add('show');

        setTimeout(function(){
            toast.classList.remove('show');
            redirectToAction(action);
        }, 1500);
    }

    function redirectToAction(action) {
        if (action === 'entrata') {
            window.location.href = 'index.php?action=entrata';
        } else if (action === 'uscita') {
            document.getElementById('uscitaForm').submit();
        }
    }

    function updateClock() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();
        var timeString = formatTime(hours) + ":" + formatTime(minutes) + ":" + formatTime(seconds);
        document.getElementById("clock").innerHTML = timeString;
        setTimeout(updateClock, 1000);
    }

    function formatTime(time) {
        return time < 10 ? "0" + time : time;
    }

    updateClock();
</script>
</body>
</html>