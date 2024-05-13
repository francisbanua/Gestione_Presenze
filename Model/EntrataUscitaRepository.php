<?php

namespace Model;
use Cassandra\Time;
use Util\Connection;

class EntrataUscitaRepository
{
    public static function entrata($userId)
    {
        $time = date("y-m-d H:i:s");
        $pdo = Connection::getInstance();
        $sql = 'INSERT INTO presenza (id_utente, inizio_turno, orario_uscita, entrata, id_uscita)
                VALUES (:userId, :time, null, 1, null)';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'userId' => $userId,
            'time' => $time,
        ]);
    }

    public static function uscita($userId, $id_uscita)
    {
        $time = date("y-m-d H:i:s");
        $pdo = Connection::getInstance();
        $sql = 'UPDATE presenza 
            SET orario_uscita = :time, id_uscita = :id_uscita, entrata = 0
            WHERE id_utente = :userId AND orario_uscita IS NULL AND id_uscita IS NULL AND entrata = 1';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'userId' => $userId,
            'time' => $time,
            'id_uscita' => $id_uscita,
        ]);
    }

    public static function getMotivi()
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT * FROM uscita';
        $result = $pdo->query($sql);
        return $result->fetchAll();
    }

    public static function getEntrata($userId)
    {
        $pdo = Connection::getInstance();
        $sql = 'SELECT entrata FROM presenza WHERE id_utente = :userId AND orario_uscita IS NULL';
        $stmt = $pdo->prepare($sql);
        $stmt->execute([
            'userId' => $userId
        ]);
        return $stmt->fetch();
    }

    public static function getLastFive($userId)
    {
        $sql = 'SELECT inizio_turno, orario_uscita, motivo, TIMEDIFF(orario_uscita, inizio_turno) AS ore_lavorate
FROM presenza INNER JOIN uscita ON id_uscita = uscita.id
WHERE id_utente = :userid
ORDER BY inizio_turno DESC
LIMIT 0, 5';
        $pdo = Connection::getInstance();
        $stmt = $pdo->prepare($sql);
        $stmt->execute(['userid' => $userId]);
        return $stmt->fetchAll();
    }
}