﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Pages_Error_Error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>400 - Bad Request</title>

    <style>
        body {
            margin: 0;
            font-size: .7em;
            font-family: Verdana, Arial, Helvetica, sans-serif;
            background: #EEEEEE;
        }

        fieldset {
            padding: 0 15px 10px 15px;
        }

        h1 {
            font-size: 2.4em;
            margin: 0;
            color: #FFF;
        }

        h2 {
            font-size: 1.7em;
            margin: 0;
            color: #CC0000;
        }

        h3 {
            font-size: 1.2em;
            margin: 10px 0 0 0;
            color: #000000;
        }

        #header {
            width: 96%;
            margin: 0 0 0 0;
            padding: 6px 2% 6px 2%;
            font-family: "trebuchet MS", Verdana, sans-serif;
            color: #FFF;
            background-color: #555555;
        }

        #content {
            margin: 0 0 0 2%;
            position: relative;
        }

        .content-container {
            background: #FFF;
            width: 96%;
            margin-top: 8px;
            padding: 10px;
            position: relative;
        }
    </style>
</head>
<body>
    <div id="content">
        <div class="content-container">
            <fieldset>
                <h2>400 - Bad Request.</h2>
                <h3>The server cannot process the request.</h3>
            </fieldset>
        </div>
    </div>
</body>
</html>
