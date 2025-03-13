<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="PaymentApp.Chat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chat with Members</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .chat-container {
            width: 50%;
            margin: auto;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .chat-box {
            height: 300px;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 10px;
            background: #e9ecef;
            border-radius: 5px;
        }
        .message {
            padding: 8px 12px;
            margin: 5px 0;
            border-radius: 15px;
        }
        .message.sent {
            background: #28a745;
            color: white;
            text-align: right;
        }
        .message.received {
            background: #007bff;
            color: white;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="chat-container">
            <h3 class="text-center">Chat with Members</h3>
            <div id="chatBox" class="chat-box"></div>
            <div class="input-group mt-3">
                <input type="text" id="chatInput" class="form-control" placeholder="Type a message...">
                <div class="input-group-append">
                    <button class="btn btn-primary" onclick="sendMessage()">Send</button>
                </div>
                <asp:Panel ID="Panel1" runat="server" CssClass="chat-box"></asp:Panel>

            </div>
        </div>
    </div>

    <script>
        function sendMessage() {
            var message = $("#chatInput").val().trim();
            if (message === "") return;

            var messageHtml = '<div class="message sent">' + message + '</div>';
            $("#chatBox").append(messageHtml);
            $("#chatInput").val("");

            // Scroll to the latest message
            $("#chatBox").scrollTop($("#chatBox")[0].scrollHeight);
        }
    </script>
</body>
</html>
