<?php
    session_start();

    if (!isset($_SESSION['form_submitted']) || !$_SESSION['form_submitted']) {
        header("Location: ../index.html");
        exit();
    }

    unset($_SESSION['form_submitted']);
?>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>heldernf</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Archivo:ital,wght@0,100..900;1,100..900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Archivo", sans-serif;
        }

        html {
            font-size: 62.5%;
        }

        body {
            background-color: #01040C;
            display: flex;
            align-items: center;
            flex-direction: column;
            padding: 3.5rem 0 0 0;
        }

        img {
            width: 19rem;
        }

        h1 {
            margin-top: 3.5rem;
            color: white;
            font-size: 2rem;
            text-align: center;
            font-weight: 700;
        }

        h1 span {
            color: #c92222;
        }

        a {
            margin-top: 4rem;
            background-color: #6A3ED4;
            color: #fff;
            text-decoration: none;
            padding: 1.4rem 2rem;
            border-radius: .3rem;
            font-size: 1.4rem;
            font-weight: 600;
            letter-spacing: .2rem;
            transition: .3s scale, box-shadow;
        }

        a:hover {
            scale: 1.03;
            box-shadow: 0 0 1.5rem #6b3ed449;
        }

        @media (min-width: 360px) {
            body {
                height: 100vh;
                justify-content: center;
                padding: 0;
            }

            img {
                width: 25rem;
            }

            h1 {
                font-size: 2.5rem;
                width: 31rem;
            }
        }
    </style>
</head>

<body>
    <img src="../assets/img/form-falha.svg" alt="">
    <h1>Ouve um <span>erro</span>, tente novamente mais tarde!</h1>
    <a href="../index.html">VOLTAR</a>
</body>

</html>