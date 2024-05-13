<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            color: #F2E9E4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 300px;
            padding: 20px;
            background-color: #F2E9E4;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #000000;
        }

        h1 {
            text-align: center;
            color: #4A4E69;
        }

        form {
            margin-top: 20px;
        }

        input[type="text"],
        input[type="password"],
        button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #9A8C98;
            border-radius: 5px;
            box-sizing: border-box;
            color: #4A4E69;
        }

        input[type="text"],
        input[type="password"] {
            outline: none;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #C9ADA7;
        }

        button {
            background-color: #9A8C98;
            color: #22223B;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #4A4E69;
            color: #F2E9E4;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>BMP Company</h1>
    <form action="index.php" method="post">
        <input type="text" name="username" placeholder="Username">
        <input type="password" name="password" placeholder="Password">
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>