<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="PaymentApp.Index" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment App - Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .nav-link {
            font-size: 16px;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            transition: 0.3s;
        }
        .card:hover {
            transform: scale(1.05);
        }
        /* Navbar Styling */
.navbar {
    padding: 15px;
    font-size: 16px;
}
.navbar .navbar-brand {
    font-size: 20px;
}
.navbar-nav .nav-item .nav-link {
    color: white !important;
    transition: 0.3s;
}
.navbar-nav .nav-item .nav-link:hover {
    background: rgba(255, 255, 255, 0.2);
    border-radius: 5px;
}

/* Dropdown Styling */
.dropdown-menu {
    background-color: #28a745;
}
.dropdown-item {
    color: white !important;
}
.dropdown-item:hover {
    background: rgba(255, 255, 255, 0.2);
}

    </style>
</head>
<body>
    <!-- Navigation Bar -->
   <nav class="navbar navbar-expand-lg navbar-dark bg-success shadow">
    <a class="navbar-brand font-weight-bold" href="Index.aspx">💰 Payment App</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <!-- Home -->
            <li class="nav-item"><a class="nav-link" href="Index.aspx"><i class="fas fa-home"></i> Home</a></li>
            
            <!-- QR & Payment -->
            <li class="nav-item"><a class="nav-link" href="Scanner.aspx"><i class="fas fa-qrcode"></i> QR Scanner</a></li>
            <li class="nav-item"><a class="nav-link" href="ScannerPay.aspx"><i class="fas fa-image"></i> Image Payment</a></li>
            
            <!-- Dropdown: Banking & Transfers -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="bankDropdown" role="button" data-toggle="dropdown">
                    <i class="fas fa-university"></i> Banking & Transfers
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="BankTransfer.aspx"><i class="fas fa-exchange-alt"></i> Bank Transfer</a>
                    <a class="dropdown-item" href="SelfTransfer.aspx"><i class="fas fa-user"></i> Self Transfer</a>
                    <a class="dropdown-item" href="Wallet.aspx"><i class="fas fa-wallet"></i> Wallet</a>
                    <a class="dropdown-item" href="AddMoney.aspx"><i class="fas fa-plus-circle"></i> Add Money</a>
                    <a class="dropdown-item" href="Withdraw.aspx"><i class="fas fa-money-bill-wave"></i> Withdraw Money</a>
                </div>
            </li>

            <!-- Dropdown: Payments -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="paymentsDropdown" role="button" data-toggle="dropdown">
                    <i class="fas fa-money-check-alt"></i> Payments
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="Payment.aspx"><i class="fas fa-credit-card"></i> Make Payment</a>
                    <a class="dropdown-item" href="Bills.aspx"><i class="fas fa-file-invoice"></i> Bill Payments</a>
                    <a class="dropdown-item" href="Recharge.aspx"><i class="fas fa-mobile-alt"></i> Mobile Recharge</a>
                    <a class="dropdown-item" href="Channels.aspx"><i class="fas fa-network-wired"></i> Payment Channels</a>
                    <a class="dropdown-item" href="Offers.aspx"><i class="fas fa-gift"></i> Offers & Cashback</a>
                </div>
            </li>

            <!-- History & Chat -->
            <li class="nav-item"><a class="nav-link" href="History.aspx"><i class="fas fa-history"></i> Transaction History</a></li>
            <li class="nav-item"><a class="nav-link" href="Chat.aspx"><i class="fas fa-comments"></i> Chat</a></li>

            <!-- Dropdown: Profile & Settings -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="profileDropdown" role="button" data-toggle="dropdown">
                    <i class="fas fa-user-circle"></i> Profile
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="Profile.aspx"><i class="fas fa-user"></i> My Profile</a>
                    <a class="dropdown-item" href="Settings.aspx"><i class="fas fa-cog"></i> Settings</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-danger" href="Logout.aspx"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </li>
        </ul>
    </div>
</nav>


    <!-- Main Content -->
    <div class="container text-center">
        <h2 class="text-success mt-4">Welcome to the Payment App</h2>
        <p class="lead">Select an option to proceed.</p>

        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card bg-light">
                    <div class="card-body text-center">
                        <h5 class="card-title">QR Scanner</h5>
                        <p class="card-text">Scan QR codes to make payments.</p>
                        <a href="Scanner.aspx" class="btn btn-success">Scan Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-light">
                    <div class="card-body text-center">
                        <h5 class="card-title">Bank Transfer</h5>
                        <p class="card-text">Transfer money to any bank.</p>
                        <a href="BankTransfer.aspx" class="btn btn-primary">Transfer Now</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card bg-light">
                    <div class="card-body text-center">
                        <h5 class="card-title">Mobile Recharge</h5>
                        <p class="card-text">Top-up your mobile instantly.</p>
                        <a href="Recharge.aspx" class="btn btn-warning">Recharge Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center mt-5 p-3 bg-success text-white">
        &copy; 2025 Payment App. All Rights Reserved.
    </footer>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
